@section('sidebar')

<ul class="app-menu">
    <li class="app-menu__item{{ (request()->is('search')) ? 'active' : '' }}"><a href="search"> <i class="app-menu__icon fa fa-dashboard"></i><span class="app-menu__label">Search</span></a></li>

    <li class="treeview"><a class="app-menu__item" href="../search" data-toggle="treeview"><i class="app-menu__icon fa fa-laptop"></i><span class="app-menu__label">Account Managment</span><i class="treeview-indicator fa fa-angle-right"></i></a>
        <ul class="treeview-menu">
            <li><a class="treeview-item" href="{!! route('vCreateAccounts') !!}"><i class="icon fa fa-circle-o"></i> Create Account </a></li>
            <li><a class="treeview-item" href="{!! route('vSearchAccounts') !!}"><i class="icon fa fa-circle-o"></i> Search Accounts</a></li>
            <li><a class="treeview-item" href="{!! route('vViewAccounts') !!}"><i class="icon fa fa-circle-o"></i> View Accounts</a></li>
            <li><a class="treeview-item" href="{!! route('vUpdateAccounts') !!}"><i class="icon fa fa-circle-o"></i> Update Accounts</a></li>
        </ul>
    </li>
    <li><a class="app-menu__item" href="charts.html"><i class="app-menu__icon fa fa-pie-chart"></i><span class="app-menu__label">Update Accounts</span></a></li>
    <li class="treeview"><a class="app-menu__item" href="#" data-toggle="treeview"><i class="app-menu__icon fa fa-edit"></i><span class="app-menu__label">Transaction Management</span><i class="treeview-indicator fa fa-angle-right"></i></a>
        <ul class="treeview-menu">
            <li><a class="treeview-item" href="form-components.html"><i class="icon fa fa-circle-o"></i> Create Transaction </a></li>
            <li><a class="treeview-item" href="form-custom.html"><i class="icon fa fa-circle-o"></i>Search Transaction</a></li>
            <li><a class="treeview-item" href="form-samples.html"><i class="icon fa fa-circle-o"></i>View Transaction</a></li>
            <li><a class="treeview-item" href="form-samples.html"><i class="icon fa fa-circle-o"></i>Update Transaction</a></li>
        </ul>
    </li>
    <li class="treeview"><a class="app-menu__item" href="#" data-toggle="treeview"><i class="app-menu__icon fa fa-th-list"></i><span class="app-menu__label">Third Party API</span><i class="treeview-indicator fa fa-angle-right"></i></a>
        <ul class="treeview-menu">
            <li><a class="treeview-item" href="table-basic.html"><i class="icon fa fa-circle-o"></i>SMS API</a></li>
            <li><a class="treeview-item" href="table-data-table.html"><i class="icon fa fa-circle-o"></i>Recharge</a></li>
            <li><a class="treeview-item" href="table-data-table.html"><i class="icon fa fa-circle-o"></i>Money Transfer</a></li>
        </ul>
    </li>
    <li class="treeview"><a class="app-menu__item" href="#" data-toggle="treeview"><i class="app-menu__icon fa fa-file-text"></i><span class="app-menu__label">Pages</span><i class="treeview-indicator fa fa-angle-right"></i></a>
        <ul class="treeview-menu">
            <li><a class="treeview-item" href="blank-page.html"><i class="icon fa fa-circle-o"></i> Blank Page</a></li>
            <li><a class="treeview-item" href="page-login.html"><i class="icon fa fa-circle-o"></i> Login Page</a></li>
            <li><a class="treeview-item" href="page-lockscreen.html"><i class="icon fa fa-circle-o"></i> LockscreenPage</a></li>
            <li><a class="treeview-item" href="page-user.html"><i class="icon fa fa-circle-o"></i> User Page</a></li>
            <li><a class="treeview-item" href="page-invoice.html"><i class="icon fa fa-circle-o"></i> Invoice Page</a></li>
            <li><a class="treeview-item" href="page-calendar.html"><i class="icon fa fa-circle-o"></i> Calendar Page</a></li>
            <li><a class="treeview-item" href="page-mailbox.html"><i class="icon fa fa-circle-o"></i> Mailbox</a></li>
            <li><a class="treeview-item" href="page-error.html"><i class="icon fa fa-circle-o"></i> Error Page</a></li>
        </ul>
    </li>
</ul>
@endsection