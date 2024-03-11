package fr.inote.inote_API.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import fr.inote.inote_API.entite.Avis;

public interface AvisRepository extends JpaRepository<Avis, Integer> {
}
