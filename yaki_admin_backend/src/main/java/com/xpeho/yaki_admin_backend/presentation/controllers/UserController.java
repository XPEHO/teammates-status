package com.xpeho.yaki_admin_backend.presentation.controllers;

import com.xpeho.yaki_admin_backend.domain.entities.TeammateEntity;
import com.xpeho.yaki_admin_backend.data.models.UserModel;
import com.xpeho.yaki_admin_backend.domain.entities.UserEntity;
import com.xpeho.yaki_admin_backend.domain.entities.UserEntityIn;
import com.xpeho.yaki_admin_backend.domain.entities.UserEntityWithID;
import com.xpeho.yaki_admin_backend.domain.services.UserService;
import io.swagger.v3.oas.annotations.security.SecurityRequirement;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@CrossOrigin
@RestController
@RequestMapping("/users")
@SecurityRequirement(name = "bearerAuth")
public class UserController {
    private final UserService userService;

    public UserController(UserService userService) {
        this.userService = userService;
    }

    @PostMapping
    public UserEntity createUser(@RequestBody UserEntityIn userEntity) {
        return userService.save(userEntity);
    }
    @DeleteMapping("{id}")
    public UserEntity deleteUser(@PathVariable int id) {
        return userService.deleteById(id);
    }
    @GetMapping("/inRange")
    public List<UserEntityWithID> FindUserByIdRange(@RequestParam int idStart,
                                                    @RequestParam int idEnd) {
        return userService.FindUserByIdRange(idStart, idEnd);
    }
}
