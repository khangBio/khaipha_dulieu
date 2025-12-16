<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script type="text/javascript"
        src="${pageContext.request.contextPath}/resources/style-dancu/vendor/jquery/jquery.2.1.1.min.js"></script>
<script type="text/javascript"
        src="${pageContext.request.contextPath}/resources/style-dancu/vendor/bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript"
        src="${pageContext.request.contextPath}/resources/style-dancu/vendor/select2/4.07/select2.min.js"></script>
<!-- script type="text/javascript" src="style-dancu/vendor/select2/4.07/ScriptTest.js"></script> -->
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/style-dancu/js/custom.js"></script>
<script type="text/javascript"
        src="${pageContext.request.contextPath}/resources/style-dancu/vendor/jquery/moment.min.js"></script>
<script type="text/javascript"
        src="${pageContext.request.contextPath}/resources/style-dancu/vendor/footable-bootstrap/js/footable.min.js"></script>
<script type="text/javascript"
        src="${pageContext.request.contextPath}/resources/style-dancu/vendor/bootstrap-datepicker/js/bootstrap-datepicker.min.js"
        charset="utf-8"></script>
<script
        src="${pageContext.request.contextPath}/resources/style-dancu/vendor/bootstrap-datepicker/locales/bootstrap-datepicker.vi.min.js"
        charset="utf-8"></script>

<script
        src="${pageContext.request.contextPath}/resources/style-dancu/vendor/datatable/js/jquery.dataTables.min.js"></script>
<script
        src="${pageContext.request.contextPath}/resources/style-dancu/vendor/datatable/js/dataTables.bootstrap.js"></script>
<script src="${pageContext.request.contextPath}/resources/style-dancu/vendor/datatable/js/datatables-init-vi.js"
        charset="utf-8"></script>
<script src="${pageContext.request.contextPath}/resources/module/jquery-qrcode/jquery.qrcode.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/module/select2/js/select2.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/module/jquery-confirm/js/jquery-confirm.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/style-dancu/vendor/toastr/toastr.min.js"></script>
<script
        src="${pageContext.request.contextPath}/resources/module/bootstrap-datepicker/js/bootstrap-datepicker.min.js"></script>
<script
        src="${pageContext.request.contextPath}/resources/module/bootstrap-datepicker/js/bootstrap-datepicker.vi.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/module/bootstrap-datepicker/js/jquery.mask.min.js"></script>
<!-- <script src="${pageContext.request.contextPath}/resources/module/swig/swig.js"></script> -->
<script src="${pageContext.request.contextPath}/resources/lib/lib.js?v=1"></script>
<script src="${pageContext.request.contextPath}/resources/custom-uiux/custom.js?v=1.1"></script>
<script src="${pageContext.request.contextPath}/resources/style-dancu/vendor/highchart/highcharts.js"></script>
<%--<script src="/notification/resources/notify.js?v=2"></script>--%>
<script type="text/javascript">
    $(function () {

    });
    function initModelDecisionTree() {
        let percentage = $("#percentage-split-train").val() ? $("#percentage-split-train").val() : 0;
        if (percentage <= 0) {
            lib.showMessage('Vui lòng nhập tỉ lệ tập train!', 'error', function () {
                //
            });
            return;
        }
        lib.getApi({
            url: $("#PageContext").val() + '/do-model-decission-tree',
            data: {
                percentage: percentage
            },
            complete: function (response) {
                $("#formModel").uiLoading(false);
                let res = response;
                renderKetQuaModel(res);
                renderConfusionMatrix(res);
                renderDetailedAccuracy(res);
            },
            error: function (ex) {
                $("#formModel").uiLoading(false);
            }
        });

        function renderKetQuaModel(res){
            $("#chiso-danhgia-model").empty();
            $("#chiso-danhgia-model").append('' +
                '<p><b>Accuracy:</b> ' + res.accuracy.toFixed(3) + '</p>' +
                '<p><b>Kappa:</b> ' + res.kappa.toFixed(3) + '</p>'+
                '<p><b>Mean Absolute Error (MAE):</b> ' + res.meanAbsoluteError.toFixed(3) + '</p>'+
                '<p><b>Mean Squared Error (MSE):</b> ' + res.meanSquaredError.toFixed(3) + '</p>');
        }

        function renderConfusionMatrix(res){
            let confusionMatrix = res.confusionMatrix;
            let outa = confusionMatrix[0];
            let inb = confusionMatrix[1];

            $("#confusion-matrix").empty();
            $("#confusion-matrix").append('' +
                '<tr class="tr-list">'+
                    '<td class="colf-status-center">out</td>'+
                    '<td class="colf-status-center">' + outa[0] + '</td>'+
                    '<td class="colf-status-center">' + outa[1] + '</td>'+
                '</tr>'+
                '<tr class="tr-list">'+
                    '<td class="colf-status-center">in</td>'+
                    '<td class="colf-status-center">' + inb[0] + '</td>'+
                    '<td class="colf-status-center">' + inb[1] + '</td>'+
                '</tr>');
        }

        function renderDetailedAccuracy(res){
            let preOut = res.classMetrics.out;
            let preIn = res.classMetrics.in;
            $("#detailed-accuracy").empty();
            $("#detailed-accuracy").append('' +
                '<tr class="tr-list">'+
                    '<td class="colf-status-center">' + preOut.precision.toFixed(3) + '</td>'+
                    '<td class="colf-status-center">' + preOut.recall.toFixed(3) + '</td>'+
                    '<td class="colf-status-center">' + preOut.f1.toFixed(3) + '</td>'+
                    '<td class="colf-status-center">' + preOut.roc.toFixed(3) + '</td>'+
                    '<td class="colf-status-center">out</td>'+
                '</tr>' +
                '<tr class="tr-list">'+
                    '<td class="colf-status-center">' + preIn.precision.toFixed(3) + '</td>'+
                    '<td class="colf-status-center">' + preIn.recall.toFixed(3) + '</td>'+
                    '<td class="colf-status-center">' + preIn.f1.toFixed(3) + '</td>'+
                    '<td class="colf-status-center">' + preIn.roc.toFixed(3) + '</td>'+
                    '<td class="colf-status-center">in</td>'+
                '</tr>');
        }
    }
</script>
