import { Directive, ElementRef, HostListener, Input } from '@angular/core';

@Directive({
  selector: '[appBorderMouse]'
})
export class BorderMouseDirective {

  private initialColor: string = '#f5f5f5';
  private defaultColor: string = '#009688';

  // Element ref va permettre de représenter une référence
  // sur l'objet concerné par la directive
  constructor(private el: ElementRef) {
    this.setBorder(this.initialColor)
  }

  @Input('appBorderMouse') borderColor!: string;

  @HostListener('mouseenter') onMouseEnter() {
    console.log("il rentre");
    this.setBorder(this.borderColor || this.defaultColor);
  }

  @HostListener('mouseleave') onMouseLeave() {
    this.setBorder(this.initialColor);
  }

  private setBorder(color: string) {
    let border = 'solid 4px' + color;
    this.el.nativeElement.style.border = border;
  }

}
