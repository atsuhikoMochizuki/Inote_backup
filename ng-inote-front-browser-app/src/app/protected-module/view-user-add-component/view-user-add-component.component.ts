import { Component, OnInit } from '@angular/core';
import { User } from '../shared-protected-module/user-module/user';

@Component({
  selector: 'app-view-user-add-component',
  template: `
   <app-protected-nav-component></app-protected-nav-component>
   <h2 class='text-center'> Ajouter un utilisateur</h2>
   <app-user-form-component [user]="user"></app-user-form-component>
  `,
  styles: ``
})
export class ViewUserAddComponentComponent implements OnInit {
  user!: User;

  ngOnInit(): void {
    this.user = new User();
  }
}
