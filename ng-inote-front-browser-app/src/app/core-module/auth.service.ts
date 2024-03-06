import { Injectable } from '@angular/core';
import { Observable, delay, of, tap } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class AuthService {

  isLoggedIn: boolean = false;
  redirectUrl!: string;

  demoEmail:string = 'a@a.com';
  demoPassword:string = 'a';

  login(email: string, password: string): Observable<boolean> {

    /****SIMULATION*********/
    const isLoggedIn = (email == this.demoEmail && password == this.demoPassword);
    return of(isLoggedIn)
      .pipe(
        delay(1000),
        tap((isLoggedIn) => this.isLoggedIn = isLoggedIn)
      );

    // Envoyer requête d'identification au serveur
  }

  logout() {
    this.isLoggedIn = false;
  }
}
