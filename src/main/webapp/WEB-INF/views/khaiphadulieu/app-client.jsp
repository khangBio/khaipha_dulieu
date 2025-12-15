<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<head>
    <jsp:include page="app-js.jsp"/>
</head>
<div class="box">
    <div class="box-body">
        <h1 class="main-title">THÔNG TIN CHỈ SỐ XÉT NGHIỆM CỦA BỆNH NHÂN</h1>
        <form id="formModel">
            <div class="row">
                <div class="col-sm-6 col-xs-12">
                    <section class="panel" id="model-a">
                        <div class="panel__header">
                            <div>
                                <h2 class="panel__title">Thông tin bệnh nhân</h2>
                                <p class="panel__subtitle">Cập nhật lần cuối: 12/12/2025</p>
                            </div>
                            <span style="font-size:12px;color:#2563eb;font-weight:700;">ACTIVE</span>
                        </div>
                        <div class="panel__body">
                            <p><b>Họ tên:</b> Nguyễn Văn A</p>
                            <p><b>Tuổi:</b> 45</p>
                            <p><b>Ghi chú:</b> Đây là nội dung panel. Bạn có thể thay bằng form, bảng, hoặc danh sách.</p>
                        </div>

                        <div class="panel__footer">
                            <button class="btn">Hủy</button>
                            <button class="btn btn--primary">Lưu</button>
                        </div>
                    </section>
                </div>
                <div class="col-sm-6 col-xs-12">
                    <section class="panel" id="model-b">
                        <div class="panel__header">
                            <div>
                                <h2 class="panel__title">Thông tin bệnh nhân</h2>
                                <p class="panel__subtitle">Cập nhật lần cuối: 12/12/2025</p>
                            </div>
                            <span style="font-size:12px;color:#2563eb;font-weight:700;">ACTIVE</span>
                        </div>

                        <div class="panel__body">
                            <p><b>Họ tên:</b> Nguyễn Văn A</p>
                            <p><b>Tuổi:</b> 45</p>
                            <p><b>Ghi chú:</b> Đây là nội dung panel. Bạn có thể thay bằng form, bảng, hoặc danh sách.</p>
                        </div>

                        <div class="panel__footer">
                            <button class="btn">Hủy</button>
                            <button class="btn btn--primary">Lưu</button>
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
                        <select class="form-control" name="sex" id="sex">
                            <option value="F" selected>FeMale</option>
                            <option value="M">Male</option>
                        </select>
                    </div>
                </div>
                <div class="col-sm-4 col-xs-12">
                    <div class="form-group form-label-top">
                        <div class="label-text">Điều trị(SOURCE)</div>
                        <select class="form-control" name="source" id="source">
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
                            <li class="item-menu not-show-on-editing" id="btn_cap_nhat_khach_hang">
                                <a href="javascript:;" class="btn btn-main"
                                   onclick="themMoiKhachHang('them')">
                                    <span class="icon nc-icon-outline ui-1_edit-71"></span>
                                    Ghi thông tin
                                </a>
                            </li>
                            <li class="item-menu not-show-on-editing" id="btn_search_data">
                                <a href="javascript:;" class="btn btn-main"
                                   onclick="traCuuDanhSachHoBienDong('traCuuBienDong')">
                                    <span class="icon nc-icon-outline ui-1_zoom"></span>
                                    Tìm kiếm
                                </a>
                            </li>
                            <li class="item-menu not-show-on-editing" id="btn-tao-hoa-don">
                                <a href="javascript:;" class="btn btn-main"
                                   onclick="themMoiDonHang('them')">
                                    <span class="icon nc-icon-outline ui-1_bold-add"></span>
                                    Ghi hóa đơn
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