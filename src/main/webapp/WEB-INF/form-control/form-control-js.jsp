<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<script>
    app.directive('formControl', function($http, $timeout, $parse, $interpolate) {
        return {
            restrict : 'C',
            require : '?ngModel', // get a hold of NgModelController
            link : function($scope, el, attrs, $ngModel) {
                if($ngModel){
                    // $scope.$watch(function() {
                    //     return $ngModel.$viewValue;
                    // }, function(newVal) {
                    //     checkValueActive(newVal);
                    // });
                    //
                    // $scope.$watch(function() {
                    //     return $scope.$eval(el.attr('ng-disabled'))
                    // }, function(newValue){
                    //     checkDisable(newValue);
                    // });

                    $scope.$watchGroup([
                        function() {
                            return $ngModel.$viewValue;
                        },
                        function() {
                            return $scope.$eval(el.attr('ng-disabled'))
                        }
                    ],function(newVal) {
                        checkValueActive(newVal);
                    })
                }

                function checkValueActive(value) {
                    if(value[1]){
                        el.parents('.form-label-top').addClass('active');
                    } else {
                        if(value[0] !== undefined && value[0] !== null && value[0] !== '') {
                            el.parents('.form-label-top').addClass('active');
                        }else{
                            el.parents('.form-label-top').removeClass('active');
                        }
                    }
                }
            }
        };
    });
</script>
