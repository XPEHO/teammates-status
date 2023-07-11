package com.xpeho.yaki_admin_backend.data.services;

import com.xpeho.yaki_admin_backend.configSecurity.JwtService;
import com.xpeho.yaki_admin_backend.data.models.UserModel;
import com.xpeho.yaki_admin_backend.data.models.VerificationTokenModel;
import com.xpeho.yaki_admin_backend.data.sources.UserJpaRepository;
import com.xpeho.yaki_admin_backend.domain.entities.AuthenticationRequestEntity;
import com.xpeho.yaki_admin_backend.domain.entities.AuthenticationResponseEntity;
import com.xpeho.yaki_admin_backend.domain.entities.RegisterRequestEntity;
import com.xpeho.yaki_admin_backend.domain.services.AuthenticationService;
import com.xpeho.yaki_admin_backend.events.OnRegistrationCompleteEvent;
import org.springframework.context.ApplicationEventPublisher;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.Calendar;

@Service
public class AuthenticationServiceImpl implements AuthenticationService {
    private final UserJpaRepository repository;
    private final JwtService jwtService;
    private final AuthenticationManager authenticationManager;
    private final PasswordEncoder passwordEncoder;
    private final VerificationTokenServiceImpl verificationTokenService;
    private final ApplicationEventPublisher eventPublisher;

    public AuthenticationServiceImpl(UserJpaRepository repository, JwtService jwtService, AuthenticationManager authenticationManager
            , PasswordEncoder passwordEncoder, VerificationTokenServiceImpl verificationTokenService, ApplicationEventPublisher eventPublisher){
        this.repository = repository;
        this.jwtService = jwtService;
        this.authenticationManager = authenticationManager;
        this.passwordEncoder = passwordEncoder;
        this.verificationTokenService = verificationTokenService;
        this.eventPublisher = eventPublisher;
    }

    @Override
    public AuthenticationResponseEntity register(RegisterRequestEntity request) {
        UserModel user = new UserModel(
                request.lastname(),
                request.firstname(),
                request.email(),
                request.login(),
                passwordEncoder.encode(request.password()));
        repository.save(user);
        //not sure I need it does it is used to be redirected without logging in ?
        eventPublisher.publishEvent(new OnRegistrationCompleteEvent(user));
        var jwtToken = jwtService.generateToken(user);
        return new AuthenticationResponseEntity(jwtToken, user.getUserId());
    }

    @Override
    public AuthenticationResponseEntity authenticate(AuthenticationRequestEntity request) {
        authenticationManager.authenticate(
                new UsernamePasswordAuthenticationToken(
                        request.login(),
                        request.password()
                )
        );
        UserModel user = repository.findByLogin(request.login())
                .orElseThrow();
        var jwtToken = jwtService.generateToken(user);
        return new AuthenticationResponseEntity(jwtToken, user.getUserId());
    }

    @Override
    public boolean confirmRegister(String token) {
        VerificationTokenModel verificationToken = verificationTokenService.getVerificationToken(token);
        if(verificationToken == null){
            return false;
        }
        UserModel user = verificationToken.getUser();
        Calendar cal = Calendar.getInstance();
        //if the token has expired
        if ((verificationToken.getExpiryDate().getTime() - cal.getTime().getTime()) <= 0) {
            return false;
        }
        user.setEnabled(true);
        repository.save(user);
        return true;
    }
}
