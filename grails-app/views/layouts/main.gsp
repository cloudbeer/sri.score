<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8"/>
    <title><g:layoutTitle default="软件院积分管理系统"/></title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <meta name="description" content=""/>
    <meta name="author" content="SRI"/>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <g:javascript src="jquery.min.js"></g:javascript>
    <r:require modules="bootstrap"/>
    <r:require modules="kuta_css"/>
    <r:require modules="base_js"/>
    <r:require modules="app_css"/>
    <r:layoutResources/>

    <!-- required styles -->
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'header.css')}" type="text/css"/>


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
        <a class="brand hidden-phone" href="<g:createLinkTo dir="/"/>">SRI 积分系统</a>
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
                        <img class="thumb account-img" src="http://b.zol-img.com.cn/soft/6_120x90/408/ceHc4ZoyYxgME.gif"/>
                    </li>

                    <li class="account-info">
                        <h3>谢正伟</h3>

                        <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.</p>

                    </li>

                    <li class="account-footer">
                        <div class="row-fluid">

                            <div class="span8">
                                <a class="btn btn-small btn-primary btn-flat" href="#">更换头像</a>
                            </div>

                            <div class="span4 align-right">
                                <g:link controller="tuser" action="logout"
                                        class="btn btn-small btn-danger btn-flat">退出</g:link>
                            </div>

                        </div>
                    </li>

                </ul>
            </li>
            <!-- ./ dropdown user account -->
        </ul>

        <!-- search form -->
        <form class="navbar-search pull-right hidden-phone" action=""/>
        <input type="text" class="search-query span4" placeholder="search..."/>
    </form>
        <!-- ./ search form -->
    </div>
</div>
<!-- end header -->


<div id="left_layout">
    <!-- main content -->
    <div id="main_content" class="container-fluid">
        <g:layoutBody/>
    </div>
    <!-- end main content -->

    <!-- sidebar -->
    <ul id="sidebar" class="nav nav-pills nav-stacked">
        <li class="avatar hidden-phone">
            <a href="#">
                <img src="http://image.ladypk.com/face/user/82/40/82406_55">
                <span>谢正伟</span>
            </a>
        </li>
        <li class="active">
            <a href="<g:createLinkTo dir="/myhome"/> ">
                <i class="micon-screen"></i>
                <span class="hidden-phone">我的面板</span>
            </a>
        </li>
        <li class="dropdown">
            <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                <i class="micon-gift"></i>
                <span class="hidden-phone">项目</span>
            </a>
            <ul class="dropdown-menu">
                <li>
                    <g:link controller="TProject" action="apply">
                        <i class="icon-large icon-underline"></i>
                        创建项目

                    </g:link>
                </li>
                <li>
                    <a href="tables.html">
                        <i class="icon-large icon-table"></i>
                        项目查询
                    </a>
                </li>
                <li>
                    <a href="buttons.html">
                        <i class="icon-large icon-th"></i> 我的项目
                    </a>
                </li>
                <li>
                    <a href="icons.html">
                        <i class="icon-large icon-check-empty"></i> 我的任务
                    </a>
                </li>
            </ul>
        </li>
        <li class="dropdown">
            <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                <i class="micon-gift"></i>
                <span class="hidden-phone">管理</span>
            </a>
            <ul class="dropdown-menu">
                <li>
                    <a href="tables.html">
                        <i class="icon-large icon-table"></i>
                        增减积分
                    </a>
                </li>
                <li>
                    <g:link controller="TLevel">
                        <i class="icon-large icon-underline"></i>
                        等级管理
                    </g:link>
                </li>
                <li>
                    <a href="<g:createLinkTo dir="/TGroup/"/>">
                        <i class="icon-large icon-underline"></i>
                        部门管理
                    </a>
                </li>
                <li>
                    <g:link controller="TUser">
                        <i class="icon-large icon-underline"></i>
                        用户管理
                    </g:link>
                </li>
            </ul>
        </li>
    </ul>
    <!-- end sidebar -->
</div>

<div id="spinner" class="spinner" style="display:none;"><g:message code="spinner.alt" default="Loading&hellip;"/></div>

<g:javascript library="application"/>
<r:layoutResources/>
</body>
</html>