package fr.inote.inote_API.service;

import java.time.Instant;
import java.util.Random;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import fr.inote.inote_API.entity.User;
import fr.inote.inote_API.entity.Validation;
import fr.inote.inote_API.repository.ValidationRepository;


import static java.time.temporal.ChronoUnit.MINUTES;

@Service
public class ValidationService {

    @Autowired
    private ValidationRepository validationRepository;

    @Autowired
    private NotificationService notificationService;

    //Enregistrement de la validation
    public void save(User user) {

        Validation validation = new Validation();
        validation.setUser(user);

        //Date et heure de création
        Instant creation = Instant.now();
        validation.setCreation(creation);

        // Date et heure d'expiration
        Instant expiration = creation.plus(10, MINUTES);
        validation.setExpiration(expiration);

        // génération du code de validation
        Random random = new Random();
        int randomNumber = random.nextInt(9999);
        String code = String.format("%06d", randomNumber);
        validation.setCode(code);

        //Enregistrement de la validation
        this.validationRepository.save(validation);

        //Envoi du mail à l'utilisateur
        this.notificationService.sendNotificationWhenValidationOperation(validation);
    }

    public Validation readAccordingToCode(String code){
        return this.validationRepository.findByCode(code).orElseThrow(() -> new RuntimeException("Votre code est invalide"));
    }
}
