<?php

namespace App\Http\Controllers;

Use App\User;


Use Illuminate\Support\Facades\DB;

class AdminController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    
    public function showUsers()
    {
      $users = User::all();
      return view('admin.users', compact('users'));
    }

    public function planeAjax($id)
    {
      $plane = DB::table("planes")->where("id",$id)->get();
      return response()->json($plane);
    }

    public function airportAjax($id)
    {
      $airport = DB::table("airports")->where("id",$id)->get();
      return response()->json($airport);
    }

    

    public function destinationAjax($id)
    {
      $destination = DB::table("airports")->where("id",$id)->get();
      return response()->json($destination);
    }
}
