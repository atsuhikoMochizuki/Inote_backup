package fr.inote.inote_API.security;

import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import io.jsonwebtoken.io.Decoders;
import io.jsonwebtoken.security.Keys;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import fr.inote.inote_API.entity.User;
import fr.inote.inote_API.service.UserService;

import java.security.Key;
import java.util.Date;
import java.util.Map;
import java.util.function.Function;

@Service
public class JwtService {

    @Value("${encryptionKey}") // Recupération dans les propriétés
    private String ENCRYPTION_KEY;

    @Autowired
    private UserService userService;

    public Map<String, String> generateToken(String username) {
        // Récupération de l'utilisateur dans la base de données
        User user = this.userService.loadUserByUsername(username);
        return this.generateJwt(user);
    }

    public String extractUserName(String token) {
        return this.getClaim(token, Claims::getSubject);
    }

    /**
     * Control token expiration Status
     * 
     * @param token
     * @return
     */
    public boolean isTokenExpired(String token) {
        Date expirationDate = getExpirationDateFromToken(token);
        return expirationDate.before(new Date());
    }

    /**
     * Get informations in token
     * 
     * @param <T>
     * @param token
     * @param function
     * @return
     */
    private <T> T getClaim(String token, Function<Claims, T> function) {
        Claims claims = getAllClaims(token);
        return function.apply(claims);
    }

    /**
     * Get all informations payload of token
     * 
     * @param token
     * @return
     */
    private Claims getAllClaims(String token) {
        return Jwts.parserBuilder()
                .setSigningKey(this.getKey())
                .build()
                .parseClaimsJws(token)
                .getBody();
    }

    private Date getExpirationDateFromToken(String token) {
        return this.getClaim(token, Claims::getExpiration);
    }

    private Map<String, String> generateJwt(User user) {
        // Date de création du token
        final long currentTime = System.currentTimeMillis();
        // Date d'expiration du token (30 minutes après la création par exemple)
        final long expirationTime = currentTime + 30 * 60 * 1000; // en ms

        // Informations de l'utilisateur à intégrer au token
        final Map<String, Object> claims = Map.of(
                "nom", user.getName(),
                Claims.EXPIRATION, new Date(expirationTime),
                Claims.SUBJECT, user.getEmail());

        // bearer est un nom conventionnel pour désigner un JWT
        final String bearer = Jwts.builder()
                // insertion Date de création du token
                .setIssuedAt(new Date(currentTime))
                // insertion heure d'expiration
                .setExpiration(new Date(expirationTime))
                // Sujet pour lequel le token est généré
                .setSubject(user.getEmail())
                // Intégration des informations de l'utilisateur
                .setClaims(claims)
                // Définition l'algorithme de signature
                .signWith(getKey(), SignatureAlgorithm.HS256)
                .compact();// Pour générer la String
        return Map.of("bearer", bearer);
    }

    /**
     * Generate a key
     * 
     * @return
     */
    private Key getKey() {
        final byte[] decoder = Decoders.BASE64.decode(ENCRYPTION_KEY);
        // génération de la clé
        return Keys.hmacShaKeyFor(decoder);
    }
}
