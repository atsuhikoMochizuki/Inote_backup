package fr.inote.inote_API.repository;

import org.springframework.data.repository.CrudRepository;
import fr.inote.inote_API.entite.Validation;

import java.time.Instant;
import java.util.Optional;

public interface ValidationRepository extends CrudRepository<Validation, Integer> {

    Optional<Validation> findByCode(String code);
    void deleteAllByExpirationBefore(Instant now);
}
