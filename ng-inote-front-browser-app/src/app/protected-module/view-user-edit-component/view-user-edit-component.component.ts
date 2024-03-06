import { Component, OnInit } from '@angular/core';
import { User } from '../shared-protected-module/user-module/user';
import { ActivatedRoute } from '@angular/router';
import { UserService } from '../shared-protected-module/user-module/user.service';

@Component({
  selector: 'app-view-user-edit-component',
  template: `
  <app-protected-nav-component></app-protected-nav-component>
  <h2 class = "text-center mb-2" *ngIf="this.user">Editer l'utilisateur {{user.pseudo}}</h2>
  <app-user-form-component *ngIf="this.user" [user]="this.user" ></app-user-form-component>
  `,
})
export class ViewUserEditComponentComponent implements OnInit {
  user!: User | undefined;

  constructor(
    private route: ActivatedRoute,
    private userService: UserService
  ) { }

  ngOnInit(): void {
    const userId: string | null = this.route.snapshot.paramMap.get('id');
    if (userId) {
      this.userService.getUserById(+userId).subscribe(user => this.user = user);
    } else {
      this.user = undefined;
    }
  }
}
