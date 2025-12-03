<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

        <div class="header" ng-controller="header">
            <div class="nav-icon">
                <span class="-ap icon-list2"></span>
            </div>
            <div class="top">
                <a class="logo">
                    <img src="${pageContext.request.contextPath}/resources/img/logo.png" alt="Logo">
                </a>
                <div class="text-logo">
                    <div class="subtitle">CƠ SỞ DỮ LIỆU QUỐC GIA VỀ DÂN CƯ</div>
                </div>
            </div>
            <div class="header-right pull-right">
                <div class="item -noti">
                    <div class="notify">
                        <a style="color:white; margin-right:-20px" title="Hướng dẫn sử dụng chức năng" target="_blank"
                            id="user_manual_func">
                            <span class="icon fa fa-book"></span>
                        </a>
                    </div>
                </div>
                <div id="notifycation" class="item noti-waiting">
<%--                    <div class="dropdown">--%>
<%--                        <div class="notify">--%>
<%--                            <span class="icon -ap icon-notifications"></span>--%>
<%--                            <div class="num" ng-if="hasUnseen"></div>--%>
<%--                        </div>--%>
<%--                        <ul class="dropdown-menu">--%>
<%--                            <li class="item-notify" ng-repeat="item in listNotification">--%>
<%--                                <a class="title-notify" href="javascript:;">{{item.titleNotification}}</a>--%>
<%--                                <div class="content-notify" ng-if="item.seen==0">{{item.contentNotification}}</div>--%>
<%--                                <div class="content-notify" style="color:#777!important" ng-if="item.seen==1">{{item.contentNotification}}</div>--%>
<%--                            </li>--%>
<%--                        </ul>--%>
<%--                    </div>--%>
                </div>
                <div class="item -user">
                    <div class="user">
                        <div class="avatar"
                            style="background-image: url(${pageContext.request.contextPath}/resources/img/avatar.jpg);">
                        </div>
                        <div class="username">
                            <p class="name">
                                <c:out value="${userInfo.userName}" />
                            </p>
                            <div style="font-size: 9px; font-weight: bold;">${userInfo.userCode}</div>
                        </div>
                        <div class="down">
                            <span class="icon -ap icon-triangle-down"></span>
                        </div>

                    </div>
                    <ul class="dropdown-menu">
                        <!-- <li>  
                	<a href="#" onclick="alert('Chức năng đang hoàn thiện.'); return;"><span class="fa fa-edit icon"></span> Đổi mật khẩu</a>
                </li> -->
                        <li>
                            <a href="/qtud/cloudadmin/comm_user_manual/user_manual_exec" target="_blank"><span
                                    class="fa fa-question-circle icon"></span> Trợ giúp</a>
                        </li>
                        <li>
                            <a href="${pageContext.request.contextPath}/login"><span class="fa fa-sign-out icon"></span>
                                Thoát</a>
                        </li>
                    </ul>
                </div>
            </div>
        </div>