    <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

    <li id="5" class="text" ng-repeat="item in items.child">
        <span hidden class="function-code" data="{{item.functionCode}}"></span>
        <a ng-if="item.url" class="url" href="{{item.url}}">
            <span class="fa {{item.icon}} fa-buysellads"></span>
            <span> {{item.functionName}} </span>
            <div ng-if="item.child.length > 0" class="down -ap icon-chevron-right22"></div>
        </a>
        <a ng-if="!item.url" class="url" href="javascript:;">
            <span class="fa {{item.icon}} fa-buysellads"></span>
            <span> {{item.functionName}} </span>
            <div ng-if="item.child.length > 0" class="down -ap icon-chevron-right22"></div>
        </a>
        <ul ng-if="item.child.length > 0" class="dropdown-menu menu-component" childdata="item"></ul>
    </li>