import { Component, OnInit } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { GlobalVars } from '../global';

@Component({
  selector: 'app-Cart',
  templateUrl: './Cart.component.html',
  styleUrls: ['./Cart.component.scss']
})
export class CartComponent implements OnInit {
  products = [];
  constructor(private http: HttpClient) {}

  ngOnInit() {
    this.populate();
  }

  async populate() {
    let ret = await this.http
      .post<any>(GlobalVars.url + '/cart', {
        user_id: 1
      })
      .toPromise();
    this.products = ret.data;
  }

  async addItem(id: number) {
    let ret = await this.http
      .post<any>(GlobalVars.url + '/cart/add', {
        user_id: 1,
        product_id: id
      })
      .toPromise();
    this.products = ret.data;
  }

  async removeItem(id: number) {
    let ret = await this.http
      .post<any>(GlobalVars.url + '/cart/remove', {
        user_id: 1,
        product_id: id
      })
      .toPromise();
    this.products = ret.data;
  }

  async checkout() {
    let ret = await this.http
      .post<any>(GlobalVars.url + '/cart/checkout', {
        user_id: 1
      })
      .toPromise();
    if (ret.success) {
      this.products = [];
    } else {
      alert(ret.message);
    }
  }
}
