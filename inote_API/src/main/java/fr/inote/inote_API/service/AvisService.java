package fr.inote.inote_API.service;

import lombok.AllArgsConstructor;

import java.util.List;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;
import fr.inote.inote_API.entite.Avis;
import fr.inote.inote_API.entite.Utilisateur;
import fr.inote.inote_API.repository.AvisRepository;

@AllArgsConstructor
@Service
public class AvisService {

    private final AvisRepository avisRepository;

    public void creer(Avis avis){
       Utilisateur utilisateur = (Utilisateur) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
       avis.setUtilisateur(utilisateur);
        this.avisRepository.save(avis);
    }

    public List<Avis> liste() {
        return this.avisRepository.findAll();
    }
}
