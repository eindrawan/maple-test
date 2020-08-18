import { Component, OnInit } from '@angular/core';
import { FormControl } from '@angular/forms';
import { Router } from '@angular/router';
import { GlobalVars } from '../global';
import { HttpClient } from '@angular/common/http';

@Component({
  selector: 'app-Login',
  templateUrl: './Login.component.html',
  styleUrls: ['./Login.component.scss']
})
export class LoginComponent implements OnInit {
  username = new FormControl('');
  password = new FormControl('');

  constructor(private _router: Router, private http: HttpClient) {}

  ngOnInit() {}

  async Login() {
    let ret = await this.http
      .post<any>(GlobalVars.url + '/login', {
        username: this.username.value,
        password: this.password.value
      })
      .toPromise();

    if (ret.success) {
      GlobalVars.user.name = this.username.value;
      GlobalVars.user.id = ret.data.id;

      ret = await this.http
        .post<any>(GlobalVars.url + '/cart', {
          user_id: ret.data.id
        })
        .toPromise();
      GlobalVars.cartItem = ret.data;

      this._router.navigateByUrl('/gallery');
    }
  }
}
