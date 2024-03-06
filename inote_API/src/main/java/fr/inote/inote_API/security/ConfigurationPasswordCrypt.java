package fr.inote.inote_API.security;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;

/**
 * Comme le cryptage est utilisé par plusieurs éléments,
 * cela crée des références circulaires.
 * Nous créeons donc une configuration externe pour que tous les
 * éléments puisse profiter du cryptage sans conflit
 */
@Configuration
public class ConfigurationPasswordCrypt {

    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }
}
