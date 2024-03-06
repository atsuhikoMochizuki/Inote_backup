import { Component } from '@angular/core';

@Component({
  selector: 'app-spin-loader-component',
  template: `
    <div class="spinner-border text-success" role="status">
      <span class="visually-hidden">Loading...</span>
    </div>
  `
})
export class SpinLoaderComponentComponent {

}
