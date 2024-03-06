package fr.inote.inote_API.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

import fr.inote.inote_API.entity.Avis;
import fr.inote.inote_API.entity.User;
import fr.inote.inote_API.repository.AvisRepository;
import lombok.AllArgsConstructor;

@AllArgsConstructor
@Service
public class AvisService {
    
    @Autowired
    private final AvisRepository avisRepository;

    @SuppressWarnings("null")
    public void create(Avis avis){
        // On demande l'utilisateur qui est actuellement connecté depuis le contexte
        User mainUser = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        avis.setUser(mainUser);
        this.avisRepository.save(avis);
    }
}
