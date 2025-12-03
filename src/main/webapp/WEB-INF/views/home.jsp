<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html lang="vi">
<spring:eval expression="@environment.getProperty('applicationName')" var="applicationName"/>
<head>
    <title class="title">Nhóm 1 - CSDL Nâng Cao</title>
    <meta charset="utf-8"/>
    <meta name="keywords" content="It, it solution,solution, techonogy,internet"/>
    <link href="https://plus.google.com/107177373712004256296" rel="author">
    <meta content="IE=edge" http-equiv="X-UA-Compatible">
    </meta>
    <meta content="width=device-width, initial-scale=1" name="viewport" id="viewport">
    </meta>
    <meta http-equiv="Content-Type" content="application/javascript; charset=utf-8">

    <meta content="Hệ thống quản lý cư trú chung" name="description">
    <meta content="IE=edge" http-equiv="X-UA-Compatible">
    </meta>

    <link rel="icon" type="image/ico" href="${pageContext.request.contextPath}/resources/favicon.ico">

    <meta content="index, follow" name="ROBOTS">

    <!-- Bootstrap css -->
    <link type="text/css" rel='stylesheet'
          href="${pageContext.request.contextPath}/resources/style-dancu/vendor/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/style-dancu/vendor/slick/slick.css">
    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/resources/style-dancu/vendor/footable-bootstrap/css/footable.bootstrap.min.css">
    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/resources/style-dancu/vendor/bootstrap-datepicker/css/bootstrap-datepicker.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/style-dancu/vendor/ap8/css/style.css">
    <link rel="stylesheet" type="text/css"
          href="${pageContext.request.contextPath}/resources/style-dancu/vendor/themify/themify-icons.css">
    <!-- End Bootstrap css -->
    <link rel="stylesheet" type="text/css"
          href="${pageContext.request.contextPath}/resources/style-dancu/vendor/select2/css/select2.min.css">
    <!-- Fontawesome css -->
    <link type="text/css" rel='stylesheet'
          href="${pageContext.request.contextPath}/resources/style-dancu/vendor/font-awesome/css/font-awesome.min.css">
    <!-- End Fontawesome css -->

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/resources/style-dancu/vendor/datatable/css/dataTables.bootstrap.css">

    <!-- Font Icon Ap css -->
    <link rel="stylesheet" type="text/css"
          href="${pageContext.request.contextPath}/resources/module/select2/css/select2.min.css">
    <link rel="stylesheet" type="text/css"
          href="${pageContext.request.contextPath}/resources/module/jquery-confirm/css/jquery-confirm.min.css">
    <link rel="stylesheet" type="text/css"
          href="${pageContext.request.contextPath}/resources/style-dancu/vendor/toastr/toastr.min.css">
    <link rel="stylesheet" type="text/css"
          href="${pageContext.request.contextPath}/resources/module/bootstrap-datepicker/css/bootstrap-datepicker.min.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/lib/lib.css?v=2">

    <link rel="stylesheet" type="text/css"
          href="${pageContext.request.contextPath}/resources/custom-uiux/nucleo/outline/css/style.css">
    <link rel="stylesheet" type="text/css"
          href="${pageContext.request.contextPath}/resources/custom-uiux/ap8/css/style.css">
    <link rel="stylesheet" type="text/css"
          href="${pageContext.request.contextPath}/resources/custom-uiux/style.css?v=2">
    <link rel="stylesheet" type="text/css"
          href="${pageContext.request.contextPath}/resources/style-dancu/css/style.css">
<%--    <link rel="stylesheet" type="text/css" href="/notification/resources/notify.css?v=2">--%>
</head>

<body class="no-js" lang="vi" ng-app="myApp" aaa="<b>imdam</b>">
<input id="PageContext" type="hidden" value="${pageContext.request.contextPath}" />
<jsp:include page="./${path}"/>
<div id="loading" style="display: none;">
    <%--		<i style="color: #ffffff;" class="fa fa-spinner fa-pulse fa-3x fa-fw"></i>--%>
    <%--		<div class="loader"></div>--%>
    <div class="lds-ellipsis"><div></div><div></div><div></div><div></div></div>
</div>
</body>

</html>
