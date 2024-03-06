import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { UserModuleModule } from './user-module/user-module.module';
import { ProtectedNavComponentComponent } from './protected-nav-component/protected-nav-component.component';
import { RouterModule } from '@angular/router';


@NgModule({
  declarations: [ 
    ProtectedNavComponentComponent,
  ],
  imports: [
    CommonModule,
    UserModuleModule,
    RouterModule
  ],
  exports:[
    ProtectedNavComponentComponent,
  ]
})
export class SharedProtectedModuleModule { }
