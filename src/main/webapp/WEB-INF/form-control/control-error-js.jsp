<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<script>
    app.directive('controlError', function($http, $timeout, $parse, $interpolate) {
        return {
            restrict : 'E',
            template: '<span class="error-message">a{{key}}</span>',
            scope: {
                key: '@',
            },
            controller:function($scope){

            },
            link: function(scope, element, attrs){

            }
        };
    });
</script>
