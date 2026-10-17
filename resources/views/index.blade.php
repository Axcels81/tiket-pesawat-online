@extends('layouts.app')

@section('content')
  @push('scripts')
    <script type="text/javascript">
      $(document).ready(function(){
        $.fn.select2.defaults.set( "theme", "bootstrap" );
        $.fn.select2.defaults.set("width", null);
        $('.select2').select2();
        $('.select2').change(function(){
          $('.select2').find('option').prop('disabled', false);
          $('.select2').each(function(){
            var current = $(this);
            // console.log(current);
            $('.select2').not(current).find('option').each(function(){
              if($(this).val() == current.val()){
                $(this).prop('disabled', true);
              }
            });
          });
          $('.select2').select2();
        });
        $('.dateB').hide();
        $('.type').change(function(){
          if ($(this).val() == 'rt') {
            $('.dateB').show();
          }else{
            $('.dateB').hide();
          }
        });
      });
    </script>
  @endpush
<!--slider-->
<div id="carousel-example-generic" class="carousel slide" data-ride="carousel">
  <!-- Indicators -->
  <ol class="carousel-indicators">
    <li data-target="#carousel-example-generic" data-slide-to="0" class="active"></li>
    <li data-target="#carousel-example-generic" data-slide-to="1"></li>
    <li data-target="#carousel-example-generic" data-slide-to="2"></li>
  </ol>

  <!-- Wrapper for slides -->
  <div class="carousel-inner" role="listbox">
    <div class="item active">
      <img src="images/pes1.jpg" alt="...">
      <div class="carousel-caption">
       <h1>Membantu perjalanan anda agar selamat dan nyaman</h1>
      </div>
    </div>
    <div class="item">
      <img src="images/pes2.jpg" alt="...">
      <div class="carousel-caption">
       <h1>Pelayanan yang baik kepada seluruh pengguna</h1>
      </div>
    </div>

    <div class="item">
      <img src="images/pes3.jpg" alt="...">
      <div class="carousel-caption">
        <h1>Memberikan pilihan maskapai terbaik untuk anda</h1>
      </div>
    </div>
  </div>

  <!-- Controls -->
  <a class="left carousel-control" href="#carousel-example-generic" role="button" data-slide="prev">
    <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
    <span class="sr-only">Previous</span>
  </a>
  <a class="right carousel-control" href="#carousel-example-generic" role="button" data-slide="next">
    <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
    <span class="sr-only">Next</span>
  </a>
</div>

<!-- tab -->
  <div class="container">
    <div class="row">
      <div role="tabpanel">
          <div class="panel-body">

            <div class="container">
              <div class="row">
                <div class="col-lg-12 text-center">
                  <h2 class="section-heading text-uppercase" id="test">Pemesanan Tiket</h2>
                </div>
              </div>
            </div>

            @if (Session::has('error'))
              <div class="alert alert-danger">
                <p>{{Session::get('error')}}</p>
              </div>
            @endif
            <div class="tab-content">
              <div class="tab-pane active" id="pesawat">
                <form action="{{ url('booking/search') }}" method="post">
                  {{ csrf_field() }}
                  <input type="hidden" name="vehicle" value="plane">
                  <div class="col-md-4">
                    <label>Kota Asal</label>
                      <select class="select2 item_id" id="select2" name="from_code" >
                        <option value="">Pilih</option>
                        @foreach ($airport as $a)
                          <option value="{{$a->code}}">{{"$a->city - $a->airport_name ($a->code)"}}</option>
                        @endforeach
                      </select>
                  </div>

                  <div class="col-md-4">
                    <label>Tujuan</label>
                      <select class="select2 item_id" id="select2" name="destination_code" >
                        <option value="">Pilih</option>
                        @foreach ($airport as $a)
                          <option value="{{$a->code}}">{{"$a->city - $a->airport_name ($a->code)"}}</option>
                        @endforeach
                      </select>
                  </div>

                  <div class="col-md-4">
                    <label for="kelas penerbangan">Kelas Penerbangan</label>
                      <select class="form-control" name="class" >
                          <option value="Ekonomi">Ekonomi</option>
                          <option value="Bisnis">Bisnis</option>
                          <option value="First Class">First Class</option>
                      </select>
                  </div>

                  <div class="col-md-4">
                    <label for="Perjalanan">Perjalanan</label>
                      <select class='form-control type' name="type" >
                          <option value="st">Sekali Jalan</option>
                          <option value="rt">Pulang Pergi</option>
                      </select>
                  </div>

                  <div class="col-md-2">
                    <label for="dewasa">Dewasa</label>
                      <select class="form-control"  name="adult" >
                          <option value="1">1</option>
                          <option value="2">2</option>
                          <option value="3">3</option>
                          <option value="4">4</option>
                      </select>
                  </div>

                  <div class="col-md-2">
                    <label for="anak">Anak-Anak</label>
                      <select class="form-control"  id="child" name="child" >
                          <option value="0">0</option>
                          <option value="1">1</option>
                          <option value="2">2</option>
                          <option value="3">3</option>
                          <option value="4">4</option>
                      </select>
                  </div>

                  <div class="col-md-2">
                    <label for="bayi">Bayi</label>
                      <select class="form-control"  id="baby" name="baby" >
                          <option value="0">0</option>
                          <option value="1">1</option>
                          <option value="2">2</option>
                          <option value="3">3</option>
                          <option value="4">4</option>
                      </select>
                  </div>

                  <div class="col-md-4">
                    <label for="berangkat">Tanggal Berangkat</label>
                    <input type="text" class="form-control datepicker" name='date' placeholder="01/12/2021" >
                  </div>

                  <div class="col-md-4 dateB">
                    <label for="pulang">Tanggal Pulang</label>
                    <input type="text" class="form-control datepicker" name='dateB' placeholder="02/12/2021">
                  </div>

                  <div class="col-lg-12 text-center"><br>
                    <button type="submit" class="btn btn-primary">Cari Tiket Pesawat</button>
                    <br>
                  </div>
                </form>
              </div>
              
            </div>
          </div>
      </div>
    </div>
  </div>

<hr class="half-rule">
 <!-- Services -->


     <!-- Partners -->
<section id="partners">
  <div class="container">
    <div class="row">
      <div class="col-lg-12 text-center">
        <h2 class="section-heading text-uppercase" id="test">Maskapai Yang Tersedia</h2>
        <img src="images/maskapai2.png" alt="">
      </div>
    </div>
  </div>

  <hr class="half-rule">
</section>

@endsection
