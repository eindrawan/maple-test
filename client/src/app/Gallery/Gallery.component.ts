import { Component, OnInit } from '@angular/core';
import { GlobalVars } from '../global';
import { HttpClient } from '@angular/common/http';
import { Router } from '@angular/router';

@Component({
  selector: 'app-Gallery',
  templateUrl: './Gallery.component.html',
  styleUrls: ['./Gallery.component.scss']
})
export class GalleryComponent implements OnInit {
  products = [];
  constructor(private _router: Router, private http: HttpClient) {}

  ngOnInit() {
    this.populate();
  }

  async populate() {
    let ret = await this.http
      .get<any>(GlobalVars.url + '/products')
      .toPromise();

    this.products = ret.data;
  }

  async addToCart(item: any) {
    if (GlobalVars.user.id) {
      let ret = await this.http
        .post<any>(GlobalVars.url + '/cart/add', {
          product_id: item.id,
          user_id: GlobalVars.user.id
        })
        .toPromise();

      if (ret.success) {
        GlobalVars.cartItem = ret.data;
      }
    } else {
      this._router.navigateByUrl('/login');
    }
  }
}
