import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { RouterModule, Routes } from '@angular/router';
import { SharedModuleModule } from '../shared-module/shared-module.module';
import { FormsModule } from '@angular/forms';
import { LandingPageComponentComponent } from './landing-page-component/landing-page-component.component';
import { LoginComponentComponent } from './login-component/login-component.component';
import { PageNotFoundComponentComponent } from './page-not-found-component/page-not-found-component.component';

const publicRoutes:Routes = [
  {path:'home', component:LandingPageComponentComponent},
  {path:'login', component:LoginComponentComponent},
  {path:'page-not-found', component:PageNotFoundComponentComponent},
]

@NgModule({
  declarations: [
    LandingPageComponentComponent,
    LoginComponentComponent,
    PageNotFoundComponentComponent,
  ],
  imports: [
    CommonModule,
    RouterModule.forChild(publicRoutes),
    SharedModuleModule,
    FormsModule,
  ]
})
export class PublicModuleModule { }
