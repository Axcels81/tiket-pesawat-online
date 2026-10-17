<?php

use Illuminate\Support\Facades\Route;
use Illuminate\Support\Facades\Auth;


/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/

Route::get('plane/ajax/{id}','AdminController@planeAjax');
Route::get('airport/ajax/{id}','AdminController@airportAjax');
Route::get('station/ajax/{id}','AdminController@stationAjax');
//auth
Auth::routes();
//home / index
Route::get('', 'HomeController@index');
//booking
Route::group(['prefix' => 'booking'], function(){
  Route::post('search', 'BookingController@search')->middleware('auth');
  Route::post('order', 'BookingController@order');
  Route::post('fixOrder', 'BookingController@fixOrder');
  Route::put('payment/{id}', 'BookingController@payment');
});
//admin
Route::group(['prefix'=>'admin', 'middleware' => 'group:admin'], function(){
  Route::get('users', 'AdminController@showUsers');
  //booking
  Route::resource('booking','BookingController');
  //plane
  Route::resource('plane', 'PlaneController');
  //airport
  Route::resource('airport', 'AirportController');
  //plane schedule
  Route::group(['prefix'=>'plane/schedule'], function(){
    Route::get('index', 'PlaneController@schedule');
    Route::get('detail/{id}','PlaneController@detailSchedule');
    Route::get('create','PlaneController@createSchedule');
    Route::post('store','PlaneController@storeSchedule');
    Route::get('edit/{id}','PlaneController@editSchedule');
    Route::put('update/{id}','PlaneController@updateSchedule');
    Route::delete('destroy/{id}','PlaneController@destroySchedule');
  });
});
//user
Route::group(['prefix' => 'user', 'middleware'=> ['isVerified', 'group:member']], function(){
  Route::get('edit/{id}/{type}', 'UserController@edit')->name('edit');
  Route::put('update', 'UserController@update')->name('update');
  Route::put('updatePass', 'UserController@updatePassword')->name('updatePass');
  Route::get('booking/{id}/{id_booking?}', 'UserController@showBooking');
  Route::get('ticket/{id}/{id_booking}', 'UserController@showTicket');
});