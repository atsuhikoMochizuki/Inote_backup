package fr.inote.inote_API;

import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.security.crypto.password.PasswordEncoder;

import lombok.AllArgsConstructor;

import fr.inote.inote_API.entite.Role;
import fr.inote.inote_API.entite.Utilisateur;
import fr.inote.inote_API.repository.UtilisateurRepository;

@AllArgsConstructor
@EnableScheduling
@SpringBootApplication
public class InoteApiApplication implements CommandLineRunner{

	UtilisateurRepository utilisateurRepository;
	PasswordEncoder passwordEncoder;
	public static void main (String[] args) {
		SpringApplication.run(InoteApiApplication.class, args);
	}

	@SuppressWarnings("null")
	@Override
	public void run(String... args) throws Exception {
		Utilisateur admin = Utilisateur.builder()
		.actif(true)
		.nom("admin")
		.mdp(passwordEncoder.encode("admin"))
		.email("vegeta@vegeta.veg")
		.role(
			Role.builder()
			.libelle(TypeDeRole.ADMINISTRATEUR)
			.build()
		)
		.build();
		admin = this.utilisateurRepository.findByEmail("vegeta@vegeta.veg")
		.orElse(admin);
		this.utilisateurRepository.save(admin);
		
		Utilisateur manager = Utilisateur.builder()
		.actif(true)
		.nom("manager")
		.mdp(passwordEncoder.encode("manager"))
		.email("bulma@capsule.corp")
		.role(
			Role.builder()
			.libelle(TypeDeRole.MANAGER)
			.build()
		)
		.build();

		manager = this.utilisateurRepository.findByEmail("bulma@capsule.corp")
		.orElse(manager);
		this.utilisateurRepository.save(manager);
	}
}
