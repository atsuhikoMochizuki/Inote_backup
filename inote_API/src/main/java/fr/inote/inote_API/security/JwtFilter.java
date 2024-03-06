package fr.inote.inote_API.security;

import java.io.IOException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Service;
import org.springframework.web.filter.OncePerRequestFilter;

import fr.inote.inote_API.service.UserService;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Service
public class JwtFilter extends OncePerRequestFilter {
    @Autowired
    private UserService userService;

    @Autowired
    private JwtService jwtService;

    @SuppressWarnings("null")
    @Override
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain)
            throws ServletException, IOException {

        String username = null;
        String token = null;
        boolean isTokenExpired = true;

        // Récupération du jeton
        final String authorization = request.getHeader("Authorization");
        if (authorization != null && authorization.startsWith("Bearer ")) {
            // La chaine reçue dans le header va être du type : Bearer : UBJUV88..... Il
            // faut donc enlever
            // les 7 premiers caractères
            token = authorization.substring(7);

            jwtService.isTokenExpired(token);

            // Récupération du username
            username = this.jwtService.extractUserName(token);
        }

        // Si pour l'instant aucune authentification n'a été effectuée et que le token
        // n'a pas expiré
        if (isTokenExpired && username != null && SecurityContextHolder.getContext().getAuthentication() == null) {

            // Récupération de l'utilisateur
            UserDetails userDetails = userService.loadUserByUsername(username);

            // Création d'un donnée d'authentification pour le contexte
            UsernamePasswordAuthenticationToken authenticationToken = new UsernamePasswordAuthenticationToken(
                    userDetails, null, userDetails.getAuthorities());

            // Transmission de cette donnée au contexte
            SecurityContextHolder.getContext().setAuthentication(authenticationToken);
        }

        // On indique à la chaine de filtre qu'elle peut continuer à filter si d'autres
        // filtres suivent
        filterChain.doFilter(request, response);
    }
}
