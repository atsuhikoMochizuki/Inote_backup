package fr.inote.inote_API.repository;

import org.springframework.data.repository.CrudRepository;


import java.util.Optional;

import fr.inote.inote_API.entity.User;

public interface UserRepository extends CrudRepository<User, Integer>{
    Optional<User> findByEmail(String email);
}
