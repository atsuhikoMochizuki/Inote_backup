import { Component } from '@angular/core';

@Component({
  selector: 'app-page-not-found-component',
  template: `
    <div class = "container text-center mt-5 p-5">
    <img src="../../assets/404.png" alt="image page non trouvée">
    <h1 class="ms-5">La page demandée n'existe pas</h1>
    <a routerLink="/users">
        Retourner à l' accueil
      </a>
  </div>
    `
})
export class PageNotFoundComponentComponent {}
