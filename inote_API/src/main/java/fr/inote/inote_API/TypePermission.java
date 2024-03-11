package fr.inote.inote_API;

import lombok.Getter;
import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
public enum TypePermission {
    
    // L'administrateur peut exécuter toutes les opérations CRUD
    ADMINISTRATEUR_CREATE,
    ADMINISTRATEUR_READ,
    ADMINISTRATEUR_UPDATE,
    ADMINISTRATEUR_DELETE,

    // Le manager
    MANAGER_CREATE,
    MANAGER_READ,
    MANAGER_UPDATE,
    MANAGER_DELETE_AVIS, // Le manager ne peut supprimer que les avis

    // L'utilisateur
    UTILISATEUR_CREATE_AVIS;
    
    @Getter
    private String libelle;
}
