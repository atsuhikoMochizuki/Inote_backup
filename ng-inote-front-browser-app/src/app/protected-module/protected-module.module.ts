import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { ViewUserListComponentComponent } from './view-user-list-component/view-user-list-component.component';
import { SharedProtectedModuleModule } from './shared-protected-module/shared-protected-module.module';
import { RouterModule, Routes } from '@angular/router';
import { UserModuleModule } from './shared-protected-module/user-module/user-module.module';
import { ViewUserDetailsComponentComponent } from './view-user-details-component/view-user-details-component.component';
import { ViewUserEditComponentComponent } from './view-user-edit-component/view-user-edit-component.component';
import { ViewUserAddComponentComponent } from './view-user-add-component/view-user-add-component.component';
import { FormsModule } from '@angular/forms';
import { AuthGuard } from '../core-module/auth.guard';


const protectedRoutes:Routes=[
  {path:'edit/user/:id', component: ViewUserEditComponentComponent, canActivate:[AuthGuard]},
  {path:'user/add', component:ViewUserAddComponentComponent , canActivate:[AuthGuard]},
  {path:'user/:id', component: ViewUserDetailsComponentComponent, canActivate:[AuthGuard]},
  {path:'users', component:ViewUserListComponentComponent, canActivate:[AuthGuard]}
]
@NgModule({
    declarations: [
        ViewUserListComponentComponent,
        ViewUserDetailsComponentComponent,
        ViewUserEditComponentComponent,
        ViewUserAddComponentComponent,
        
    ],
    imports: [
        CommonModule,
        SharedProtectedModuleModule,
        RouterModule.forChild(protectedRoutes),
        FormsModule,
        UserModuleModule
    ]
})
export class ProtectedModuleModule { }
