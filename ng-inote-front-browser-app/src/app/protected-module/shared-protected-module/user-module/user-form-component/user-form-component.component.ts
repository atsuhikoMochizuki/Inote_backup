import { Component, Input } from '@angular/core';
import { User } from '../user';
import { UserService } from '../user.service';
import { Router } from '@angular/router';

@Component({
  selector: 'app-user-form-component',
  templateUrl: './user-form-component.component.html',
  styles: `
  .ng-valid[required]{
    border-left:5px solid green;
  }

  .ng-valid{
      border-left:5px solid green;
  }

  .ng-invalid:not(form){
      border-left:5px solid red;
  }
  `
})
export class UserFormComponentComponent {
  @Input() user!: User;
  isAddForm!: boolean;

  constructor(private userService: UserService,
    private router: Router) { }

  ngOnInit(): void {
    this.isAddForm = this.router.url.includes('add');
  }

  onSubmit() {
    console.log(this.user.avatar);

    if (this.isAddForm) {
      this.userService.addUser(this.user)
        .subscribe((user: User) => this.router.navigate(['/user', user.id]), (error) => console.error(error));
    } else {
      this.userService.updateUser(this.user)
        .subscribe(() => this.router.navigate(['/user', this.user.id]), (error) => console.error(error));
    }
  }

  onFileSelected(event: any) {
    const file = event.target.files[0];
    const reader = new FileReader();

    reader.onload = (event: any) => {
      const image = document.getElementById('avatar') as HTMLImageElement;
      image.src = event.target.result;
      this.user.picture = image.src;
    };

    reader.readAsDataURL(file);
  }
}
