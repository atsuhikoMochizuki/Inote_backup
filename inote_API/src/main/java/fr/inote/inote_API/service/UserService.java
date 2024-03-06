package fr.inote.inote_API.service;

import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import java.time.Instant;
import java.util.Map;
import java.util.Optional;

import fr.inote.inote_API.entity.Role;
import fr.inote.inote_API.entity.User;
import fr.inote.inote_API.entity.Validation;
import fr.inote.inote_API.enums.TypeOfRole;
import fr.inote.inote_API.repository.UserRepository;

@Service
public class UserService implements UserDetailsService {

    // Injection du repository pour la manipulation en base
    @Autowired
    private UserRepository userRepository;

    // Injection des dépendances pour l'encodage
    @Autowired
    private PasswordEncoder passwordEncoder;

    // Injection du service de validation
    @Autowired
    private ValidationService validationService;

    public void inscription(User user) {
        /* Validation de l'email */
        if (!user.getEmail().contains("@")) {
            throw new RuntimeException("Invalid email");
        }
        Optional<User> userOptional = this.userRepository.findByEmail(user.getEmail());
        if (userOptional.isPresent()) {
            throw new RuntimeException("Existing email");
        }

        /* Cryptage du mot de passe */
        String cryptedPwd = this.passwordEncoder.encode(user.getPassword());
        user.setPwd(cryptedPwd);

        /* Affectation du rôle */
        Role userRole = new Role();
        userRole.setName(TypeOfRole.USER);
        user.setRole(userRole);

        /* Enregistrement de l'utilisateur */
        user = this.userRepository.save(user);

        this.validationService.save(user);
    }

    /**
     * Active l'utilisateur
     * 
     * @param activation
     */
    public void activation(Map<String, String> activation) {

        Validation validation = this.validationService.readAccordingToCode(activation.get("code"));
        if (Instant.now().isAfter(validation.getExpiration())) {
            throw new RuntimeException("Votre code a expiré");
        }

        @SuppressWarnings("null")
        User activatedUser = this.userRepository.findById(validation.getUser().getId())
                .orElseThrow(() -> new RuntimeException("Unknow user"));

        // Autorisation de l'utilisateur
        activatedUser.setActive(true);
        this.userRepository.save(activatedUser);
    }

    @Override
    public User loadUserByUsername(String username) throws UsernameNotFoundException {
        return this.userRepository.findByEmail(username)
                .orElseThrow(() -> new UsernameNotFoundException("none user found with this email"));
    }
}
