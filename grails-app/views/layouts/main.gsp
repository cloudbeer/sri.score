<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8"/>
    <title><g:layoutTitle default="软件院积分管理系统"/></title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <meta name="description" content=""/>
    <meta name="author" content="Olas Navigator"/>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

    <r:require modules="bootstrap"/>
    <r:require modules="kuta_css"/>
    <r:layoutResources/>

    <!-- required styles -->
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'header.css')}" type="text/css" />


    <!-- HTML5 shim, for IE6-8 support of HTML5 elements -->
    <!--[if lt IE 9]>
		<script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
		<![endif]-->
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/></head>

<body>

<!-- header -->
<div id="header" class="navbar">
    <div class="navbar-inner">
        <!-- company or app name -->
        <a class="brand hidden-phone" href="index.html">SRI 积分系统</a>

        <!-- nav icons -->
        <ul class="nav">

            <li class="visible-phone">
                <a href="#"><i class="icon-large icon-search"></i></a>
            </li>

            <li>
                <a href="#">
                    <i class="icon-large icon-globe"></i>
                </a>
            </li>

            <li>
                <a href="#">
                    <i class="icon-large icon-envelope"></i>
                </a>
            </li>

            <li>
                <a href="#">
                    <i class="icon-large icon-cog"></i>
                </a>
            </li>

        </ul>

        <ul class="nav pull-right">

            <!-- dropdown user account -->
            <li class="dropdown">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                    <i class="icon-large icon-user"></i>
                </a>

                <ul class="dropdown-menu dropdown-user-account">

                    <li class="account-img-container">
                        <img class="thumb account-img" src="library/images/100/07.png" />
                    </li>

                    <li class="account-info">
                        <h3>Geunevere Calista</h3>
                        <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.</p>
                        <p>
                            <a href="#">Edit</a> | <a href="#">Account Settings</a>
                        </p>
                    </li>

                    <li class="account-footer">
                        <div class="row-fluid">

                            <div class="span8">
                                <a class="btn btn-small btn-primary btn-flat" href="#">Change avatar</a>
                            </div>

                            <div class="span4 align-right">
                                <a class="btn btn-small btn-danger btn-flat" href="#">Logout</a>
                            </div>

                        </div>
                    </li>

                </ul>
            </li>
            <!-- ./ dropdown user account -->
        </ul>

        <!-- search form -->
        <form class="navbar-search pull-right hidden-phone" action="" />
        <input type="text" class="search-query span4" placeholder="search..." />
    </form>
        <!-- ./ search form -->
    </div>
</div>
<!-- end header -->


<g:layoutBody/>
<div id="spinner" class="spinner" style="display:none;"><g:message code="spinner.alt" default="Loading&hellip;"/></div>

<g:javascript library="application"/>
<r:layoutResources/>
</body>
</html>