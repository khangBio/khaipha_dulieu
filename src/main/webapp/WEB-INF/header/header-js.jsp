<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>

<script>
    $('#user_manual_func').on('click', function (e) {
        e.preventDefault();
        get_user_manual();
        var win = window.open($(this).attr('href'), '_blank');
        win.focus();
    });

    app.controller('header', function ($scope, $http, $timeout) {
        $scope.listNotification = [];
        $scope.isLoadDone = false;
        $scope.setreadflag = false;
        $scope.hasUnseen = false;

        this.$onInit = function () {
            $scope.getNotification();
        };

        $scope.getNotification = function () {
            $http({
                method: 'GET',
                url: '${pageContext.request.contextPath}' + '/share/getNotification'
            }).then(function (responseJson) {
                $scope.listNotification = responseJson.data;
                var temp = $scope.listNotification.filter(function(item){
                	return item.seen==0;
                });
                if (temp.length>0)
                	$scope.hasUnseen = true;
            });
        }
        
        $scope.setRead = function() {
        	if (!$scope.setreadflag) {
        	setTimeout(function(){
        		$http({
                    method: 'GET',
                    url: '${pageContext.request.contextPath}' + '/share/setReadNotification'
                }).then(function (responseJson) {
                });
        	}, 1000);
        	}
        	
        	$scope.setreadflag = true;
        	$scope.hasUnseen = false;
        }

    });

    function get_user_manual() {
        var functionCode = $('.sidebar-menu .mscrollable .menus div.item li.active .function-code').attr('data') === undefined ? '0' : $('.sidebar-menu .mscrollable .menus div.item li.active .function-code').attr('data');
        $("#user_manual_func").attr("href", "/qtud/cloudadmin/comm_user_manual/user_manual_func_exec?function_code=" + functionCode);
    }

</script>