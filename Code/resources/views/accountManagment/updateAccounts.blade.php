@extends('layouts.app')

@section('content')
<div class="app-title">
  <div>
    <h1><i class="fa fa-edit"></i>Update Accounts</h1>

  </div>
  <ul class="app-breadcrumb breadcrumb">
    <li class="breadcrumb-item"><i class="fa fa-home fa-lg"></i></li>
    <li class="breadcrumb-item">Update User Account</li>
    <li class="breadcrumb-item"><a href="#">Edit User Account</a></li>
  </ul>
</div>
<div class="row">
  <div class="col-md-12">
    <div class="tile">
      <h3 class="tile-title">Update Account</h3>
      <div class="tile-body">
        <form class="row">
          <div class="form-group col-md-4">
            <label for="exampleInputEmail1">First Name</label>
            <input class="form-control" id="firstname" name="firstname" type="text" aria-describedby="emailHelp" placeholder="First Name">
          </div>
          <div class="form-group col-md-4">
            <label for="exampleInputEmail1">Middle Name</label>
            <input class="form-control" id="lastname" id="lastname" type="Text" aria-describedby="emailHelp" placeholder="Middle Name">
          </div>
          <div class="form-group col-md-4">
            <label for="exampleInputEmail1">Last Name</label>
            <input class="form-control" id="lastname" id="lastname" type="Text" aria-describedby="emailHelp" placeholder="Last Name">
          </div>
          <div class="form-group col-md-4">
            <label for="exampleInputEmail1">Email address</label>
            <input class="form-control" id="email" name="email" type="email" aria-describedby="emailHelp" placeholder="Email address"><small class="form-text text-muted" id="emailHelp">We'll never share your email with anyone
              else.</small>
          </div>

          <div class="form-group col-md-4">
            <label for="exampleInputEmail1">Phone Number</label>
            <input class="form-control" id="firstname" name="firstname" type="number" aria-describedby="emailHelp" placeholder="Phone Number">
          </div>
          <div class="form-group col-md-4">
            <label for="exampleInputEmail1">Created Date Time</label>
            <input class="form-control" id="firstname" name="firstname" type="time" aria-describedby="emailHelp" placeholder="Created Date Time">
          </div>

          <div class="form-group col-md-4">
            <label for="exampleInputEmail1">Last Update Time</label>
            <input class="form-control" id="firstname" name="firstname" type="time" aria-describedby="emailHelp" placeholder="Last Update Time">
          </div>

          <div class="form-group col-md-4">
            <label for="exampleInputEmail1">Plain Id</label>
            <input class="form-control" id="firstname" name="firstname" type="number" aria-describedby="emailHelp" placeholder="Plain Id">
          </div>

          <div class="form-group col-md-4">
            <label for="exampleInputEmail1">UU ID</label>
            <input class="form-control" id="firstname" name="firstname" type="number" aria-describedby="emailHelp" placeholder="UPI ID">
          </div>
          <div class="form-group col-md-4 align-self-end">
            <button class="btn btn-primary" type="button"><i class="fa fa-fw fa-lg fa-check-circle"></i>Search</button>
          </div>
        </form>
      </div>
    </div>
  </div>
</div>

@endsection