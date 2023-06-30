package com.xpeho.yaki_admin_backend.data.services;

import com.xpeho.yaki_admin_backend.configSecurity.JwtService;
import com.xpeho.yaki_admin_backend.data.models.UserModel;
import com.xpeho.yaki_admin_backend.data.sources.UserJpaRepository;
import com.xpeho.yaki_admin_backend.domain.entities.AuthenticationRequestEntity;
import com.xpeho.yaki_admin_backend.domain.entities.AuthenticationResponseEntity;
import com.xpeho.yaki_admin_backend.domain.entities.RegisterRequestEntity;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.crypto.password.PasswordEncoder;

import java.util.Optional;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
public class AuthenticationServiceImplTest {
    @Mock
    private AuthenticationManager authenticationManager;
    @Mock
    private UserJpaRepository repository;
    @Mock
    private JwtService jwtService;
    @Mock
    private PasswordEncoder passwordEncoder;

    @InjectMocks
    private AuthenticationServiceImpl authenticationServiceImpl;

    @BeforeEach
    void setUp() {
        repository = mock(UserJpaRepository.class);
        authenticationServiceImpl = new AuthenticationServiceImpl(repository, jwtService, authenticationManager, passwordEncoder);
    }

    @Test
    void testRegister() {
        // Mock input
        RegisterRequestEntity request = new RegisterRequestEntity("Vache", "Quirit", "vachequirit", "vachequirit@example.com", "encodedPassword");

        // Mock repository save
        UserModel savedUser = new UserModel("Vache", "Quirit", "vachequirit@example.com", "vachequirit", "encodedPassword");
        when(repository.save(any(UserModel.class))).thenReturn(savedUser);

        // Mock jwtService.generateToken
        String jwtToken = "mockedJwtToken";
        when(jwtService.generateToken(savedUser)).thenReturn(jwtToken);

        // Perform the register operation
        AuthenticationResponseEntity response = authenticationServiceImpl.register(request);

        // Verify the save method was called with the correct user
        verify(repository).save(argThat(user -> user.getLastName().equals("Vache")
                && user.getFirstName().equals("Quirit")
                && user.getEmail().equals("vache.quirit@example.com")
                && user.getLogin().equals("vachequirit")
                && user.getPassword().equals("encodedPassword")));

        // Verify the jwtService.generateToken was called with the correct user
        verify(jwtService).generateToken(savedUser);

        // Verify the response contains the expected values
        assertEquals(jwtToken, response.token());
        assertEquals(savedUser.getUserId(), response.id());
    }

    @Test
    void testAuthenticate() {
        // Mock input
        AuthenticationRequestEntity request = new AuthenticationRequestEntity("password", "vachequirit");

        // Mock authenticationManager.authenticate
        when(authenticationManager.authenticate(any(UsernamePasswordAuthenticationToken.class))).thenReturn(null);

        // Mock repository findByLogin
        UserModel user = new UserModel("Vache", "Quirit", "vachequirit.doe@example.com", "vachequirit", "encodedPassword");
        when(repository.findByLogin(request.login())).thenReturn(Optional.of(user));

        // Mock jwtService.generateToken
        String jwtToken = "mockedJwtToken";
        when(jwtService.generateToken(user)).thenReturn(jwtToken);

        // Perform the authenticate operation
        AuthenticationResponseEntity response = authenticationServiceImpl.authenticate(request);

        // Verify the authenticationManager.authenticate was called with the correct parameters
        verify(authenticationManager).authenticate(argThat(authenticationToken ->
                authenticationToken.getPrincipal().equals("vachequirit")
                        && authenticationToken.getCredentials().equals("password")));
        // Verify the repository.findByLogin was called with the correct login
        verify(repository).findByLogin("vachequirit");

        // Verify the jwtService.generateToken was called with the correct user
        verify(jwtService).generateToken(user);

        // Verify the response contains the expected values
        assertEquals(jwtToken, response.token());
        assertEquals(user.getUserId(), response.id());
    }
}
