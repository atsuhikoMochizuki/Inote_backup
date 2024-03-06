package fr.inote.inote_API.controller;

import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestController;

import fr.inote.inote_API.entity.Avis;
import fr.inote.inote_API.service.AvisService;
import lombok.AllArgsConstructor;

@AllArgsConstructor
@RequestMapping("avis")
@RestController
public class AvisController {
    private final AvisService avisService;

    @ResponseStatus(HttpStatus.CREATED)
    @PostMapping
    public void creer(@RequestBody Avis avis){
        this.avisService.create(avis);
    }
}
