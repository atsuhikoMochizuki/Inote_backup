package fr.inote.inote_API.security;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.dao.DaoAuthenticationProvider;
import org.springframework.security.config.annotation.authentication.configuration.AuthenticationConfiguration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configurers.AbstractHttpConfigurer;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;

import static org.springframework.http.HttpMethod.POST;

import org.springframework.beans.factory.annotation.Autowired;


@Configuration
@EnableWebSecurity
public class ConfigurationSecurityApplication {

    @Autowired
    PasswordEncoder passwordEncoder;
    
    @Autowired
    private JwtFilter jwtFilter;
   
    /*
     * SecurityFilterChain est un bean qui permet à spring d'avoir les
     * configurations
     * de la sécurité du projet
     */
    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity httpSecurity) throws Exception {
        return httpSecurity
                .csrf(AbstractHttpConfigurer::disable) // Désactive la protection cross-site request forgery

                /* Authorisation des requêtes dans l'application */
                .authorizeHttpRequests(authorize ->
                // Autorisation de l'inscription : on permet ici un accès illimité sans
                // necessiter d'authentification
                // et d'autorisation sur une requête POST sur le endPoint 'subscribe'
                authorize
                        .requestMatchers(POST, "/subscribe").permitAll()
                        .requestMatchers(POST, "/activation").permitAll()
                        .requestMatchers(POST, "/login").permitAll()

                        // Toute autre requête necessite une authentification,sinon une réponse 401 sera
                        // retournée
                        .anyRequest().authenticated())
                .sessionManagement(httpSecuritySessionManagementConfigurer -> httpSecuritySessionManagementConfigurer
                        .sessionCreationPolicy(SessionCreationPolicy.STATELESS) // Sans état, on regarde le token à chaque fois

                )
                .addFilterBefore(this.jwtFilter, UsernamePasswordAuthenticationFilter.class)
                .build();
    }

    // Gestionnaire des authentifications (de la connexion)
    @Bean
    public AuthenticationManager authenticationManager(AuthenticationConfiguration authenticationConfiguration)
            throws Exception {
        return authenticationConfiguration.getAuthenticationManager();
    }

    // L'authentificationManager s'appuie sur l'AuthentificationProvider, qui lui
    // s'appuie sur la base de données
    @Bean
    public AuthenticationProvider authenticationProvider(UserDetailsService userDetailsService) {
        DaoAuthenticationProvider daoAuthenticationProvider = new DaoAuthenticationProvider();
        daoAuthenticationProvider.setUserDetailsService(userDetailsService);
        daoAuthenticationProvider.setPasswordEncoder(this.passwordEncoder);
        return daoAuthenticationProvider;
    }
}