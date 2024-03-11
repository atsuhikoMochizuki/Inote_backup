package fr.inote.inote_API.entite;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.time.Instant;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name = "validation")
public class Validation {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;
    private Instant creation;
    private Instant expiration;
    private Instant activation;
    private String code;
    //On ne peut pas créer une Validation sans avoir crée un utilisateur au préalable (cascade MERGE)
    // On détache la liaison mais on garde l'utilisateur
    @ManyToOne(cascade = {CascadeType.DETACH, CascadeType.MERGE})
    private Utilisateur utilisateur;

}
