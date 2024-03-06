import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable, catchError, of, tap } from 'rxjs';
import { User } from './user';

@Injectable()
export class UserService {

  constructor(
    private http:HttpClient
  ) { }

  getUserList(): Observable<User[]> {
    return this.http.get<User[]>('api/users') // Envoi de la requete HTTP et réception d'un observable
      .pipe(  //Applique des transformations sur les données directement dans le template
        tap(  //Effectue des actions sur les valeurs émises par l'observable, sans les modifier
          response => this.log(response)),
        // Si erreur, on logue l'erreur et on retourne un tableau vide pour éviter de faire planter l'application 
        catchError(error => this.handleError(error, []))
      );
  }

  getUserById(userId: number): Observable<User | undefined> {
    return this.http.get<User>(`api/users/${userId}`)
      .pipe(
        tap(response => this.log(response)),
        catchError(error => this.handleError(error, undefined))
      );
  }

  updateUser(user: User): Observable<null> {
    //Déclaration du header pour pouvoir y insérer les données
    const httpOptions = {
      headers: new HttpHeaders({ 'Content-Type': 'application/json' })
    };
    return this.http.put('api/users/', user, httpOptions).pipe(
      tap(response => this.log(response)),
      catchError(error => this.handleError(error, null))
    );
  }

  addUser(user: User): Observable<User> {
    const httpOptions = {
      headers: new HttpHeaders({ 'Content-Type': 'application/json' })
    };

    return this.http.post<User>('api/users', user, httpOptions)
      .pipe(
        tap(response => this.log(response)),
        catchError(error => this.handleError(error, null))
      );
  }

  deleteUserById(userId: number): Observable<null> {
    return this.http.delete(`api/users/${userId}`)
      .pipe(
        tap(response => this.log(response)),
        catchError(error => this.handleError(error, null))
      );
  }

  private log(response: any) {
    console.table(response);
  }

  private handleError(error: Error, errorValue: any) {
    console.error(error);
    return of(errorValue)
  }

  /* Pour des raisons de sécurité, il ne semble pas possible de pouvoir
  charger directement une image avec le chemin dans la machine hôte
  appartenant à l'utilisateur.
  Cette méthode récupère le contenu du fichier, pour ensuite pouvoir le manipuler*/
  loadUserAvatar(user: User) {
    if (!user.picture) {
      const imgElement = new Image();

      if (user.avatar) {
        imgElement.src = user.avatar;
        imgElement.alt = 'User profile image';
        user.picture = imgElement.src;
      } else {
        imgElement.src = '../assets/user.png';
        imgElement.alt = 'User profile image';
        user.picture = imgElement.src;
      }
    }
  }
}
