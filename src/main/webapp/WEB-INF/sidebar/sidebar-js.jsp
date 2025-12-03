<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>

<script>
    app.controller('sideBar', function ($scope, $http, $timeout) {
        $scope.listdata = [];
        $scope.isLoadDone = false;


        this.$onInit = function () {
            $scope.getdata();
        };

        $scope.getdata = function () {
            debugger
            $http({
                method: 'GET',
                url: '${pageContext.request.contextPath}' + '/share/getmenus'
            }).then(function (responseJson) {
                var data = responseJson.data.data;
                console.log('data', JSON.parse(JSON.stringify(data)));
                for (var item of data.filter(x => x.parentCode !== undefined)) {
                    item.child = data.filter(x => x.parentCode !== "" && x.parentCode === item.functionCode);
                }

                for (var item of data.filter(x => x.parentCode === undefined)) {
                    item.child = data.filter(x => x.parentCode === "" && x.systemId === item.functionCode);
                }

                let menuRoot = data.filter(x => x.parentCode === undefined);
                for (const item of menuRoot) {
                    $scope.setUrl(item, item.url);
                }
                menuRoot = $scope.sort(menuRoot, false);
                $scope.listdata = menuRoot;
                console.log('data', $scope.listdata);
                $timeout(function () {
                    $scope.expand();
                    $scope.isLoadDone = true;
                }, 100)
            });
        }

        $scope.sort = function (item, isChild){
            if(isChild){
                item = item.sort((a,b)=> a.stt - b.stt);
            }else{
                item = item.sort((a,b)=> parseInt(a.functionCode) - parseInt(b.functionCode));
            }
            for (var itemChild of item){
                if(itemChild.child.length > 0){
                    itemChild.child = $scope.sort(itemChild.child, true)
                }
            }

            return item;
        }

        $scope.setUrl = function (item, url) {
            if (url && item.child && item.child.length > 0) {
                for (const itemUrl of item.child) {
                    if (itemUrl.url && !itemUrl.url.startsWith('http')) {
                        itemUrl.url = url + itemUrl.url;
                    }
                    $scope.setUrl(itemUrl, url);
                }
            }
        }

        $scope.expand = function () {
            var path = window.location.pathname;
            $(".menus li").each(function () {
                var link = $(this).find(">a").attr("href");
                if (path.includes(link)) {
                    $(this).parents('.item').addClass('open');
                    $(this).parents('li').addClass('open');
                    $(this).addClass("active open");
                    return;
                }
            });
        }
    })
</script>