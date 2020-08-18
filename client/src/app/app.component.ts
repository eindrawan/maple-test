import { Component } from '@angular/core';
import { GlobalVars } from './global';
import { Router } from '@angular/router';

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.scss']
})
export class AppComponent {
  title = 'test';
  global = GlobalVars;
  showFiller = false;

  constructor(private _router: Router) {}

  get cartLength() {
    return GlobalVars.cartItem.length;
  }

  goToCart() {
    this._router.navigateByUrl('/cart');
  }

  logout() {
    GlobalVars.user = { id: 0, name: '' };
    GlobalVars.cartItem = [];
    this._router.navigateByUrl('/login');
  }
}
