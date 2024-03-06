import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { BorderMouseDirective } from './border-mouse.directive';
import { FooterComponentComponent } from './footer-component/footer-component.component';
import { BorderMouseNoInitialColorDirectiveDirective } from './border-mouse-no-initial-color-directive.directive';
import { SpinLoaderComponentComponent } from './spin-loader-component/spin-loader-component.component';

@NgModule({
  declarations: [
    BorderMouseDirective,
    FooterComponentComponent,
    BorderMouseNoInitialColorDirectiveDirective,
    SpinLoaderComponentComponent
  ],
  imports: [
    CommonModule
  ],
  exports:[
    FooterComponentComponent,
    BorderMouseDirective,
    BorderMouseNoInitialColorDirectiveDirective,
    SpinLoaderComponentComponent,
  ],

})
export class SharedModuleModule { }
