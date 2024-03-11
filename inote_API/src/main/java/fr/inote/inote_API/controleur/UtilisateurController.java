package fr.inote.inote_API.controleur;

import java.util.List;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import lombok.AllArgsConstructor;
import fr.inote.inote_API.entite.Utilisateur;
import fr.inote.inote_API.service.UtilisateurService;

@AllArgsConstructor
@RequestMapping("utilisateurs")
@RestController
public class UtilisateurController {

    UtilisateurService utilisateurService;

    @PreAuthorize("hasAuthority('ADMINISTRATEUR_READ')") // Seuls les admins ont la permission
    @GetMapping
    public List<Utilisateur> liste() {
        return this.utilisateurService.liste();
    }
}
