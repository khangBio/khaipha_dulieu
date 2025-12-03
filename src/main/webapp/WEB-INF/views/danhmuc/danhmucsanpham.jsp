<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<div class="box">
    <div class="box-body">
        <h1 class="main-title">DANH MỤC SẢN PHẨM</h1>
        <form id="form_quick_search">
            <div class="row">

                <div class="col-sm-6 col-xs-12">
                    <div class="input-right-button">
                        <div class="form-group form-label-top">
                            <div class="label-text">Họ tên khách hàng </div>
                            <input class="form-control" type="text" placeholder="Nhập tên khách hàng" name="hoTenKhachHang" id="hoTenKhachHang"
                                   value="${hoTenKhachHang}" autocomplete="off">
                        </div>
                        <div class="actions">
                            <button type="button" class="btn btn-main" name="dialogTraCuuKhachHang"
                                    id="dialogTraCuuKhachHang" onclick="traCuuHoCuTruTaiDiaBan('open')">
                                <span class="nc-icon-outline ui-2_menu-dots"></span>
                            </button>
                        </div>
                    </div>
                </div>
                <div class="col-sm-6 col-xs-12">
                    <div class="form-group form-label-top">
                        <div class="label-text">Số điện thoại</div>
                        <input class="form-control" type="text" placeholder="Nhập số điện thoại" name="sdtKhachHang" id="sdtKhachHang"
                               oninput="this.value=this.value.replace(/[^0-9]/g,'');"
                               value="${sdtKhachHang}" autocomplete="off">
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-sm-6 col-xs-12">
                    <div class="form-group form-label-top">
                        <div class="label-text">Số CCCD khách hàng</div>
                        <input class="form-control" type="text" placeholder="Nhập số CCCD" name="cccdKhachHang" id="cccdKhachHang"
                               oninput="this.value=this.value.replace(/[^0-9]/g,'');"
                               value="${cccdKhachHang}" autocomplete="off">
                    </div>
                </div>
                <div class="col-sm-6 col-xs-12">
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
                        <select class="form-control" name="sourceData" id="sourceData" value="${sourceData}">
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
                        <select class="form-control" name="statusReceive" id="statusReceive"
                                value="${statusReceive}"/>
                        <option value="1">Biến động chờ tạo</option>
                        <option value="2">Biến động không tạo</option>
                        <option value="3" selected>Biến động đã tạo</option>
                        </select>
                    </div>
                </div>
            </div>
            <input type="hidden" name="page" value="1">
            <div class="box box-scroll">
                <div class="box-body">
                    <div class="center">
                        <ul class="menu-list-item">
                            <li class="item-menu not-show-on-editing">
                                <a href="javascript:;" class="btn btn-second" onclick="refeshQuickSearch()">
                                    <span class="icon nc-icon-outline arrows-1_refresh-68"></span>
                                    Làm mới
                                </a>
                            </li>
                            <li class="item-menu not-show-on-editing">
                                <a href="javascript:;" class="btn btn-second btn-adv">
                                    <span class="icon nc-icon-outline ui-1_zoom"></span>
                                    Tìm kiếm nâng cao
                                </a>
                            </li>
                            <li class="item-menu not-show-on-editing" id="btn_search_data">
                                <a href="javascript:;" class="btn btn-main"
                                   onclick="traCuuDanhSachHoBienDong('traCuuBienDong')">
                                    <span class="icon nc-icon-outline ui-1_zoom"></span>
                                    Tìm kiếm
                                </a>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
            <button type="submit" class="hidden">Enter submit</button>
        </form>
    </div>
</div>

<div class="box pad20">
    <div class="form-head">
        <div class="pull-left">
            <div class="form-title">KẾT QUẢ TÌM KIẾM</div>
        </div>
        <div class="pull-right group-buttons">
            <button type="button" class="btn btn-second" onclick="formDialogCrud('them', null)" name="themBienDongHo"
                    id="themBienDongHo">Thêm mới</button>
            <button type="button" class="btn btn-second" onclick="functionActions('tiepnhan')" name="tiepNhanBienDongHo"
                    id="tiepNhanBienDongHo">Tiếp nhận</button>
            <button type="button" class="btn btn-second" onclick="functionActions('xem')" name="xemBienDongHo"
                    id="xemBienDongHo">Xem</button>
            <button type="button" class="btn btn-second" onclick="functionActions('sua')" name="suaBienDongHo"
                    id="suaBienDongHo">Sửa</button>
            <button type="button" class="btn btn-second" onclick="functionActions('xoa')" name="xoaBienDongHo"
                    id="xoaBienDongHo">Xoá</button>
            <button type="button" class="btn btn-second" onclick="functionActions('capnhatngayve')"
                    name="btn-capnhatngayve" id="btn-capnhatngayve">Cập nhật về sớm</button>
            <dct:btn-export functionName="ketXuatBienDong"/>

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
                    <input type="checkbox" name="selectAll-danhSachHoBienDong" class="select-all-rows"
                           childref="row-in-danhSachHoBienDong" />
                </th>
                <th class="stt text-center">STT</th>
                <th class="colf-ho-ten">Số hồ sơ<br>cư trú</th>
                <th class="colf-ho-ten">Họ và tên chủ hộ</th>
                <th class="colf-date">Ngày sinh</th>
                <th class="colf-cmnd text-center">Số<br>CMND/CCCD/ĐDCN</th>
                <th class="colf-dia-chi">Địa chỉ thường trú</th>
                <th class="colf-dia-chi">Nơi đến</th>
                <th class="colf-date">Đi từ ngày</th>
                <th class="colf-date">Đến ngày</th>
                <th class="colf-source">Nguồn biến động</th>
                <th class="colf-source">Trạng thái tiếp nhận</th>
                <th class="colf-status text-center">Trạng thái</th>
                <th class="colf-action text-center">Thao tác</th>
            </tr>
            </thead>
            <tbody name="danhSachHoBienDong" id="danhSachHoBienDong" style="max-height: calc(100vh - 360px);">
            <c:if test="${lstPojoAsDicHousHoldNotInGeographic_count > 0}">
                <c:forEach var="idx" items="${lstPojoAsDicHousHoldNotInGeographic}" varStatus="vs">
                    <tr class="tr-list">
                        <td class="stt" ref="row-in-danhSachHoBienDong">
                            <input type="checkbox" class="select-row checkAllMain" ref="row-in-danhSachHoBienDong"
                                   houseHoldResId="${idx.houseHoldResId}"
                                   houseHoldId="${idx.houseHoldId}"
                                   receiveStatus="${idx.receiveStatus}"
                                   sourceData="${idx.sourceData}"
                                   movingStatus="${idx.movingStatus}"
                                   hhRegBookProfNumber="${idx.hhRegBookProfNumber}"
                                   houseHoldName="${idx.houseHoldName}" movingFromDate="${idx.movingFromDate}"
                                   movingToDate="${idx.movingToDate}" compareToDate="${idx.compareToDate}" />
                        </td>
                        <td class="stt">${vs.count + (page - 1) * size}</td>
                        <td class="colf-ho-ten">${idx.hhRegBookProfNumber}</td>
                        <td class="colf-ho-ten">
                            <a class="link second" href="javascript:;"
                               onclick="formDialogCrud('xem','${idx.houseHoldId}', false, '', '${idx.receiveStatus}');">
                                    ${idx.houseHoldName}
                            </a>
                        </td>
                        <td class="colf-date">${idx.houseHoldBirthday}</td>
                        <td class="colf-cmnd">${idx.identifyNumber}</td>
                        <td class="colf-dia-chi">${idx.permanentAddress}</td>
                        <td class="colf-dia-chi">${idx.movingAddress}</td>
                        <td class="colf-date">${idx.movingFromDate}</td>
                        <td class="colf-date">${idx.movingToDate}</td>
                        <td class="colf-source">${idx.sourceDataName}</td>
                        <td class="colf-source">${idx.statusReceiveName}</td>
                        <td class="colf-status">
                            <c:choose>
                                <c:when test="${idx.movingStatus == 1}">
                                    <span class="text-success">${idx.statusFullDesc}</span>
                                </c:when>
                                <c:when test="${idx.movingStatus == 2 && idx.compareToDate < 0 }">
                                    <span class="text-success">${idx.statusFullDesc}</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="text-danger">${idx.statusFullDesc}</span>
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td class="colf-action">
                            <a href="javascript:;" data-tooltip="true" title="Xem" class="not-click"
                               onclick="quickActions('xem','${idx.houseHoldId}','${idx.hhRegBookProfNumber}',null, '${idx.receiveStatus}');">
                                <span class="nc-icon-outline ui-1_eye-17 not-click"></span>
                            </a>
                            <a href="javascript:;" ng-if="${idx.receiveStatus == 3}" data-tooltip="true" title="Cập nhật về sớm" class="not-click"
                               onclick="quickActions('capnhatngayve','${idx.houseHoldId}','${idx.movingStatus}','${idx.movingToDate}', '${idx.receiveStatus}');">
                                <span class="nc-icon-outline users-2_a-time not-click"></span>
                            </a>
                            <a href="javascript:;" ng-if="${idx.receiveStatus == 3}" data-tooltip="true" title="Sửa" class="not-click"
                               onclick="quickActions('sua','${idx.houseHoldId}','${idx.hhRegBookProfNumber}', null, '${idx.receiveStatus}');">
                                <span class="nc-icon-outline ui-1_edit-76 not-click"></span>
                            </a>
                            <a href="javascript:;" ng-if="${idx.receiveStatus == 3}" data-tooltip="true" title="Xóa" class="not-click"
                               onclick="quickActions('xoa','${idx.houseHoldId}', '${idx.houseHoldName}');">
                                <span class="nc-icon-outline ui-1_trash-simple not-click"></span>
                            </a>
                            <a href="javascript:;" ng-if="${idx.receiveStatus != 3}" data-tooltip="true" title="Tiếp nhận" class="not-click"
                               onclick="quickActions('tiepnhan','${idx.houseHoldId}', '${idx.hhRegBookProfNumber}', null, '${idx.receiveStatus}');">
                                <span class="nc-icon-outline ui-1_circle-add not-click"></span>
                            </a>
                        </td>
                    </tr>
                </c:forEach>
            </c:if>
            <c:if test="${lstPojoAsDicHousHoldNotInGeographic_count == 0}">
                <tr citizenCode = "" class="row-select">
                    <td class="fit text-center" colspan="15">Không có dữ liệu</td>
                </tr>
            </c:if>
            </tbody>
        </table>
    </div>
    <div class="vnpt-paging" id="lstPojoAsDicHousHoldNotInGeographic-paging"
         data-count="${lstPojoAsDicHousHoldNotInGeographic_count}" data-page="${page}" data-size="${size}"
         change="nextPageDanhSachHoBienDong($event)"></div>
</div>

<div id="form_asHouseHold" class="modal fade dialog-full" role="dialog">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">THÊM MỚI BIẾN ĐỘNG HỘ KHÔNG CƯ TRÚ TẠI NƠI ĐĂNG KÝ THƯỜNG TRÚ</h5>
                <!-- <button type="button" class="close" data-dismiss="modal" aria-label="Close"></button> -->
            </div>
            <div class="modal-body">
                <div class="form-row">
                    <div class="pull-left" id="dongCapNhatVeSom" hidden>
                        <!-- <a href="javascript:;" onclick="functionActions('dong')"><i
                                class="fa fa-arrow-left fa-3x"></i></a> -->
                    </div>
                    <div class="pull-right">
                        <button class="btn btn-line" name="btn-ketThucBienDong" id="btn-ketThucBienDong">Cập nhật về sớm
                        </button>
                    </div>
                </div>

                <div class="form-title">Thông tin hộ:</div>
                <div class="row">
                    <div class="col-md-6">
                        <div class="input-right-button">
                            <div class="form-group form-label-top">
                                <div class="label-text">Số hồ sơ cư trú<span class="text-danger"> *</span></div>
                                <input type="text" class="form-control" placeholder="Nhập số hồ sơ cư trú"
                                       name="hhRegBookProfNumber" id="hhRegBookProfNumber" autocomplete="off">
                                </input>
                            </div>
                            <div class="actions">
                                <button type="button" class="btn btn-main" name="dialogSeachHouseHold"
                                        id="dialogSeachHouseHold" onclick="traCuuHoCuTruTaiDiaBan('open')">
                                    <span class="nc-icon-outline ui-2_menu-dots"></span>
                                </button>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group form-label-top">
                            <div class="label-text">Họ và tên chủ hộ<span class="text-danger"> *</span></div>
                            <input name="hoTenChuHo" id="hoTenChuHo" type="text" class="form-control"
                                   placeholder="Nhập tên chủ hộ" />
                        </div>
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-6">
                        <div class="form-group form-label-top">
                            <div class="label-text">Ngày sinh chủ hộ<span class="text-danger"> *</span></div>
                            <div class='input-group date' id='datetimepickerNgaySinhChuHo'>
                                <input type='text' id='ngaySinhChuHo' name="ngaySinhChuHo" placeholder="Chọn ngày sinh"
                                       class="form-control text-mask-date" />
                                <span class="input-group-addon">
                                    <span class="glyphicon glyphicon-calendar"></span>
                                </span>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group form-label-top">
                            <div class="label-text">Số CMND/CCCD/ĐDCN chủ hộ</div>
                            <input name="soCMNDChuHo" id="soCMNDChuHo" type="text" class="form-control"
                                   oninput="this.value=this.value.replace(/[^0-9]/g,'');"
                                   placeholder="Nhập số CMND/CCCD/ĐDCN chủ hộ" />
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-12">
                        <div class="form-group form-label-top">
                            <div class="label-text">Địa chỉ thường trú<span class="text-danger"> *</span></div>
                            <input name="diaChiThuongTru" id="diaChiThuongTru" type="text" class="form-control"
                                   placeholder="Nhập địa chỉ thường trú" />
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-12" name="tamvang" id="tamvang">
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-12" name="tamtru" id="tamtru">
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-title">Thông tin nhân khẩu:</div>
                    <div class="table-content">
                        <table class="table table-striped table-bordered">
                            <thead>
                            <tr>
                                <th class="stt">STT</th>
                                <th class="fit col-ho-ten">Họ và tên</th>
                                <th>Ngày sinh</th>
                                <th class="fit text-center">Giới tính</th>
                                <th class="fit">Số CMND/CCCD/ĐDCN</th>
                                <th class="fit">Chủ hộ/Quan hệ với chủ hộ</th>
                                <th class="fit text-center">Ngày chết(Nếu có)</th>
                            </tr>
                            </thead>
                            <tbody name="thongTinNhanKhau" id="thongTinNhanKhau">
                            </tbody>
                        </table>
                        <%--                        <div class="vnpt-paging" filter-size="false" id="thongTinNhanKhau-paging"--%>
                        <%--                            change="dataNextPage($event)"></div>--%>
                    </div>
                </div>

                <div class="form-title">Nơi đến:</div>
                <div class="row">
                    <div class="col-sm-12 list-control">
                        <div class="form-group">
                            <div class="check-action">
                                <input type="radio" name="destionalType" id="destionalType1" value="1" /> <span
                                    class="name">Trong nước</span>
                            </div>
                            <div class="check-action">
                                <input type="radio" name="destionalType" id="destionalType2" value="2" /> <span
                                    class="name">Nước ngoài</span>
                            </div>
                            <div class="check-action">
                                <input type="radio" name="destionalType" id="destionalType3" value="3" /> <span
                                    class="name">Không rõ nơi cư trú</span>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-4" id="divMovingType" style="display: none">
                        <div class="form-group form-label-top">
                            <div class="label-text">Loại di chuyển<span class="text-danger"> *</span></div>
                            <select class="form-control" placeholder="Chọn loại di chuyển" id="placeToMovingType"
                                    name="placeToMovingType">
                                <option value="1">Đi ngoài tỉnh</option>
                                <option value="2">Đi ngoài huyện trong tỉnh</option>
                                <option value="3">Đi ngoài xã trong huyện</option>
                                <option value="4">Đi trong xã</option>
                            </select>
                        </div>

                    </div>
                    <div class="col-md-4" id="divMovingCountryId" style="display: none">
                        <div class="form-group form-label-top">
                            <div class="label-text">Quốc gia<span class="text-danger"> *</span></div>
                            <select class="form-control" type="select" placeholder="Chọn quốc gia"
                                    data-url="${pageContext.request.contextPath}/public/category/asdiccountrycombobox?notCounTryResId=VN"
                                    name="movingCountryId" id="movingCountryId" value="${movingCountryId}">
                            </select>
                        </div>
                    </div>
                </div>
                <div class="row" id="divMovingInCountry" style="display: none">
                    <div class="col-md-4">
                        <div class="form-group form-label-top">
                            <div class="label-text">Tình / thành<span class="text-danger"> *</span></div>
                            <select class="form-control" placeholder="Chọn tỉnh thành / phố" type="select"
                                    data-url="${pageContext.request.contextPath}/public/category/citycombobox"
                                    data-param='{"showAll":true}' id="movingCityId" name="movingCityId"  allowClear="true"
                                    sort="true"
                            >
                            </select>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="form-group form-label-top">
                            <div class="label-text">Quận / huyện</div>
                            <select class="form-control" placeholder="Chọn quận / huyện" type="select"
                                    data-url="${pageContext.request.contextPath}/public/category/districtcombobox"
                                    data-param='{"showAll":true}' id="movingDistrictId" name="movingDistrictId"
                                    disabled="disabled" allowClear="true" sort="true">
                            </select>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="form-group form-label-top">
                            <div class="label-text">Phường / xã</div>
                            <select class="form-control" placeholder="Chọn phường / xã" type="select"
                                    data-url="${pageContext.request.contextPath}/public/category/villagecombobox"
                                    data-param='{"showAll":true}' id="movingVillageId" name="movingVillageId"
                                    disabled="disabled" allowClear="true" sort="true">
                            </select>
                        </div>

                    </div>
                </div>
                <div class="row" name="divMovingAddress" id="divMovingAddress">
                    <div class="col-md-12">
                        <div class="form-group form-label-top">
                            <div class="label-text">Địa chỉ cụ thể</div>
                            <input type="text" class="form-control" placeholder="Nhập địa chỉ" id="movingAddress"
                                   name="movingAddress">
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-12">
                        <div class="form-group form-label-top">
                            <div class="label-text">Lý do</div>
                            <textarea class="form-control" placeholder="Nhập lý do" id="reason"
                                      name="reason"></textarea>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-4">
                        <div class="form-group form-label-top">
                            <div class="label-text">Từ ngày<span class="text-danger"> *</span>:</div>
                            <div class='input-group date' id='datetimepickerFromDate'>
                                <input type='date' id='movingFromDate' name="movingFromDate" placeholder="Chọn ngày đi"
                                       class="form-control" />
                                <span class="input-group-addon">
                                    <span class="glyphicon glyphicon-calendar"></span>
                                </span>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="form-group form-label-top">
                            <div class="label-text">Đến ngày:</div>
                            <div class='input-group date' id="datetimepickerToDate">
                                <input type='date' id='movingToDate' name="movingToDate" placeholder="Chọn đến ngày"
                                       class="form-control" />
                                <span class="input-group-addon">
                                    <span class="glyphicon glyphicon-calendar"></span>
                                </span>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="form-group form-label-top">
                            <div class="label-text">Trạng thái<span class="text-danger"> *</span></div>
                            <select class="form-control" placeholder="Chọn trạng thái di chuyển" id="movingStatus" name="movingStatus">
                                <option value="1" selected>Đã trở về</option>
                                <option value="2">Chưa trở về</option>
                            </select>
                        </div>
                    </div>
                </div>
                <div class="row" name="reasonNotCreate" id="reasonNotCreate" hidden="hidden">
                    <div class="col-md-12">
                        <div class="form-group form-label-top">
                            <div class="label-text">Lý do không tạo biến động<span class="text-danger"> *</span></div>
                            <textarea class="form-control" placeholder="Nhập lý do khi không tạo biến động" id="resonNotCreateHouseHold"
                                      name="resonNotCreateHouseHold"></textarea>
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal-footer center">
                <button class="btn btn-second" name="btn-close">Quay lại</button>
                <button class="btn btn-second" name="btn-ghivathem" id="btn-ghivathem">Ghi và thêm mới</button>
                <button class="btn btn-primary" name="btn-ghi" id="btn-ghi">Ghi</button>
                <button class="btn btn-second" name="btn-khongtaobiendong" id="btn-khongtaobiendong">Không tạo biến động</button>
                <button class="btn btn-primary" name="btn-taobiendong" id="btn-taobiendong">Tạo biến động</button>
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
