import { Component, OnInit } from '@angular/core';
import { User } from '../user';
import { Router } from '@angular/router';
import { UserService } from '../user.service';

@Component({
  selector: 'app-user-list-component',
  templateUrl: './user-list-component.component.html',
  styles: ``
})
export class UserListComponentComponent implements OnInit {
  listUsers!: User[];

  constructor(
    private router: Router,
    private userService: UserService
    ) { }

  ngOnInit(): void {
    this.userService.getUserList().subscribe(userList => {
      userList.forEach(user => {
        this.userService.loadUserAvatar(user);
        this.userService.updateUser(user)
        .subscribe();
        this.listUsers = userList;
      });
    });
  }

  goToUser(user: User) {
    this.router.navigate(['/user', user.id]);
  }

  goToUserAdd(){
    this.router.navigate(['/user/add']);
  }


}
