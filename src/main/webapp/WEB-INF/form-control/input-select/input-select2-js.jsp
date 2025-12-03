<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<script>
    app.directive('inputSelect', function($http, $timeout, $parse, $interpolate) {
        return {
            restrict : 'E',
            template: '<select class="form-control" name="type" ng-model="type">    ' +
                '                                                    <option value="0" selected>Tất cả</option>    ' +
                '                                                    <option value="1">Biểu đồ cột</option>    ' +
                '                                                    <option value="2">Biểu đồ dây</option>    ' +
                '                                                    <option value="3">Biểu đồ bảng</option>    ' +
                '                                                    <option value="4">Biểu đồ tròn</option>    ' +
                '                                                </select>    ' +
                '                                            </select>type:{{type}}',
            // template: '<select id="type" ' +
            //     '  ng-model="type" ' +
            //     '  ng-options="value.color as value.model for (key, value) in cars" ' +
            //     '  ></select>',
            scope: {
            },
            controller:function($scope){
                $scope.type= "1";
            },
            link: function(scope, element, attrs){

            }
        };
    });
</script>
