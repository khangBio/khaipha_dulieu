<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<div class="sidebar-menu">
    <div class="navbar mscrollable" ng-controller="sideBar">
        <div class="menus ng-hide" ng-show="isLoadDone">

            <div class="item active">
                <a href="${pageContext.request.contextPath}" class="url ">
                    <span class="fa fa-fw fa fa-home"></span>
                    <span class="text">
                            Trang chủ
                        </span>
                </a>
            </div>
            <!-- 1 1-->

            <div class="item" ng-repeat="item in listdata">
                <span hidden class="function-code" data="{{item.functionCode}}"></span>
                <a id="100000" href="{{item.url}}" class="url">
                    <span class="fa {{item.icon}}"></span>
                    <span class="text">{{item.functionName}}</span>
                    <div ng-if="item.child.length > 0" class="down -ap icon-chevron-right22">
                    </div>
                </a>
                <ul ng-if="item.child.length > 0" class="dropdown-menu menu-component" childdata="item"></ul>
            </div>
        </div>
    </div>
</div>