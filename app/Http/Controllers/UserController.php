<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
Use App\User;
use Illuminate\Support\Facades\Auth;
use App\Models\Plane;
use App\Models\Booking;
use App\Models\Passenger;

class UserController extends Controller
{


  public function __construct()
  {
      $this->middleware(['auth','isVerified']);
  }
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        //
        return view('index');
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        //
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        //
    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        //
    }

    public function showBooking($id, $id_booking=null)
    {
        //
        $unique = Auth::user()->id;
        if ($id == $unique) {
          if ($id_booking) {
            return view('booking.payment', compact('id_booking'));
          }
          $dataP = Booking::where(['user_id' => $id,'vehicle'=>'plane'])->with('scheP','detail_booking','transaction')->get();
          return view('user.usersBookings', compact('dataP'));
        } else {
          abort(500);
        }
    }

    public function showTicket($id, $id_booking)
    {
      $vehicleP = '';
      $unique = Auth::user()->id;
      if ($id == $unique) {
        $booking = Booking::find($id_booking);
          $data = Booking::where(['id' => $id_booking,'vehicle'=>'plane'])->with('scheP','detail_booking','transaction')->get();
          $vehicleP = Plane::find($data[0]->scheP->plane_id);
        $passenger = Passenger::where('detail_booking_id',$data[0]->detail_booking->id)->get();
        return view('booking.tiket', compact('data', 'vehicleP', 'passenger'));
      } else {
        abort(500);
      }
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function edit($id, $type)
    {
      $data = User::find($id);

      if ($type == "password") {
        # code...
        return view('user.editPassword',$data);
      }elseif ($type == "profile") {
        # code...
        return view('user.edit',$data);
      }else {
        return abort(404);
      }

    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request)
    {
      $dataUser = User::find($request->id);
      try {
        if ($request->password) {
          if (password_verify($request->oldPassword, $dataUser->password)) {
            $request['password'] = bcrypt($request->password);
            $datas = request()->validate([
              'password' => 'required|min:8'
            ]);
          }else{
            return back()->with('alertF','Password lama tidak sesuai');
          }
          $mssg = back()->withAlert('Password berhasil diubah!');
        }elseif ($request->name) {
          $datas = request()->validate([
            'name' => 'required|min:10|max:50',
            'first_name' => 'required|min:3|max:50',
            'last_name' => 'required|min:3|max:70'
            // 'email' => 'sometimes|required|email'
            //'password' => 'required|min:8'
          ]);
          $mssg = back()->withAlert('Profil berhasil diubah!');
        }

        $dataUser->update($datas);
        return $mssg;
      } catch (\Exception $e) {
        return back()->with('alertF','Perubahan gagal!');
      }
    }

    public function updatePassword(Request $request)
    {
      $datas = request()->validate([
        'name' => 'required|min:10|max:50',
        'first_name' => 'required|min:3|max:50',
        'last_name' => 'required|min:3|max:70'
      ]);
        User::find($request->id)->update($datas);
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        //
    }
}
