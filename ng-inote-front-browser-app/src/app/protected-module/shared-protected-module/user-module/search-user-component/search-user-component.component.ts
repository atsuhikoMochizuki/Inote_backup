import { Component } from '@angular/core';
import { faCoffee, faMagnifyingGlass } from '@fortawesome/free-solid-svg-icons';
import { Observable, Subject, debounceTime, distinctUntilChanged, switchMap } from 'rxjs';
import { User } from '../user';
import { Router } from '@angular/router';
import { UserService } from '../user.service';

@Component({
  selector: 'app-search-user-component',
  templateUrl: './search-user-component.component.html',
  styles: ``
})
export class SearchUserComponentComponent {
  faCoffee = faCoffee;
  faMagnifyingGlass = faMagnifyingGlass;


  /* Permet de stocker les recherches successives de
  l'utilisateur (flux dans le temps des recherches 
  de l'utilisateur) 
  ex: {..."a"..."ab"...."abc"...}
  Nota : Subject se comporte comme un Observable, à la différence
  qu'un Observable ne fait que consommer un flux de données.
  Un Subject permet en plus de construire ce flux de données*/
  searchTerm = new Subject<string>();

  users$ = new Observable<User[]>();
  constructor(
    private router: Router,
    private userService: UserService) { }

  ngOnInit(): void {
    this.users$ = this.searchTerm.pipe(
      // {a...ab..abz..ab..abc......}
      // On va éliminer les recherches qui n'ont pas un certain temps
      // écoulé après leur frappes au clavier pour éviter de soliiciter
      // inutilement le serveur
      debounceTime(300), // si le caractère est entré moins de 300ms avant le précédent, on le fait sauter

      //{..ab..ab..abc}
      // On va éliminer les termes de recherche consécutifs
      distinctUntilChanged(),

      //{ab...abc...}
      // On peut maintenant effectuer la requête, on veut lancer la recherche la 
      // plus récente que l'utilisateur a demandé, grâce à switchMap().
      // A l'instar de map() qui renverrai un flux (Observable) d'utilisateur, il va 
      // déjà renvoyer directement les utilisateurs.
      switchMap((term) => this.userService.getUserList())
      //{....userList(ab)....userList(abc)...}
    );
  }

  search(term: string) {
    /* Lorsque la fonction est appelée, lors d'une recherche, elle
       elle va pousser le terme de recherche dans le Subject.
       => équivalent de push pour un array, mais pour un flux de données*/
    this.searchTerm.next(term)
  }

  goToDetailUser(user: User) {
    const link = ['/user', user.id];
    this.router.navigate(link);
  }
}
