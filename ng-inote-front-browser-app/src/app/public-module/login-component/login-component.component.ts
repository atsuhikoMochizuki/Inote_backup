import { Component, OnInit } from '@angular/core';
import { AuthService } from '../../core-module/auth.service';
import { Router } from '@angular/router';

@Component({
  selector: 'app-login-component',
  templateUrl: './login-component.component.html'
})
export class LoginComponentComponent implements OnInit {
  message: string = "Vous êtes déconnecté";

  userDemo: string = "a@a.com";
  userPwdDemo: string = 'a';
  name!: string;
  password!: string;
  auth!: AuthService;

  constructor(
    private authService: AuthService,
    private router: Router) { }

  ngOnInit(): void {
    this.auth = this.authService;
  }

  login() {
    this.message = 'Tentative de connexion en cours...';
    this.auth.login(this.name, this.password)
      .subscribe((isLoggedIn: boolean) => {
        this.setMessage();
        if (isLoggedIn) {
          this.router.navigate(['/users']);
        } else {
          this.password = '';
          this.router.navigate(['/login']);
        }
      })
  }

  logout() {
    this.authService.logout();
    this.message = "Vous êtes déconnecté";
  }

  setMessage() {
    if (this.authService.isLoggedIn) {
      this.message = "Vous êtes connecté";
    } else {
      this.message = "identifiant ou mot de passe incorrect";
    }
  }
}