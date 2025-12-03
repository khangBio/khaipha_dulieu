<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

<head>
    <jsp:include page="hodonbanhang-js.jsp"/>
</head>
<div class="box">
    <div class="box-body">
        <h1 class="main-title">THÔNG TIN KHÁCH HÀNG</h1>
        <form id="formThongTinKhachHang">
            <div class="row" hidden="hidden">
                <input type="number" id="idKhachHang"/>
            </div>
            <div class="row">
                <div class="col-sm-6 col-xs-12">
                    <div class="form-group form-label-top">
                        <div class="label-text">Số hóa đơn</div>
                        <input class="form-control" type="text" name="soHoaDonKhachHang" id="soHoaDonKhachHang"
                               value="" autocomplete="off">
                    </div>
                </div>
                <div class="col-sm-6 col-xs-12">
                    <div class="form-group form-label-top">
                        <div class="label-text">Ngày hóa đơn<span class="text-danger"> *</span></div>
                        <div class='input-group date'>
                            <input type='text' class="form-control text-mask-date"
                                   placeholder="Nhập ngày hóa đơn" id='ngayHoaDon'
                                   name="ngayHoaDon" autocomplete="off" />
                            <span class="input-group-addon" name="btnNgayHoaDon" id="btnNgayHoaDon">
                                <span class="glyphicon glyphicon-calendar"></span>
                            </span>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-sm-6 col-xs-12">
                    <div class="form-group form-label-top">
                        <div class="label-text">Họ tên khách hàng<span class="text-danger"> *</span></div>
                        <input class="form-control" type="text" placeholder="Nhập tên khách hàng" name="hoTenKhachHang" id="hoTenKhachHang"
                               value="${hoTenKhachHang}" autocomplete="off">
                    </div>
                </div>
                <div class="col-sm-6 col-xs-12">
                    <div class="form-group form-label-top">
                        <div class="label-text">Số điện thoại<span class="text-danger"> *</span></div>
                        <input class="form-control" type="text" placeholder="Nhập số điện thoại" name="sdtKhachHang" id="sdtKhachHang"
                               oninput="this.value=this.value.replace(/[^0-9]/g,'');"
                               value="${sdtKhachHang}" autocomplete="off">
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-sm-6 col-xs-12">
                    <div class="form-group form-label-top">
                        <div class="label-text">Số CCCD khách hàng<span class="text-danger"> *</span></div>
                        <input class="form-control" type="text" placeholder="Nhập số CCCD" name="cccdKhachHang" id="cccdKhachHang"
                               oninput="this.value=this.value.replace(/[^0-9]/g,'');"
                               value="${cccdKhachHang}" autocomplete="off">
                    </div>
                </div>
                <div class="col-sm-6 col-xs-12">
                    <div class="form-group form-label-top">
                        <div class="label-text">Ngày sinh khách hàng<span class="text-danger"> *</span></div>
                        <div class='input-group date'>
                            <input type='text' class="form-control text-mask-date"
                                   placeholder="Chọn ngày sinh" id='ngaySinhKhachHang'
                                   name="ngaySinhKhachHang" autocomplete="off" />
                            <span class="input-group-addon" name="srchToBirthday" id="srchToBirthday">
                                <span class="glyphicon glyphicon-calendar"></span>
                            </span>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-sm-6 col-xs-12">
                    <div class="form-group form-label-top">
                        <div class="label-text">Email</div>
                        <input class="form-control" type="text" placeholder="Nhập email" name="emailKhachHang" id="emailKhachHang"
                               value="${email}" autocomplete="off">
                    </div>
                </div>
                <div class="col-sm-6 col-xs-12">
                    <div class="form-group form-label-top">
                        <div class="label-text">Địa chỉ</div>
                        <input class="form-control" type="text" placeholder="Nhập địa chỉ khách hàng" name="diaChiKhachHang" id="diaChiKhachHang"
                               value="${diaChiKhachHang}" autocomplete="off">
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

<div class="box pad20">
    <div class="form-head">
        <div class="pull-left">
            <div class="form-title">KẾT QUẢ TÌM KIẾM</div>
        </div>
        <div class="clearfix"></div>
        <%--        <div class="note" id="noteSeach">--%>
        <%--            <span class="text-danger"> <c:if test="${(count > 0)}">Bạn có ${count} biến động chờ tạo cần tiếp nhận.</c:if></span>--%>
        <%--        </div>--%>
    </div>
    <div class="table-content">
        <table class="table tableBodyScroll">
            <thead style="min-width: calc(100vw - 345px);">
            <tr>
                <th class="stt text-center">
                    <input type="checkbox" name="selectAll-danhSachHoaDonKhachHang" class="select-all-rows"
                           childref="row-in-danhSachHoaDonKhachHang" />
                </th>
                <th class="stt text-center">STT</th>
                <th class="colf-ho-ten">Số hóa đơn</th>
                <th class="colf-date">Ngày hóa đơn</th>
                <th class="colf-ho-ten">Họ tên khách hàng</th>
                <th class="colf-date">Ngày sinh</th>
                <th class="colf-large text-center">Số<br>CMND/CCCD/ĐDCN</th>
                <th class="colf-large text-center">Số điện thoại</th>
                <th class="colf-xl-large">email</th>
                <th class="colf-xl-large">Địa chỉ</th>
                <th class="colf-status text-center">Trạng thái</th>
                <th class="colf-xxl-large text-center">Thao tác</th>
            </tr>
            </thead>
            <tbody name="danhSachHoaDonKhachHang" id="danhSachHoaDonKhachHang" style="max-height: calc(100vh - 360px);">
            </tbody>
        </table>
    </div>
</div>

<div id="form-danh-muc-san-pham" class="modal fade dialog-full" role="dialog">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <input type="number" id="id-don-hang" value="0" hidden="hidden"/>
            <div class="modal-header">
                <h5 class="modal-title">DANH MỤC SẢN PHẨM</h5>
            </div>
            <div class="modal-body" id="modal-danh-muc-san-pham">
            </div>
            <div class="modal-body">
                <div class="form-row" style="padding-top: 25px">
                    <div class="form-title"><span class="icon nc-icon-outline shopping_cart"></span> Giỏ hàng của bạn</div>
                    <div class="table-content">
                        <table class="table table-striped table-bordered">
                            <thead style="min-width: calc(100vw - 345px);">
                            <tr>
                                <th class="stt text-center">STT</th>
                                <th class="colf-xl-large">Tên sản phẩm</th>
                                <th class="colf-status-center">Đơn vị tính</th>
                                <th class="colf-status-center">Số lượng</th>
                                <th class="colf-status-center">Đơn giá</th>
                                <th class="colf-status-center">Thuế GTGT</th>
                                <th class="colf-status-center">Thành tiền</th>
                                <th class="colf-xl-large text-center">Thao tác</th>
                            </tr>
                            </thead>
                            <tbody name="chiTietDonHang" id="chiTietDonHang">
                            </tbody>
                        </table>
                        <%--                        <div class="vnpt-paging" filter-size="false" id="thongTinNhanKhau-paging"--%>
                        <%--                            change="dataNextPage($event)"></div>--%>
                    </div>
                </div>
            </div>
            <div class="modal-footer center">
                <button class="btn btn-second" name="btn-khongtaobiendong" id="btn-khongtaobiendong" onclick="thanhToan()">Thanh toán</button>
                <button class="btn btn-second" name="btn-close" id="btn-close">Đóng</button>
            </div>
        </div>
    </div>
</div>

<div id="form_traCuuHoCuTru" class="modal fade" role="dialog">
    <div class="modal-dialog modal-lg">
        <div class="modal-content" style="top: 22px">
            <div class="modal-header">
                <h5 class="modal-title">TRA CỨU HỘ THƯỜNG TRÚ TẠI ĐỊA BÀN</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <!-- <div class="form-title">
                    Thông tin hộ
                </div> -->
                <form id="formtracuuhocutru" onsubmit="traCuuHoCuTruTaiDiaBan('tracuu');return false">
                    <div id="traCuuHoCuTruTaiNoiThuongTru">
                        <div class="row">
                            <div class="col-sm-12 col-xs-12">
                                <div class="form-group form-label-top">
                                    <div class="label-text">Số hồ sơ cư trú</div>
                                    <input class="form-control" placeholder="Nhập số hồ sơ cư trú" name="sch_soHoSoCuTru"
                                           value="${sch_soHoSoCuTru}" autocomplete="off" type="text">
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-sm-6 col-xs-12">
                                <div class="form-group form-label-top isExactly">
                                    <div class="label-text">Họ và tên chủ hộ</div>
                                    <div class="input-group">
                                        <input class="form-control" placeholder="Nhập tên chủ hộ" name="sch_hoTenChuHo"
                                               value="${sch_hoTenChuHo}" autocomplete="off" type="text">
                                        <div class="input-group-addon">
                                            <input type="checkbox" name="sch_chinhXacTenChuHo" id="sch_chinhXacTenChuHo"
                                                   value="true" <c:if
                                                           test="${sch_chinhXacTenChuHo == true}">checked="checked"</c:if>
                                                   class="append-control"> <label for="sch_chinhXacTenChuHo">Tìm chính
                                            xác</label>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-sm-6 col-xs-12">
                                <div class="form-group form-label-top">
                                    <div class="label-text">Số CMND/CCCD/ĐDCN chủ hộ</div>
                                    <input class="form-control" placeholder="Nhập CMND/CCCD/ĐDCN" name="sch_cmndChuHo"
                                           oninput="this.value=this.value.replace(/[^0-9]/g,'');"
                                           value="${sch_cmndChuHo}" autocomplete="off" type="text">
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="actions center">
                                <input type="hidden" name="page" value="1">
                                <button type="button" class="btn btn-second" onclick="refeshTraCuuHoCuTruTaiDiaBan()">
                                    <span class="icon nc-icon-outline arrows-1_refresh-68"></span>
                                    Làm mới
                                </button>
                                <button type="button" class="btn btn-second btn-adv-dialog">
                                    <span class="icon nc-icon-outline ui-1_zoom"></span>
                                    Tìm kiếm nâng cao
                                </button>
                                <button type="submit" class="btn btn-main" name="traCuuHoCuTru" id="traCuuHoCuTru">
                                    <span class="icon nc-icon-outline ui-1_zoom"></span>
                                    Tìm kiếm
                                </button>
                            </div>
                        </div>
                    </div>
                </form>
                <div class="table-content mt-2">
                    <table class="table tableBodyScroll">
                        <thead>
                        <tr>
                            <th class="stt">
                                <!-- <input type="checkbox" name="selectAll-thongTinHoKhau" class="select-all-rows" /> -->
                            </th>
                            <th class="stt">STT</th>
                            <th class="colf-ho-ten">Số hồ sơ<br>cư trú</th>
                            <th class="colf-ho-ten">Họ và tên<br>chủ hộ</th>
                            <th class="colf-date">Ngày sinh</th>
                            <th class="colf-status">Giới tính</th>
                            <th class="colf-cmnd">Số<br>CMND/CCCD/ĐDCN</th>
                            <th class="colf-dia-chi">Địa chỉ thường trú</th>
                        </tr>
                        </thead>
                        <tbody name="thongTinHoKhau" id="thongTinHoKhau" style="max-height: calc(100vh - 195px);">
                        </tbody>
                    </table>
                </div>
                <div class="vnpt-paging" filter-size="false" id="thongTinHoKhau-paging"
                     change="nextPageTraCuuHoCuTru($event)"></div>
            </div>
            <div class="modal-footer">
                <button class="btn btn-second" name="quaylai" id="quaylai">Quay lại</button>
                <button class="btn btn-main" name="chonHoThemBienDong" id="chonHoThemBienDong">Chọn</button>
            </div>
        </div>
    </div>
</div>

<div id="adv-search-dialog" class="modal adv-search-dialog" role="dialog">
    <div class="modal-dialog modal-lg">
        <div class="modal-content" style="top: 22px">
            <form id="form_traCuuHoCuTruNangCao" onsubmit="traCuuHoCuTruTaiDiaBan('tracuunangcao');return false">
                <div class="modal-header">
                    <h5 class="modal-title">TRA CỨU HỘ THƯỜNG TRÚ TẠI ĐỊA BÀN</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <!-- <div class="form-title">
                        Thông tin hộ
                    </div> -->
                    <div id="traCuuHoCuTruTaiNoiThuongTruNangCao">
                        <div class="row">
                            <div class="col-sm-12 col-xs-12">
                                <div class="form-group form-label-top">
                                    <div class="label-text">Số hồ sơ cư trú</div>
                                    <input class="form-control" placeholder="Nhập số hồ sơ cư trú" name="sch_soHoSoCuTru"
                                           id="adv_soHoSoCuTru" value="${adv_soHoSoCuTru}" autocomplete="off" type="text">
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-sm-6 col-xs-12">
                                <div class="form-group form-label-top isExactly">
                                    <div class="label-text">Họ và tên chủ hộ</div>
                                    <div class="input-group">
                                        <input class="form-control" placeholder="Nhập tên chủ hộ" name="sch_hoTenChuHo"
                                               id="adv_hoTenChuHo" value="${adv_hoTenChuHo}" autocomplete="off" type="text">
                                        <div class="input-group-addon">
                                            <input type="checkbox" name="sch_chinhXacTenChuHo" id="adv_chinhXacTenChuHo"
                                                   value="true" <c:if
                                                           test="${adv_chinhXacTenChuHo == true}">checked="checked"
                                            </c:if>
                                                   class="append-control"> <label for="sch_chinhXacTenChuHo">Tìm chính xác</label>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-sm-6 col-xs-12">
                                <div class="form-group form-label-top">
                                    <div class="label-text">Số CMND/CCCD/ĐDCN chủ hộ</div>
                                    <input class="form-control" placeholder="Nhập CMND/CCCD/ĐDCN" name="sch_cmndChuHo"
                                           oninput="this.value=this.value.replace(/[^0-9]/g,'');"
                                           id="adv_cmndChuHo" value="${adv_cmndChuHo}" autocomplete="off" type="text">
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-sm-6 col-xs-12">
                                <div class="form-group form-label-top">
                                    <div class="label-text">Ngày sinh chủ hộ từ</div>
                                    <div class='input-group date'>
                                        <input type='text' class="form-control text-mask-date"
                                               placeholder="Chọn ngày sinh" id='sch_ngaySinhChuHoTuNgay'
                                               name="sch_ngaySinhChuHoTuNgay" autocomplete="off" />
                                        <span class="input-group-addon" name="srchFromBirthday" id="srchFromBirthday">
                                            <span class="glyphicon glyphicon-calendar"></span>
                                        </span>
                                    </div>
                                </div>
                            </div>
                            <div class="col-sm-6 col-xs-12">
                                <div class="form-group form-label-top">
                                    <div class="label-text">Ngày sinh chủ hộ đến</div>
                                    <div class='input-group date'>
                                        <input type='text' class="form-control text-mask-date"
                                               placeholder="Chọn ngày sinh" id='sch_ngaySinhChuHoDenNgay'
                                               name="sch_ngaySinhChuHoDenNgay" autocomplete="off" />
                                        <span class="input-group-addon" name="srchToBirthday" id="srchToBirthday">
                                            <span class="glyphicon glyphicon-calendar"></span>
                                        </span>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-sm-6 col-xs-12">
                                <div class="form-group form-label-top isExactly">
                                    <div class="label-text">Họ và tên thành viên</div>
                                    <div class="input-group">
                                        <input class="form-control" placeholder="Nhập họ tên thành viên" type="text"
                                               name="sch_hoTenThanhVien" value="${sch_hoTenThanhVien}" autocomplete="off">
                                        <div class="input-group-addon">
                                            <input type="checkbox" name="sch_ChinhXacTenThanhVien"
                                                   id="sch_ChinhXacTenThanhVien" value="true" <c:if
                                                           test="${sch_ChinhXacTenThanhVien == true}">checked="checked"</c:if>
                                                   class="append-control"> <label for="sch_ChinhXacTenThanhVien">Tìm chính xác</label>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-sm-6 col-xs-12">
                                <div class="form-group form-label-top">
                                    <div class="label-text">Số CMND/CCCD/ĐDCN của thành viên</div>
                                    <input class="form-control" placeholder="Nhập CMND/CCCD/ĐDCN"
                                           oninput="this.value=this.value.replace(/[^0-9]/g,'');"
                                           name="sch_cmndThanhVien" value="${sch_cmndThanhVien}" autocomplete="off" type="text">
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-sm-6 col-xs-12">
                                <div class="form-group form-label-top">
                                    <label class="label-text">Ngày sinh thành viên từ</label>
                                    <div class='input-group date'>
                                        <input type='text' class="form-control text-mask-date"
                                               placeholder="Chọn ngày sinh" id='sch_ngaySinhThanhVienTuNgay'
                                               name="sch_ngaySinhThanhVienTuNgay" autocomplete="off" />
                                        <span class="input-group-addon" name="srchCitiFromBirthday" id="srchCitiFromBirthday">
                                            <span class="glyphicon glyphicon-calendar"></span>
                                        </span>
                                    </div>
                                </div>
                            </div>
                            <div class="col-sm-6 col-xs-12">
                                <div class="form-group form-label-top">
                                    <label class="label-text">Ngày sinh thành viên đến</label>
                                    <div class='input-group date'>
                                        <input type='text' class="form-control text-mask-date"
                                               placeholder="Chọn ngày sinh" id='sch_ngaySinhThanhVienDenNgay'
                                               name="sch_ngaySinhThanhVienDenNgay" autocomplete="off" />
                                        <span class="input-group-addon" name="srchCitiToBirthday" id="srchCitiToBirthday">
                                            <span class="glyphicon glyphicon-calendar"></span>
                                        </span>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-sm-12 col-xs-12">
                                <div class="form-group form-label-top">
                                    <div class="label-text">Địa chỉ thường trú</div>
                                    <input class="form-control" placeholder="Nhập địa chỉ thường trú"
                                           name="sch_diaChiThuongTru" value="${sch_diaChiThuongTru}" autocomplete="off">
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <input type="hidden" name="page" value="1">
                    <button type="button" class="btn btn-second" onclick="refeshTraCuuHoCuTruTaiDiaBanNangCao()">
                        <span class="icon nc-icon-outline arrows-1_refresh-68"></span>
                        Làm mới</button>
                    <button type="submit" class="btn btn-main">
                        <span class="icon nc-icon-outline ui-1_zoom"></span>
                        Tìm kiếm
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>

<div id="form_ketThucBienDongHo" class="modal" role="dialog">
    <div class="modal-dialog modal-lg">
        <div class="modal-content" style="top: 22px">
            <div class="modal-header">
                <h5 class="modal-title">KẾT THÚC BIẾN ĐỘNG CỦA HỘ</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="form-row">
                    <div class="col-md-2">
                    </div>
                    <div class="col-md-8">
                        <div class="form-group form-label-top">
                            <div class="label-text">Cập nhật ngày về<span class="text-danger"> *</span></div>
                            <div class='input-group date' id='datetimepickerEnd'>
                                <input type='date' id='movingToDateEnd' name="movingToDateEnd"
                                       placeholder="Chọn ngày về" class="form-control" />
                                <span class="input-group-addon">
                                    <span class="glyphicon glyphicon-calendar"></span>
                                </span>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-sm-12">
                        <span class="text">Biến động nhân khẩu cập nhật về sớm theo biến động hộ.</span>
                    </div>
                </div>
                <div class="tab-content table-scroll">
                    <table class="table table-striped table-bordered" style="width: 800px">
                        <thead>
                        <tr>
                            <th class="fit text-center">
                                <%--                            <input type="checkbox" name="selectAll-nhanKhauTrongHoBienDong" class="select-all-rows"--%>
                                <%--                                   childref="row-in-nhanKhauTrongHoBienDong" />--%>
                            </th>
                            <th class="stt text-center">STT</th>
                            <th class="col-ho-ten">Họ và tên</th>
                            <th class="fit text-center">Đi từ ngày</th>
                            <th class="fit text-center">Đến ngày</th>
                            <th class="col-status text-center">Trạng thái</th>
                        </tr>
                        </thead>
                        <tbody name="nhanKhauTrongHoBienDong" id="nhanKhauTrongHoBienDong">
                        </tbody>
                    </table>
                </div>
            </div>
            <div class="row">
                <div class="col-sm-12">
                    <input type="checkbox" name="check-note" disabled>
                    <span class="text-warning">: Biến động đã trở về hoặc biến động có ngày kết thúc nhỏ hơn ngày đi hoặc biến động có ngày đi lớn hơn ngày hiện tại.</span>
                </div>
            </div>
            <div class="modal-footer">
                <button class="btn btn-second" name="btn-huyXacNhan" id="btn-huyXacNhan">Hủy</button>
                <button class="btn btn-main" name="btn-xacNhanKetThuc" id="btn-xacNhanKetThuc">Xác nhận</button>
            </div>
        </div>
    </div>
</div>

<div id="form_xoaBienDongHo" class="modal" role="dialog">
    <div class="modal-dialog modal-lg">
        <div class="modal-content" style="top: 22px">
            <div class="modal-header">
                <h5 class="modal-title">CHỌN BIẾN ĐỘNG NHÂN KHẨU TRONG HỘ CẦN XÓA THEO</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="tab-content table-scroll">
                    <table class="table table-striped table-bordered" style="width: 800px">
                        <thead>
                        <tr>
                            <th class="fit text-center">
                                <input type="checkbox" name="selectAll-nhanKhauTrongXoaHoBienDong" class="select-all-rows"
                                       childref="row-in-nhanKhauTrongXoaHoBienDong" />
                            </th>
                            <th class="stt text-center">STT</th>
                            <th class="col-ho-ten">Họ và tên</th>
                            <th class="fit text-center">Đi từ ngày</th>
                            <th class="fit text-center">Đến ngày</th>
                            <th class="col-status text-center">Trạng thái</th>
                        </tr>
                        </thead>
                        <tbody name="nhanKhauTrongXoaHoBienDong" id="nhanKhauTrongXoaHoBienDong">
                        </tbody>
                    </table>
                </div>
            </div>
            <%--<div class="row">
                <div class="col-sm-12">
                    <input type="checkbox" name="check-note" disabled>
                    <span class="text-warning">: Biến động đã trở về hoặc biến động có ngày ngày kết thúc nhỏ hơn ngày đi hoặc biến động có ngày đi lớn hơn ngày hiện tại.</span>
                </div>
            </div>--%>
            <div class="modal-footer">
                <button class="btn btn-second" name="btn-huyXacNhan" data-dismiss="modal">Hủy</button>
                <button class="btn btn-main" name="btn-xacNhanXoa" id="btn-xacNhanXoaBienDongHo">Xác nhận</button>
            </div>
        </div>
    </div>
</div>

<div id="adv-search-content" class="modal adv-search-content" role="dialog">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <!-- <h5 class="modal-title">TRA CỨU BIẾN ĐỘNG HỘ KHÔNG CƯ TRÚ TẠI ĐĂNG KÝ THƯỜNG TRÚ</h5> -->
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="form-title"><span>TÌM KIẾM THEO THÔNG TIN HỘ, NHÂN KHẨU</span></div>
                <form id="from_thongTinHoNhanKhau" class="panel-body checkout-inside"
                      onsubmit="traCuuDanhSachHoBienDong('traCuuBienDongNangCao');return false;">
                    <div class="row" id="timKiemTheoThongTinHoNhanKhau">
                        <div class="row">
                            <div class="col-sm-12 col-xs-12">
                                <div class="form-group form-label-top">
                                    <div class="label-text">Số hồ sơ cư trú</div>
                                    <input class="form-control" type="text" placeholder="Nhập số hồ sơ cư rú" name="soHoSoCuTru" id="soHoSoCuTru"
                                           value="${soHoSoCuTru}" autocomplete="off">
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-sm-6 col-xs-12">
                                <div class="form-group form-label-top isExactly">
                                    <div class="label-text">Họ và tên chủ hộ</div>
                                    <div class="input-group">
                                        <input class="form-control" type="text" placeholder="Nhập tên chủ hộ" name="hoTenChuHo"
                                               id="hoTenChuHo" value="${hoTenChuHo}" autocomplete="off">
                                        <div class="input-group-addon">
                                            <input type="checkbox" name="timChinhXacTenChuHo" id="timChinhXacTenChuHo"
                                                   value="true" <c:if
                                                           test="${timChinhXacTenChuHo == true}">checked="checked"
                                            </c:if>
                                                   class="append-control"> <label for="timChinhXacTenChuHo">Tìm chính
                                            xác</label>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-sm-6 col-xs-12">
                                <div class="form-group form-label-top">
                                    <div class="label-text">Số CMND/CCCD/ĐDCN chủ hộ</div>
                                    <input class="form-control" type="text" placeholder="Nhập CMND/CCCD/ĐDCN"
                                           oninput="this.value=this.value.replace(/[^0-9]/g,'');"
                                           name="cmndChuHo" id="advcmndChuHo" value="${cmndChuHo}" autocomplete="off">
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-sm-6 col-xs-12">
                                <div class="form-group form-label-top">
                                    <div class="label-text">Ngày sinh chủ hộ từ</div>
                                    <div class='input-group date'>
                                        <input type='text' placeholder="Chọn ngày sinh"
                                               class="form-control text-mask-date" id='ngaySinhChuHoTuNgay'
                                               name="ngaySinhChuHoTuNgay" autocomplete="off"/>
                                        <span class="input-group-addon" name="cldrFromBirthday" id="cldrFromBirthday">
                                            <span class="glyphicon glyphicon-calendar"></span>
                                        </span>
                                    </div>
                                </div>
                            </div>
                            <div class="col-sm-6 col-xs-12">
                                <div class="form-group form-label-top">
                                    <div class="label-text">Ngày sinh chủ hộ đến</div>
                                    <div class='input-group date'>
                                        <input type='text' placeholder="Chọn ngày sinh"
                                               class="form-control text-mask-date" id='ngaySinhChuHoDenNgay'
                                               name="ngaySinhChuHoDenNgay" autocomplete="off"/>
                                        <span class="input-group-addon" name="cldrToBirthday" id="cldrToBirthday">
                                            <span class="glyphicon glyphicon-calendar"></span>
                                        </span>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-sm-6 col-xs-12">
                                <div class="form-group form-label-top isExactly">
                                    <div class="label-text">Họ và tên thành viên</div>
                                    <div class="input-group">
                                        <input class="form-control" type="text" placeholder="Nhập họ tên thành viên"
                                               name="hoTenThanhVien" value="${hoTenThanhVien}" autocomplete="off">
                                        <div class="input-group-addon">
                                            <input type="checkbox" name="timChinhXacTenThanhVien"
                                                   id="timChinhXacTenThanhVien" value="true" <c:if
                                                           test="${timChinhXacTenThanhVien == true}">checked="checked"
                                            </c:if>
                                                   class="append-control"> <label for="timChinhXacTenThanhVien">Tìm
                                            chính xác</label>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-sm-6 col-xs-12">
                                <div class="form-group form-label-top">
                                    <div class="label-text">Số CMND/CCCD/ĐDCN của thành viên</div>
                                    <input class="form-control" type="text" placeholder="Nhập CMND/CCCD/ĐDCN"
                                           oninput="this.value=this.value.replace(/[^0-9]/g,'');"
                                           name="cmndThanhVien" id="cmndThanhVien" value="${cmndThanhVien}" autocomplete="off">
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-sm-6 col-xs-12">
                                <div class="form-group form-label-top">
                                    <label class="label-text">Ngày sinh thành viên từ</label>
                                    <div class='input-group date'>
                                        <input type='text' placeholder="Chọn ngày sinh"
                                               class="form-control text-mask-date" id='ngaySinhThanhVienTuNgay'
                                               name="ngaySinhThanhVienTuNgay" autocomplete="off" />
                                        <span class="input-group-addon" name="cldrCitiFromBirthday" id="cldrCitiFromBirthday">
                                            <span class="glyphicon glyphicon-calendar"></span>
                                        </span>
                                    </div>
                                </div>
                            </div>
                            <div class="col-sm-6 col-xs-12">
                                <div class="form-group form-label-top">
                                    <label class="label-text">Ngày sinh thành viên đến</label>
                                    <div class='input-group date'>
                                        <input type='text' placeholder="Chọn ngày sinh"
                                               class="form-control text-mask-date" id='ngaySinhThanhVienDenNgay'
                                               name="ngaySinhThanhVienDenNgay" autocomplete="off" />
                                        <span class="input-group-addon" name="cldrCitiToBirthday" id="cldrCitiToBirthday">
                                            <span class="glyphicon glyphicon-calendar"></span>
                                        </span>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-sm-12 col-xs-12">
                                <div class="form-group form-label-top">
                                    <div class="label-text">Địa chỉ thường trú</div>
                                    <input class="form-control" type="text" placeholder="Nhập địa chỉ thường trú"
                                           name="diaChiThuongTru" value="${diaChiThuongTru}" autocomplete="off">
                                </div>
                            </div>
                        </div>
                    </div>
                    <button type="submit" class="hidden">Enter Submit</button>
                </form>
                <div class="form-title">TÌM KIẾM THEO THÔNG TIN BIẾN ĐỘNG CƯ TRÚ</div>
                <form id="form_thongTinBienDong"
                      onsubmit="traCuuDanhSachHoBienDong('traCuuBienDongNangCao');return false;">
                    <div id="thongTinBienDong">
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group form-label-top">
                                    <div class="label-text">Loại di chuyển</div>
                                    <select class="form-control" placeholder="Chọn loại di chuyển" name="movingType"
                                            value="${movingType}">
                                        <option value="0" selected>Tất cả</option>
                                        <option value="1">Đi ngoài tỉnh</option>
                                        <option value="2">Đi ngoài huyện trong tỉnh</option>
                                        <option value="3">Đi ngoài xã trong huyện</option>
                                        <option value="4">Đi trong xã</option>
                                    </select>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="form-group" style="padding-top: 7px;">
                                    <div class="check-action">
                                        <input type="checkbox" name="khongRoNoiCuTru" id="khongRoNoiCuTru"
                                               value="${khongRoNoiCuTru}" /> <span class="name">Không rõ nơi cư trú</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="form-title">Trong nước</div>
                        <div class="row">
                            <div class="col-md-4">
                                <div class="form-group form-label-top">
                                    <div class="label-text">Tỉnh / thành phố</div>
                                    <select class="form-control" placeholder="Chọn tỉnh / thành phố" allowClear="true"
                                            data-url="${pageContext.request.contextPath}/public/category/citycombobox"
                                            data-param='{"showAll":true}' name="regPlaceCityId" id="regPlaceCityId">
                                    </select>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="form-group form-label-top">
                                    <div class="label-text">Quận / huyện</div>
                                    <select class="form-control" placeholder="Chọn quận / huyện" allowClear="true"
                                            data-url="${pageContext.request.contextPath}/public/category/districtcombobox"
                                            data-param='{"showAll":true}' name="regPlaceDistrictId" id="regPlaceDistrictId">
                                    </select>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="form-group form-label-top">
                                    <div class="label-text">Phường / xã</div>
                                    <select class="form-control" placeholder="Chọn phường / xã" allowClear="true"
                                            data-url="${pageContext.request.contextPath}/public/category/villagecombobox"
                                            data-param='{"showAll":true}' name="regPlaceVillageId" id="regPlaceVillageId">
                                    </select>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="form-group form-label-top">
                                    <div class="label-text">Địa chỉ cụ thể</div>
                                    <input type="text" class="form-control" placeholder="Nhập địa chỉ"
                                           name="trongNuocDiaChi" value="${trongNuocDiaChi}" autocomplete="off">
                                </div>
                            </div>
                        </div>
                        <div class="form-title">Ngoài nước</div>

                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group form-label-top">
                                    <div class="label-text">Quốc gia</div>
                                    <select class="form-control" placeholder="Chọn quốc gia"
                                            data-url="${pageContext.request.contextPath}/public/category/asdiccountrycombobox?notCounTryResId=VN"
                                            name="regPlaceCountryId" value="${regPlaceCountryId}">
                                        <option value="0">Tất cả quốc gia</option>
                                    </select>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="form-group form-label-top">
                                    <div class="label-text">Địa chỉ cụ thể</div>
                                    <input type="text" class="form-control" placeholder="Nhập địa chỉ"
                                           name="ngoaiNuocDiaChi" value="${ngoaiNuocDiaChi}" autocomplete="off">
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-4">
                                <div class="form-group form-label-top">
                                    <div class="label-text">Đi từ ngày</div>
                                    <div class='input-group date'>
                                        <input type='date' placeholder="Chọn ngày đi" class="form-control"
                                               name="movingFromDate" value="${movingFromDate}" autocomplete="off" />
                                        <span class="input-group-addon">
                                            <span class="glyphicon glyphicon-calendar"></span>
                                        </span>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="form-group form-label-top">
                                    <div class="label-text">Đến ngày</div>
                                    <div class='input-group date'>
                                        <input type='date' placeholder="Chọn đến ngày" class="form-control"
                                               name="movingToDate" value="${movingToDate}" />
                                        <span class="input-group-addon">
                                            <span class="glyphicon glyphicon-calendar"></span>
                                        </span>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-4 col-xs-12">
                                <div class="form-group form-label-top">
                                    <div class="label-text">Trạng thái</div>
                                    <select class="form-control" name="movingStatus" value="${movingStatus}">
                                        <option value="0" selected>Tất cả</option>
                                        <option value="1">Đã trở về</option>
                                        <option value="2">Chưa trở về</option>
                                    </select>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-sm-6 col-xs-12">
                                <div class="form-group form-label-top">
                                    <div class="label-text">Nguồn biến động:</div>
                                    <select class="form-control" name="sourceData" id="adv_sourceData" value="${sourceData}">
                                        <option value="-1" selected>Tất cả</option>
                                        <option value="0">Trực tiếp</option>
                                        <option value="1">Tạm trú</option>
                                        <option value="4">Khai báo thông tin về nơi ở hiện tại</option>
                                    </select>
                                </div>
                            </div>
                            <div class="col-sm-6 col-xs-12">
                                <div class="form-group form-label-top">
                                    <div class="label-text">Trạng thái tiếp nhận:</div>
                                    <select class="form-control" name="statusReceive" id="avd_statusReceive"
                                            value="${statusReceive}">
                                        <option value="1">Biến động chờ tạo</option>
                                        <option value="2">Biến động không tạo</option>
                                        <option value="3" selected>Biến động đã tạo</option>
                                    </select>
                                </div>
                            </div>
                        </div>
                    </div>
                    <button type="submit" class="hidden">Enter Submit</button>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-second" onclick="refeshAddvanceSearch()"><span
                        class="icon nc-icon-outline arrows-1_refresh-68"></span> Làm
                    mới
                </button>
                <button type="button" class="btn btn-main"
                        onclick="traCuuDanhSachHoBienDong('traCuuBienDongNangCao')"><span
                        class="icon nc-icon-outline ui-1_zoom"></span> Tìm kiếm
                </button>
            </div>
        </div>
    </div>
</div>
