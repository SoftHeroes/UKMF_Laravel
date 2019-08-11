@extends('layouts.app')

@section('content')
<?php $page = 'search'; ?>
<div class="app-title">
  <div>
    <h1><i class="fa fa-edit"></i>Search Components</h1>

  </div>
  <ul class="app-breadcrumb breadcrumb">
    <li class="breadcrumb-item"><i class="fa fa-home fa-lg"></i></li>
    <li class="breadcrumb-item">Create User Account</li>
    <li class="breadcrumb-item"><a href="#">Edit User Account</a></li>
  </ul>
</div>
<div class="row">
  <div class="col-md-12">
    <div class="tile">
      <h3 class="tile-title">Search Account</h3>
      @if(count($errors))
      <div class="alert alert-danger">
        <strong>Whoops!</strong> There were some problems with your input.
        <br />
        <ul>
          @foreach($errors->all() as $error)
          <li>{{ $error }}</li>
          @endforeach
        </ul>
      </div>
      @endif
      <div class="tile-body">
        <form class="row" action="{{URL::to('/accountSearch')}}" method="POST">
          {{csrf_field()}}
          <div class="form-group col-md-4">
            <label for="exampleInputEmail1">First Name</label>
            <input class="form-control" id="firstName" name="firstName" type="text" aria-describedby="emailHelp" placeholder="First Name">
          </div>
          <div class="form-group col-md-4">
            <label for="exampleInputEmail1">Middle Name</label>
            <input class="form-control" id="middleName" name="middleName" type="Text" aria-describedby="emailHelp" placeholder="Middle Name">
          </div>
          <div class="form-group col-md-4">
            <label for="exampleInputEmail1">Last Name</label>
            <input class="form-control" id="lastName" name="lastName" type="Text" aria-describedby="emailHelp" placeholder="Last Name">
          </div>
          <div class="form-group col-md-4">
            <label for="exampleInputEmail1">Email address</label>
            <input class="form-control" id="emailAddress" name="emailAddress" type="email" aria-describedby="emailHelp" placeholder="Email address">
          </div>
          <div class="form-group col-md-4">
            <label for="exampleInputEmail1">Phone Number</label>
            <input class="form-control phoneNumber" id="phoneNumber" name="phoneNumber" type="text" aria-describedby="emailHelp" placeholder="Phone Number">
          </div>
          <div class="form-group col-md-4">
            <label for="exampleInputEmail1">Plain Id</label>
            <input class="form-control INT" id="plainId" name="plainId" type="text" aria-describedby="emailHelp" placeholder="Plain Id">
          </div>
          <div class="form-group col-md-4">
            <label for="exampleInputEmail1">UUID</label>
            <input class="form-control uuid" id="UUID" name="UUID" type="text" aria-describedby="emailHelp" placeholder="UPI ID">
          </div>
          <div class="form-group">
            <input class="form-control" id="batchSize" name="batchSize" type="hidden" value=4>
          </div>
          <div class="form-group">
            <input class="form-control" id="pageNumber" name="pageNumber" type="hidden" value=1>
          </div>
          <div class="form-group">
            <input class="form-control" id="source" name="source" type="hidden" value="Web">
          </div>
          <div class="form-group">
            <input class="form-control" id="language" name="language" type="hidden" value="English">
          </div>
          <div class="form-group text-center col-md-12 align-self-center">
            <br> <button class="btn btn-primary" type="submit"><i class="fa fa-fw fa-lg fa-check-circle"></i>Search</button>
          </div>
        </form>
      </div>
    </div>
  </div>
</div>

@endsection