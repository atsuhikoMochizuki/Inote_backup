package fr.inote.inote_API.repository;

import org.springframework.data.repository.CrudRepository;
import fr.inote.inote_API.entite.Utilisateur;

import java.util.Optional;

public interface UtilisateurRepository extends CrudRepository<Utilisateur, Integer> {
    Optional<Utilisateur> findByEmail(String email);
}
