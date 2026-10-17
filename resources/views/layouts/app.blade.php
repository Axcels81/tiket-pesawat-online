<!DOCTYPE html>
<html lang="{{ app()->getLocale() }}">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- CSRF Token -->
    <meta name="csrf-token" content="{{ csrf_token() }}">

    <title>Pemesanan Tiket Pesawat Secara Online</title>

    <!-- Styles -->
    <link href="{{ asset('css/app.css') }}" rel="stylesheet">
    <link href="{{ asset('css/bootstrap.css') }}" rel="stylesheet">
    <link href="{{ asset('css/footer.css') }}" rel="stylesheet">
    <link href="{{ asset('vendor/datatables/jquery.dataTables.min.css') }}" rel="stylesheet">
    <link href="{{ asset('vendor/datepicker/datepicker3.css') }}" rel="stylesheet">
    <link href="{{ asset('vendor/select2/css/select2.min.css') }}" rel="stylesheet">
    <link href="{{ asset('vendor/select2/css/select2-bootstrap.css') }}" rel="stylesheet">
    <link href="{{ asset('vendor/font-awesome/css/font-awesome.css') }}" rel="stylesheet">
    <link href="{{ asset('public/images') }}">
</head>
<body>
  <div id="app" >
    <nav class="navbar navbar-fixed-top bg-info" >
      <div class="navbar-header page-scroll">
        <!-- Collapsed Hamburger -->
        <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#app-navbar-collapse" aria-expanded="false">
            <span class="sr-only">Toggle Navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
        </button>
        <!-- Branding Image -->
        <a class="navbar-brand" href="{{url('')}}">
          <span class="glyphicon glyphicon-plane" aria-hidden="true"></span>  Pemesanan Tiket Pesawat
        </a>
      </div>
      <div class="collapse navbar-collapse" id="app-navbar-collapse">
        <!-- Left Side Of Navbar -->
        <ul class="nav navbar-nav">
            &nbsp;
        </ul>
        <!-- Right Side Of Navbar -->
        <ul class="nav navbar-nav navbar-right ">
          <!-- Authentication Links -->
          @guest
            <li><a href="{{ route('login') }}" >Login</a></li>  
            <li> ||</li>          
          @else
          </li>
            <li class="dropdown">
              <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false" aria-haspopup="true">
                {{ Auth::user()->name }} <span class="caret"></span>
              </a>
              <ul class="dropdown-menu">
                <li><a href="{{ url('user/booking/'.Auth::user()->id) }}">Pemesanan</a></li>
                <li>
                  <a href="{{ route('logout') }}"
                      onclick="event.preventDefault();
                               document.getElementById('logout-form').submit();">
                      Keluar
                  </a>
                  <form id="logout-form" action="{{ route('logout') }}" method="POST" style="display: none;">
                      {{ csrf_field() }}
                  </form>
                </li>
              </ul>
            </li>
          @endguest
        </ul>
      </div>
    </nav>
      @yield('content')
  </div>
  
{{-- section style="text-align:center; margin:10px auto;"><p>Copyright © 2021, All Rights Reserved</p></section> --}}
    <!-- Scripts -->
<script src="{{ asset('js/app.js') }}"></script>
{{-- <script src="{{ asset('js/bootstrap.min.js') }}"></script> --}}
<script src="{{ asset('vendor/datatables/jquery.dataTables.js') }}"></script>
<script src="{{ asset('vendor/datepicker/bootstrap-datepicker.js') }}"></script>
<script src="{{ asset('vendor/select2/js/select2.min.js') }}"></script>
<script type="text/javascript">
  $('.datepicker').datepicker({
    format: 'mm/dd/yyyy',
    startDate: '+1d',
    autoclose:true
  });
</script>
@stack('scripts')

</body>
</html>
