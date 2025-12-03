<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<script type='text/ng-template' id='menu-component.html'>
	<jsp:include page="../menu/menu-html.jsp"/>
</script>
<script>
	app.directive('menuComponent', function($http, $timeout, $parse) {
		return {
			restrict : 'C',
			templateUrl : 'menu-component.html',
			scope: { items:'=childdata'},
			link : function($scope, el, attrs) {

			}
		};
	});
</script>
