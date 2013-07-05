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
                <a href="http://srt.skyworth.com/">
                    <i class="icon-large icon-globe"></i>
                </a>
            </li>
            <li>
                <a href="http://srt.skyworth.com/bugs/www/index.php?m=company&f=browse">
                    <i class="icon-large icon-twitter"></i>
                </a>
            </li>

            %{--<li>--}%
                %{--<a href="#">--}%
                    %{--<i class="icon-large icon-cog"></i>--}%
                %{--</a>--}%
            %{--</li>--}%
        </ul>

        <ul class="nav pull-right">

            <!-- dropdown user account -->
            <li class="dropdown">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                    <i class="icon-large icon-user"></i>
                </a>

                <ul class="dropdown-menu dropdown-user-account">

                    <li class="account-img-container">
                        <g:img class="thumb account-img" uri="/images/no_avatar_100.png"></g:img>
                    </li>

                    <li class="account-info">
                        <h3>${session.user?.nick}</h3>
                        <p>
                            这是我的简介
                        </p>
                    </li>

                    <li class="account-footer">
                        <div class="row-fluid">

                            <div class="span8">
                                <a class="btn btn-small btn-primary btn-flat" href="#">更新资料</a>
                            </div>

                            <div class="span4 align-right">
                                <g:link controller="account" action="logout"
                                        class="btn btn-small btn-danger btn-flat">退出</g:link>
                            </div>

                        </div>
                    </li>

                </ul>
            </li>
            <!-- ./ dropdown user account -->
        </ul>

        <!-- search form
        <form class="navbar-search pull-right hidden-phone" action=""/>
        <input type="text" class="search-query span4" placeholder="search..."/>
    </form>
        -- ./ search form -->
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
                <g:img class="thumb account-img" uri="/images/no_avatar_55.png"></g:img>
                <span>${session.user?.nick}</span>
            </a>
        </li>
        <li class="active" rel="mine">
            <g:link controller="mine">
                <i class="micon-dashboard"></i>
                <span class="hidden-phone">仪表盘</span>
            </g:link>
        </li>
        <li class="dropdown" rel="project">
            <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                <i class="micon-dribbble"></i>
                <span class="hidden-phone">任务</span>
            </a>
            <ul class="dropdown-menu">
                <li>
                    <g:link controller="TProject" action="list">
                        <i class="icon-large micon-dribbble"></i>
                        任务包管理
                    </g:link>
                </li>
                <li>
                    <g:link controller="Mine" action="tasks">
                        <i class="icon-large icon-tasks"></i>
                        我的任务
                    </g:link>
                </li>
            </ul>
        </li>
        <g:if test="${session.user?.is_admin()}">
            <li class="dropdown" rel="sys">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                    <i class="micon-wrench"></i>
                    <span class="hidden-phone">管理</span>
                </a>
                <ul class="dropdown-menu">
                    <li>
                        <g:link controller="TSys" action="score">
                            <i class="icon-large micon-seven-segment-9"></i>
                            事物积分
                        </g:link>
                    </li>
                    <li>
                        <g:link controller="TSys" action="import_attendance">
                            <i class="icon-large micon-bell-3"></i>
                            考勤积分
                        </g:link>
                    </li>
                    <li>
                        <g:link controller="TSys" action="init_level">
                            <i class="icon-large micon-clipboard-2"></i>
                            等级初始化
                        </g:link>
                    </li>
                    <li>
                        <g:link controller="TSys" action="projects">
                            <i class="icon-large micon-clipboard-2"></i>
                            积分条目
                        </g:link>
                    </li>

                    <li>
                        <g:link controller="TLevel">
                            <i class="icon-large micon-diamond"></i>
                            等级管理
                        </g:link>
                    </li>
                    <li>
                        <g:link controller="TGroup">
                            <i class="icon-large icon-group"></i>
                            部门管理
                        </g:link>
                    </li>
                    <li>
                        <g:link controller="TUser">
                            <i class="icon-large icon-user"></i>
                            用户管理
                        </g:link>
                    </li>
                    <li>
                        <g:link controller="TSys" action="config">
                            <i class="icon-large micon-cog"></i>
                            系统配置
                        </g:link>
                    </li>
                    <li>
                        <g:link controller="TSys" action="temp_import">
                            <i class="icon-large micon-cog"></i>
                            各种导入
                        </g:link>
                    </li>
                </ul>
            </li>
        </g:if>
    </ul>
    <!-- end sidebar -->
</div>

<div id="spinner" class="spinner" style="display:none;"><g:message code="spinner.alt" default="Loading&hellip;"/></div>

<g:javascript library="application"/>
<r:layoutResources/>
<script type="text/javascript">
    $(function () {
        var cur_Controller = "${flash.menu_flag?:"mine"}";
        $("#sidebar>li").removeClass("active");
        $("#sidebar>li").each(function () {
            var xflag = $(this).attr("rel");
            if (xflag) {
                if (xflag.indexOf(cur_Controller) >= 0) {
                    $(this).addClass("active");
                }
            }
        });

//        if (!$("#sidebar>li").hasClass("active"))  {
//            $("#sidebar>li[rel='sys']").addClass("active");
//        }
    });
</script>
</body>
</html>