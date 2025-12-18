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

    function initModelRandomForest() {
        let percentage = $("#rf-percentage-split-train").val() ? $("#rf-percentage-split-train").val() : 0;
        if (percentage <= 0) {
            lib.showMessage('Vui lòng nhập tỉ lệ tập train!', 'error', function () {
                //
            });
            return;
        }
        lib.getApi({
            url: $("#PageContext").val() + '/do-model-random-forest',
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
            $("#rf-chiso-danhgia-model").empty();
            $("#rf-chiso-danhgia-model").append('' +
                '<p><b>Accuracy:</b> ' + res.accuracy.toFixed(3) + '</p>' +
                '<p><b>Kappa:</b> ' + res.kappa.toFixed(3) + '</p>'+
                '<p><b>Mean Absolute Error (MAE):</b> ' + res.meanAbsoluteError.toFixed(3) + '</p>'+
                '<p><b>Mean Squared Error (MSE):</b> ' + res.meanSquaredError.toFixed(3) + '</p>');
        }

        function renderConfusionMatrix(res){
            let confusionMatrix = res.confusionMatrix;
            let outa = confusionMatrix[0];
            let inb = confusionMatrix[1];

            $("#rf-confusion-matrix").empty();
            $("#rf-confusion-matrix").append('' +
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
            $("#rf-detailed-accuracy").empty();
            $("#rf-detailed-accuracy").append('' +
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

    function predictPatient(){
        $("#formThongTinBenhNhan").resetValidation();
        var checkValid = $("#formThongTinBenhNhan").validation({
            required: {
                erythrocyte: "Chỉ số ERYTHROCYTE không được trống!",
                haematocrit: "Chỉ số HAEMATOCRIT không được trống!",
                haemoglobins: "Chỉ số HAEMOGLOBINS không được trống!",
                leucocyte: "Chỉ số LEUCOCYTE không được trống!",
                thrombocyte: "Chỉ số THROMBOCYTE không được trống!",
                mch: "Chỉ số LEUCOCYTE không được trống!",
                mchc: "Chỉ số MCHC không được trống!",
                mcv: "Chỉ số MCV không được trống!",
                age: "AGE không được trống!",
            },
            min: {
                haematocrit: {value: 13.7 , message: "Chỉ số HAEMATOCRIT không được nhỏ hơn 13.7"},
                haemoglobins: {value: 3.8 , message: "Chỉ số HAEMOGLOBINS không được nhỏ hơn 3.8"},
                erythrocyte: {value: 1.48 , message: "Chỉ số ERYTHROCYTE không được nhỏ hơn 1.48"},
                leucocyte: {value: 1.1 , message: "Chỉ số LEUCOCYTE không được nhỏ hơn 1.1"},
                thrombocyte: {value: 8 , message: "Chỉ số THROMBOCYTE không được nhỏ hơn 8"},
                mch: {value: 14.9 , message: "Chỉ số MCH không được nhỏ hơn 14.9"},
                mchc: {value: 26 , message: "Chỉ số MCHC không được nhỏ hơn 26"},
                mcv: {value: 54 , message: "Chỉ số MCV không được nhỏ hơn 54"},
                age: {value: 1 , message: "Chỉ số AGE không được nhỏ hơn 1"},
            },
            max: {
                haematocrit: {value: 69 , message: "Chỉ số HAEMATOCRIT không được lớn hơn 69"},
                haemoglobins: {value: 19.8 , message: "Chỉ số HAEMOGLOBINS không được lớn hơn 19.8"},
                erythrocyte: {value: 7.86 , message: "Chỉ số ERYTHROCYTE không được lớn hơn 7.86"},
                leucocyte: {value: 76.6 , message: "Chỉ số LEUCOCYTE không được nhỏ lớn hơn 76.6"},
                thrombocyte: {value: 1183 , message: "Chỉ số THROMBOCYTE không được lớn hơn 1183"},
                mch: {value: 40.8 , message: "Chỉ số MCH không được lớn hơn 40.8"},
                mchc: {value: 39 , message: "Chỉ số MCHC không được lớn hơn 39"},
                mcv: {value: 116 , message: "Chỉ số MCV không được lớn hơn 116"},
                age: {value: 99 , message: "Chỉ số AGE không được lớn hơn 99"},
            }
        });
        if (!checkValid.isValid) {
            $("#formThongTinBenhNhan").bindError(checkValid);
            return;
        }
        $("#formThongTinBenhNhan").formTextTrim();
        var jsonData = $("#formThongTinBenhNhan").getValue();
        lib.post({
            url: $("#PageContext").val() + "/predict-result",
            data: JSON.stringify(jsonData),
            beforePost:function(){
                $("#formThongTinBenhNhan").uiLoading(true);
            },
            complete: function (response) {
                let result = response.responseJSON.predictedclass;
                let rfResult = response.responseJSON.predictedclassRF;

                let probability = (result.probability * 100).toFixed(2) + '%';
                let probabilityRF = (rfResult.probability * 100).toFixed(2) + '%';
                /**Kết quả dự đoán Decission Tree**/
                $("#formThongTinBenhNhan").uiLoading(false);
                $("#predict-patient-class").empty();
                $("#predict-patient-class").append('' +
                    '<p style="font-size: 14px; color: #2563eb">' +
                    '<b>Decision Tree:</b> ' + result.predictedClass + '</p>');

                $("#predict-probability").empty();
                $("#predict-probability").append('' +
                    '<p style="font-size: 14px; color: #2563eb">' +
                    '<b>Probability: </b>' + probability + '</p>');

                /**Kết quả dự đoán Random Forest**/
                $("#rf-predict-patient-class").empty();
                $("#rf-predict-patient-class").append('' +
                    '<p style="font-size: 14px; color: #2563eb">' +
                    '<b>Decision Tree:</b> ' + rfResult.predictedClass + '</p>');

                $("#rf-predict-probability").empty();
                $("#rf-predict-probability").append('' +
                    '<p style="font-size: 14px; color: #2563eb">' +
                    '<b>Probability: </b>' + probabilityRF + '</p>');
            },
            error: function (ex) {
                $("#formThongTinBenhNhan").uiLoading(false);
            }
        });
    }

    function huyThongTin(){
        $("#formThongTinBenhNhan").pathValue({
            haematocrit: 0,
            haemoglobins: 0,
            erythrocyte: 0,
            leucocyte: 0,
            thrombocyte: 0,
            mch: 0,
            mchc: 0,
            mcv: 0,
            age: 0,
        });
    }
</script>
