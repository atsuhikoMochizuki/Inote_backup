package fr.inote.inote_API.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;


import fr.inote.inote_API.dto.AuthenticationDto;
import fr.inote.inote_API.entity.User;
import fr.inote.inote_API.security.JwtService;
import fr.inote.inote_API.service.UserService;


@RestController
@RequestMapping(consumes = MediaType.APPLICATION_JSON_VALUE)
public class UserController {

    @Autowired
    private AuthenticationManager authenticationManager;
    @Autowired
    private UserService userService;
    @Autowired
    private JwtService jwtService;
    
    @PostMapping(path="subscribe")
    public void subscribe(@RequestBody User user){
        this.userService.inscription(user);
    }

    @PostMapping(path="activation")
    public void activation(@RequestBody Map<String,String> activation){
        this.userService.activation(activation);
    }

    @PostMapping(path="login")
    public Map<String,String> login(@RequestBody AuthenticationDto authenticationDto){
        final Authentication authentication = authenticationManager.authenticate(new UsernamePasswordAuthenticationToken(authenticationDto.username(), authenticationDto.password()));
        
        if(authentication.isAuthenticated()) {
            return this.jwtService.generateToken(authenticationDto.username());
        }
        return null;
    }   
}
