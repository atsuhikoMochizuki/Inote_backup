package fr.inote.inote_API.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

import fr.inote.inote_API.entity.Validation;

@Service
public class NotificationService {
    
    @Autowired
    JavaMailSender javaMailSender;

    public void sendNotificationWhenValidationOperation(Validation validation){

        SimpleMailMessage mailMessage= new SimpleMailMessage();
        
        // Ajout de l'expéditeur
        mailMessage.setFrom("no-reply@inote.fr");

        // ajout de l'utilisateur en tant que destinataire
        mailMessage.setTo(validation.getUser().getEmail());

        // ajout de l'objet du message
        mailMessage.setSubject("Votre code d'activation");

        String texte = String.format("Bonjour %s, votre code d'activation est %s",
        validation.getUser().getName(),
        validation.getCode());

        mailMessage.setText(texte);
        javaMailSender.send(mailMessage);
    }
}
