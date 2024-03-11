package fr.inote.inote_API;

import java.util.Collection;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;

import lombok.AllArgsConstructor;
import lombok.Getter;

@AllArgsConstructor
public enum TypeDeRole {
    
    // Permissions de l'utilisateur
    UTILISATEUR(Set.of(TypePermission.UTILISATEUR_CREATE_AVIS)),

    // Permissions de l'administrateur
    ADMINISTRATEUR(Set.of(TypePermission.ADMINISTRATEUR_CREATE,
            TypePermission.ADMINISTRATEUR_READ,
            TypePermission.ADMINISTRATEUR_UPDATE,
            TypePermission.ADMINISTRATEUR_DELETE,
            TypePermission.MANAGER_CREATE,
            TypePermission.MANAGER_READ,
            TypePermission.MANAGER_UPDATE,
            TypePermission.MANAGER_DELETE_AVIS)),

    // Permissions du manager
    MANAGER(Set.of(TypePermission.MANAGER_CREATE,
            TypePermission.MANAGER_READ,
            TypePermission.MANAGER_UPDATE,
            TypePermission.MANAGER_DELETE_AVIS));

    @Getter
    Set<TypePermission> permissions;

    public Collection<? extends GrantedAuthority> getAuthorities() {
        
        // The stream() method in Java is used to represent a sequence of elements that
        // support various methods which can be pipeline to produce the desired result.
        // It provides a functional way to process collections and arrays.
        
        //Ici, chaque valeur de l'enum dans le set, rempli en fonction du type de rôle, est transformée
        // en authorisation. Toutes les autorisations associé au type de role sont placées dans une liste d'authorisations.
        // On rajoute pour finir, une authorisation avec le nom du type de role
        List<SimpleGrantedAuthority> grantedAuthorities = 
            this.getPermissions()   // Récupérations du Set en fonction du type de rôle
            .stream()               // Transformation en flux pour pouvoir itérer dessus
            .map(                   // Chaque valeur du flux est transformée en permission et ajoutée à une liste
                permission -> new SimpleGrantedAuthority(permission.name())).collect(Collectors.toList());
                
            grantedAuthorities.add(new SimpleGrantedAuthority("ROLE_" + this.name()));

        return grantedAuthorities;
    }
}
