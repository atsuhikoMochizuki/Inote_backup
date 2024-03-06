import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { UserService } from './user.service';
import { UserListComponentComponent } from './user-list-component/user-list-component.component';
import { SharedModuleModule } from '../../../shared-module/shared-module.module';
import { SearchUserComponentComponent } from './search-user-component/search-user-component.component';
import { FontAwesomeModule } from '@fortawesome/angular-fontawesome';
import { UserFilterPipePipe } from './user-filter-pipe.pipe';
import { UserDetailsComponentComponent } from './user-details-component/user-details-component.component';
import { UserFormComponentComponent } from './user-form-component/user-form-component.component';
import { FormsModule } from '@angular/forms';
import { RouterModule } from '@angular/router';

@NgModule({
  declarations: [
    UserListComponentComponent,
    SearchUserComponentComponent,
    UserFilterPipePipe,
    UserDetailsComponentComponent,
    UserFormComponentComponent
  ],
  imports: [
    CommonModule,
    SharedModuleModule,
    FontAwesomeModule,
    FormsModule,
    RouterModule
  ],
  exports:[
    UserListComponentComponent,
    UserDetailsComponentComponent,
    UserFormComponentComponent
  ],
  providers:[
    UserService
  ]
})
export class UserModuleModule { }
