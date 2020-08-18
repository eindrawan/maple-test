import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';
import { HttpClientModule } from '@angular/common/http';

import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';

import { LoginComponent } from './Login/Login.component';
import { GalleryComponent } from './Gallery/Gallery.component';
import { CartComponent } from './Cart/Cart.component';

import { BrowserAnimationsModule } from '@angular/platform-browser/animations';

import { MaterialModules } from './material-modules';

@NgModule({
  declarations: [AppComponent, LoginComponent, GalleryComponent, CartComponent],
  imports: [
    BrowserModule,
    AppRoutingModule,
    BrowserAnimationsModule,
    MaterialModules,
    HttpClientModule
  ],
  providers: [],
  bootstrap: [AppComponent]
})
export class AppModule {}
