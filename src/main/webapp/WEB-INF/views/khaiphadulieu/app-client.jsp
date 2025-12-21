<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<head>
    <jsp:include page="app-js.jsp"/>
</head>
<style>
    .table-fixed {
        width: 100%;
        border-collapse: collapse;
        table-layout: fixed; /* QUAN TRỌNG */
    }

    .table-fixed thead {
        position: sticky;
        top: 0;
        background: #f8e9df;
        z-index: 2;
    }

    .table-fixed th,
    .table-fixed td {
        text-align: center;
        padding: 8px;
        border: 1px solid #ddd;
        width: 20%; /* 5 cột → mỗi cột 20% */
    }
</style>
<div class="box">
    <div class="box-body">
        <h1 class="main-title">Patient Treatment Classification</h1>
        <form id="formModel">
            <div class="row">
                <div class="col-sm-4 col-xs-12">
                    <section class="panel" id="model-a">
                        <div class="panel__header">
                            <div>
                                <h2 class="panel__title">Decission Tree</h2>
                                <p class="panel__subtitle">Mô tả: Cây quyết định</p>
                                <p class="panel__subtitle">Cập nhật lần cuối: 20/12/2025</p>
                            </div>
                            <span style="font-size:12px;color:#2563eb;font-weight:700;">ACTIVE</span>
                        </div>
                        <div class="panel__body" id="decission-tree-body">
                            <div class="row">
                                <div class="col-sm-4 col-xs-12">
                                    <div class="form-group form-label-top">
                                        <div class="label-text">Percentage Split Train (%)<span class="text-danger"> *</span></div>
                                        <input class="form-control" type="number" name="percentage-split-train" id="percentage-split-train" value="" autocomplete="off">
                                    </div>
                                </div>
                                <div class="col-sm-1 col-xs-12"></div>
                                <div class="col-sm-3 col-xs-12">
                                    <div class="form-title">KẾT QUẢ DỰ ĐOÁN</div>
                                </div>
                                <div class="col-sm-2 col-xs-12" id="predict-patient-class">
                                    <p style="font-size: 14px; color: #2563eb"><b>Decision Tree: </b> ?</p>
                                </div>
                                <div class="col-sm-2 col-xs-12" id="predict-probability">
                                    <p style="font-size: 14px; color: #2563eb"><b>Probability: </b> ?%</p>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-sm-5 col-xs-12" id="chiso-danhgia-model">
                                    <p><b>Accuracy:</b>N/A</p>
                                    <p><b>Kappa:</b>N/A</p>
<%--                                    <p><b>Mean Absolute Error (MAE):</b>N/A</p>--%>
<%--                                    <p><b>Mean Squared Error (MSE):</b>N/A</p>--%>
<%--                                    <p><b>Train Time:</b> <span id="dt-build-time" style="color: #d63384">?</span> s</p>--%>
                                </div>
                                <div class="col-sm-7 col-xs-12">
                                    <table class="table table-fixed">
                                        <thead>
                                            <tr>
                                                <th class="colf-status-center">Confusion Matrix</th>
                                                <th class="colf-status-center">out</th>
                                                <th class="colf-status-center">in</th>
                                            </tr>
                                        </thead>
                                        <tbody id="confusion-matrix" style="max-height: calc(100vh - 360px);">
                                            <tr class="tr-list">
                                                <td class="colf-status-center">out</td>
                                                <td class="colf-status-center">0</td>
                                                <td class="colf-status-center">0</td>
                                            </tr>
                                            <tr class="tr-list">
                                                <td class="colf-status-center">in</td>
                                                <td class="colf-status-center">0</td>
                                                <td class="colf-status-center">0</td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-sm-12 col-xs-12">
                                    <table class="table table-fixed">
                                        <thead>
                                            <tr>
                                                <th class="colf-status-center">Precision</th>
                                                <th class="colf-status-center">Recall</th>
                                                <th class="colf-status-center">F-Measure</th>
                                                <th class="colf-status-center">ROC Area</th>
                                                <th class="colf-status-center">Class</th>
                                            </tr>
                                        </thead>
                                        <tbody id="detailed-accuracy" style="max-height: calc(100vh - 360px);">
                                            <tr class="tr-list">
                                                <td class="colf-status-center">0</td>
                                                <td class="colf-status-center">0</td>
                                                <td class="colf-status-center">0</td>
                                                <td class="colf-status-center">0</td>
                                                <td class="colf-status-center">0</td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                        <div class="panel__footer">
                            <button type="button" class="btn btn--primary" onclick="initModelDecisionTree()">Run</button>
                        </div>
                    </section>
                </div>
                <div class="col-sm-4 col-xs-12">
                    <section class="panel" id="model-a">
                        <div class="panel__header">
                            <div>
                                <h2 class="panel__title">Random Forest</h2>
                                <p class="panel__subtitle">Mô tả: Rừng ngẫu nhiên</p>
                                <p class="panel__subtitle">Cập nhật lần cuối: 20/12/2025</p>
                            </div>
                            <span style="font-size:12px;color:#2563eb;font-weight:700;">ACTIVE</span>
                        </div>
                        <div class="panel__body" id="random-forest-body">
                            <div class="row">
                                <div class="col-sm-4 col-xs-12">
                                    <div class="form-group form-label-top">
                                        <div class="label-text">Percentage Split Train (%)<span class="text-danger"> *</span></div>
                                        <input class="form-control" type="number" name="rf-percentage-split-train" id="rf-percentage-split-train" value="" autocomplete="off">
                                    </div>
                                </div>
                                <div class="col-sm-1 col-xs-12"></div>
                                <div class="col-sm-3 col-xs-12">
                                    <div class="form-title">KẾT QUẢ DỰ ĐOÁN</div>
                                </div>
                                <div class="col-sm-2 col-xs-12" id="rf-predict-patient-class">
                                    <p style="font-size: 14px; color: #2563eb"><b>Decision Tree: </b> ?</p>
                                </div>
                                <div class="col-sm-2 col-xs-12" id="rf-predict-probability">
                                    <p style="font-size: 14px; color: #2563eb"><b>Probability: </b> ?%</p>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-sm-5 col-xs-12" id="rf-chiso-danhgia-model">
                                    <p><b>Accuracy:</b>N/A</p>
                                    <p><b>Kappa:</b>N/A</p>
<%--                                    <p><b>Mean Absolute Error (MAE):</b>N/A</p>--%>
<%--                                    <p><b>Mean Squared Error (MSE):</b>N/A</p>--%>
<%--                                    <p><b>Train Time:</b> <span id="rf-build-time" style="color: #d63384">?</span> s</p>--%>
                                </div>
                                <div class="col-sm-7 col-xs-12">
                                    <table class="table table-fixed">
                                        <thead>
                                        <tr>
                                            <th class="colf-status-center">Confusion Matrix</th>
                                            <th class="colf-status-center">out</th>
                                            <th class="colf-status-center">in</th>
                                        </tr>
                                        </thead>
                                        <tbody id="rf-confusion-matrix" style="max-height: calc(100vh - 360px);">
                                        <tr class="tr-list">
                                            <td class="colf-status-center">out</td>
                                            <td class="colf-status-center">0</td>
                                            <td class="colf-status-center">0</td>
                                        </tr>
                                        <tr class="tr-list">
                                            <td class="colf-status-center">in</td>
                                            <td class="colf-status-center">0</td>
                                            <td class="colf-status-center">0</td>
                                        </tr>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-sm-12 col-xs-12">
                                    <table class="table table-fixed">
                                        <thead>
                                        <tr>
                                            <th class="colf-status-center">Precision</th>
                                            <th class="colf-status-center">Recall</th>
                                            <th class="colf-status-center">F-Measure</th>
                                            <th class="colf-status-center">ROC Area</th>
                                            <th class="colf-status-center">Class</th>
                                        </tr>
                                        </thead>
                                        <tbody id="rf-detailed-accuracy" style="max-height: calc(100vh - 360px);">
                                        <tr class="tr-list">
                                            <td class="colf-status-center">0</td>
                                            <td class="colf-status-center">0</td>
                                            <td class="colf-status-center">0</td>
                                            <td class="colf-status-center">0</td>
                                            <td class="colf-status-center">0</td>
                                        </tr>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                        <div class="panel__footer">
                            <button type="button" class="btn btn--primary" onclick="initModelRandomForest()">Run</button>
                        </div>
                    </section>
                </div>
                <div class="col-sm-4 col-xs-12">
                    <section class="panel" id="model-svm">
                        <div class="panel__header">
                            <div>
                                <h2 class="panel__title">SVM (SMO)</h2>
                                <p class="panel__subtitle">Mô tả: Support Vector Machine</p>
                                <p class="panel__subtitle">Cập nhật lần cuối: 20/12/2025</p>
                            </div>
                            <span style="font-size:12px;color:#2563eb;font-weight:700;">ACTIVE</span>
                        </div>
                        <div class="panel__body" id="svm-body">
                            <div class="row">
                                <div class="col-sm-4 col-xs-12">
                                    <div class="form-group form-label-top">
                                        <div class="label-text">Train Split (%)<span class="text-danger"> *</span></div>
                                        <input class="form-control" type="number" name="svm-percentage-split-train" id="svm-percentage-split-train" autocomplete="off">
                                    </div>
                                </div>
                                <div class="col-sm-3 col-xs-12">
                                    <div class="form-title">KẾT QUẢ DỰ ĐOÁN</div>
                                </div>
                                <div class="col-sm-2 col-xs-12" id="svm-predict-patient-class">
                                    <p style="font-size: 14px; color: #2563eb"><b>SVM: </b> ?</p>
                                </div>
                                <div class="col-sm-2 col-xs-12" id="svm-predict-probability">
                                    <p style="font-size: 14px; color: #2563eb"><b>Probability: </b> ?%</p>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-sm-5 col-xs-12" id="svm-chiso-danhgia-model">
                                    <p><b>Accuracy:</b> N/A</p>
                                    <p><b>Kappa:</b> N/A</p>
<%--                                    <p><b>Mean Absolute Error (MAE):</b>N/A</p>--%>
<%--                                    <p><b>Mean Squared Error (MSE):</b>N/A</p>--%>
<%--                                    <p><b>Train Time:</b> <span id="svm-build-time" style="color: #d63384">?</span> s</p>--%>
                                </div>
                                <div class="col-sm-7 col-xs-12">
                                    <table class="table table-fixed">
                                        <thead>
                                        <tr>
                                            <th class="colf-status-center">Confusion Matrix</th>
                                            <th class="colf-status-center">out</th>
                                            <th class="colf-status-center">in</th>
                                        </tr>
                                        </thead>
                                        <tbody id="svm-confusion-matrix">
                                        <tr class="tr-list">
                                            <td class="colf-status-center">out</td>
                                            <td class="colf-status-center">0</td>
                                            <td class="colf-status-center">0</td>
                                        </tr>
                                        <tr class="tr-list">
                                            <td class="colf-status-center">in</td>
                                            <td class="colf-status-center">0</td>
                                            <td class="colf-status-center">0</td>
                                        </tr>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-sm-12 col-xs-12">
                                    <table class="table table-fixed">
                                        <thead>
                                        <tr>
                                            <th class="colf-status-center">Precision</th>
                                            <th class="colf-status-center">Recall</th>
                                            <th class="colf-status-center">F-Measure</th>
                                            <th class="colf-status-center">ROC Area</th>
                                            <th class="colf-status-center">Class</th>
                                        </tr>
                                        </thead>
                                        <tbody id="svm-detailed-accuracy">
                                        <tr class="tr-list">
                                            <td class="colf-status-center">0</td>
                                            <td class="colf-status-center">0</td>
                                            <td class="colf-status-center">0</td>
                                            <td class="colf-status-center">0</td>
                                            <td class="colf-status-center">0</td>
                                        </tr>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                        <div class="panel__footer">
                            <button type="button" class="btn btn--primary" onclick="initModelSVM()">Run SVM</button>
                        </div>
                    </section>
                </div>
            </div>
        </form>
        <form id="formThongTinBenhNhan">
            <div class="row" hidden="hidden">
                <input type="number" id="idKhachHang"/>
            </div>
            <div class="row">
                <div class="col-sm-2 col-xs-12">
                    <div class="form-group form-label-top">
                        <div class="label-text">HAEMATOCRIT<span class="text-danger"> *</span></div>
                        <input class="form-control" type="number" name="haematocrit" id="haematocrit" value="" autocomplete="off">
                    </div>
                </div>
                <div class="col-sm-2 col-xs-12">
                    <div class="form-group form-label-top">
                        <div class="label-text">HAEMOGLOBINS<span class="text-danger"> *</span></div>
                        <input class="form-control" type="number" name="haemoglobins" id="haemoglobins" value="" autocomplete="off">
                    </div>
                </div>
                <div class="col-sm-2 col-xs-12">
                    <div class="form-group form-label-top">
                        <div class="label-text">ERYTHROCYTE<span class="text-danger"> *</span></div>
                        <input class="form-control" type="number" name="erythrocyte" id="erythrocyte" value="" autocomplete="off">
                    </div>
                </div>
                <div class="col-sm-2 col-xs-12">
                    <div class="form-group form-label-top">
                        <div class="label-text">LEUCOCYTE<span class="text-danger"> *</span></div>
                        <input class="form-control" type="number" name="leucocyte" id="leucocyte" value="" autocomplete="off">
                    </div>
                </div>
                <div class="col-sm-2 col-xs-12">
                    <div class="form-group form-label-top">
                        <div class="label-text">THROMBOCYTE<span class="text-danger"> *</span></div>
                        <input class="form-control" type="number" name="thrombocyte" id="thrombocyte" value="" autocomplete="off">
                    </div>
                </div>
                <div class="col-sm-2 col-xs-12">
                    <div class="form-group form-label-top">
                        <div class="label-text">MCH<span class="text-danger"> *</span></div>
                        <input class="form-control" type="number" name="mch" id="mch" value="" autocomplete="off">
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-sm-2 col-xs-12">
                    <div class="form-group form-label-top">

                        <div class="label-text">MCHC<span class="text-danger"> *</span></div>
                        <input class="form-control" type="number" name="mchc" id="mchc" value="" autocomplete="off">
                    </div>
                </div>
                <div class="col-sm-2 col-xs-12">
                    <div class="form-group form-label-top">
                        <div class="label-text">MCV<span class="text-danger"> *</span></div>
                        <input class="form-control" type="number" name="mcv" id="mcv" value="" autocomplete="off">
                    </div>
                </div>
                <div class="col-sm-2 col-xs-12">
                    <div class="form-group form-label-top">
                        <div class="label-text">AGE<span class="text-danger"> *</span></div>
                        <input class="form-control" type="number" name="age" id="age" value="" autocomplete="off">
                    </div>
                </div>
                <div class="col-sm-2 col-xs-12">
                    <div class="form-group form-label-top">
                        <div class="label-text">Giới tính (SEX)</div>
                        <select class="form-control" name="sex" id="sex" disabled="disabled">
                            <option value="F" selected>FeMale</option>
                            <option value="M">Male</option>
                        </select>
                    </div>
                </div>
                <div class="col-sm-4 col-xs-12">
                    <div class="form-group form-label-top">
                        <div class="label-text">Điều trị(SOURCE)</div>
                        <select class="form-control" name="source" id="source" disabled="disabled">
                            <option value="in" selected>In (Nội trú)</option>
                            <option value="out">Out (Ngoại trú)</option>
                        </select>
                    </div>
                </div>
            </div>
            <input type="hidden" name="page" value="1">
            <div class="box box-scroll">
                <div class="box-body">
                    <div class="center">
                        <ul class="menu-list-item">
                            <li class="item-menu not-show-on-editing" id="btn_predict">
                                <a href="javascript:;" class="btn btn-main"
                                   onclick="predictPatient()">
                                    <span class="icon nc-icon-outline ui-1_edit-71"></span>
                                    Dự đoán
                                </a>
                            </li>
                            <li class="item-menu not-show-on-editing">
                                <a href="javascript:;" class="btn btn-primary" style="background-color: #17a2b8; border-color: #17a2b8;" onclick="fillDefaultData()">
                                    <span class="icon nc-icon-outline ui-1_simple-add"></span> Dữ liệu mẫu
                                </a>
                            </li>
                            <li class="item-menu not-show-on-editing" id="btn-huy-thong-tin">
                                <a href="javascript:;" class="btn btn-danger"
                                   onclick="huyThongTin('them')">
                                    <span class="icon nc-icon-outline ui-1_circle-delete"></span>
                                    Hủy
                                </a>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
        </form>
    </div>
</div>
