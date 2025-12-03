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
    var formThongTinKhachHang = $("#formThongTinKhachHang");
    const MIN = 0;
    const MAX = 10;
    const TITLE_MODAL_DANH_MUC_SAN_PHAM = '<div class="form-title">Danh mục sản phẩm</div>';
    $(function () {
        $("#btn-tao-hoa-don").hide();
        $("#formThongTinKhachHang").disableControlValue({
            soHoaDonKhachHang: true,
        });
        $("#ngayHoaDon").datepicker({autoclose: true, todayHighlight: true}).on('changeDate', function (e) {
                $(document).pathValue({
                    ngayHoaDon: e.format(0, "dd/mm/yyyy")
                });
            }
        );
        $("#btnNgayHoaDon").datepicker({autoclose: true, todayHighlight: true}).on('changeDate', function (e) {
                $(document).pathValue({
                    ngayHoaDon: e.format(0, "dd/mm/yyyy")
                });
            }
        );
        $("#srchToBirthday").datepicker({autoclose: true, todayHighlight: true}).on('changeDate', function (e) {
                $(document).pathValue({
                    ngaySinhKhachHang: e.format(0, "dd/mm/yyyy")
                });
            }
        );

        $("#ngaySinhKhachHang").datepicker({autoclose: true, todayHighlight: true}).on('changeDate', function (e) {
                $(document).pathValue({
                    ngaySinhKhachHang: e.format(0, "dd/mm/yyyy")
                });
            }
        );

        $("#btn-close").click(function (){
            $("#form-danh-muc-san-pham").hideDialog();
        })

        $("#sdtKhachHang").keydown(function (e) {
            if (e.keyCode == 13){
                $("#formThongTinKhachHang").resetValidation();
                var checkValid = $("#formThongTinKhachHang").validation({
                    required: {
                        sdtKhachHang: "Số điện thoại khách hàng không được trống!",
                    }
                });
                if (!checkValid.isValid) {
                    $("#formThongTinKhachHang").bindError(checkValid);
                    return;
                }else {
                    findOneKhachHang();
                    return;
                }
            }
        })
    });

    function eventChooseProd(evt){
        const parentCard = $(evt).closest('.col-md-3');
        const prodId = parentCard.attr('prod-id');
        const prodDonGia = parentCard.attr('prod-don-gia');
        const quantityInput  = parentCard.find('input[name=quantity]');
        let soLuong = quantityInput ? quantityInput.val() : 0
        let idDonHang = $("#id-don-hang").val() ? $("#id-don-hang").val() : 0;
        if (idDonHang <= 0) {
            lib.showMessage('error', 'error', function () {
                //
            });
            return;
        }
        lib.post({
            url: $("#PageContext").val() + "/do-chi-tiet-don-hang",
            data: JSON.stringify({
                idDonHang: idDonHang,
                idChiTiet: 0,
                soLuong: soLuong,
                donGia: prodDonGia,
                idSanPham: prodId,
                trangThai: 0,
            }),
            beforePost:function(){
                $("#form-danh-muc-san-pham").uiLoading(true);
            },
            complete: function (response) {
                $("#form-danh-muc-san-pham").uiLoading(false);
                var res = response.responseJSON;
                if (res.errorCode < 0){
                    lib.showMessage('' + res.errorMessage, 'error', function () {
                        //
                    });
                }else {
                    lib.showMessage('' + res.errorMessage, 'success', function () {
                        let idDonHang = $("#id-don-hang").val();
                        getChiTietDonHang(idDonHang);
                    });
                }
            },
            error: function (ex) {
                $("#form-danh-muc-san-pham").uiLoading(false);
            }
        });
    }

    function themMoiKhachHang(action){
        $("#formThongTinKhachHang").resetValidation();
        var checkValid = $("#formThongTinKhachHang").validation({
            required: {
                hoTenKhachHang: "Họ tên khách hàng không được trống!",
                sdtKhachHang: "Số điện thoại khách hàng không được trống!",
                cccdKhachHang: "Định danh khách hàng không được trống!",
                ngaySinhKhachHang: "Ngày sinh khách hàng không được trống!"
            }
        });
        if (!checkValid.isValid) {
            $("#formThongTinKhachHang").bindError(checkValid);
            return;
        }
        $("#formThongTinKhachHang").formTextTrim();
        var jsonData = $("#formThongTinKhachHang").getValue();
        lib.post({
            url: $("#PageContext").val() + "/do-khach-hang",
            data: JSON.stringify({
                idKhachHang: $("#idKhachHang").val() ? $("#idKhachHang").val() : 0,
                maKhachHang: '',
                hoTen: jsonData.hoTenKhachHang,
                cccd: jsonData.cccdKhachHang,
                ngaySinh: jsonData.ngaySinhKhachHang,
                email: jsonData.emailKhachHang,
                soDienThoai: jsonData.sdtKhachHang,
                diaChi: jsonData.diaChiKhachHang
            }),
            beforePost:function(){
                $("#formThongTinKhachHang").uiLoading(true);
            },
            complete: function (response) {
                $("#formThongTinKhachHang").uiLoading(false);
                var res = response.responseJSON;
                if (res.errorCode < 0){
                    lib.showMessage('' + res.errorMessage, 'error', function () {
                            //
                        });
                }else {
                    lib.showMessage('' + res.errorMessage, 'success', function () {
                        $("#idKhachHang").val(res.errorCode);
                        $("#btn-tao-hoa-don").show();
                    });
                }
            },
            error: function (ex) {
                $("#formThongTinKhachHang").uiLoading(false);
            }
        });
    }

    function findOneKhachHang(){
        $("#formThongTinKhachHang").formTextTrim();
        var jsonData = $("#formThongTinKhachHang").getValue();
        lib.post({
            url: $("#PageContext").val() + "/find-info-khach-hang",
            data: JSON.stringify({
                idKhachHang: 0,
                hoTen: jsonData.hoTenKhachHang,
                cccd: jsonData.cccdKhachHang,
                ngaySinh: jsonData.ngaySinhKhachHang,
                soDienThoai: jsonData.sdtKhachHang,
            }),
            beforePost:function(){
                $("#formThongTinKhachHang").uiLoading(true);
            },
            complete: function (response) {
                $("#formThongTinKhachHang").uiLoading(false);
                var item = response.responseJSON.khachHang;
                let errorCode = response.responseJSON.errorCode
                if (errorCode > 0){
                    $("#idKhachHang").val(item.idKhachHang);
                    $("#formThongTinKhachHang").pathValue({
                        hoTenKhachHang: item.hoTen,
                        sdtKhachHang: item.soDienThoai,
                        cccdKhachHang: item.cccd,
                        ngaySinhKhachHang: item.ngaySinh,
                        emailKhachHang: item.email,
                        diaChiKhachHang: item.diaChi,
                    });
                    $("#btn-tao-hoa-don").show();
                    getListHoaDonOfKhachHang(item.idKhachHang, '-1');
                }else {
                    lib.showMessage('Không tìm thấy thông tin khách hàng!',
                        'error', function () {
                            $("#idKhachHang").val(0);
                            $("#btn-tao-hoa-don").hide();
                        });
                }
            },
            error: function (ex) {
                $("#formThongTinKhachHang").uiLoading(false);
            }
        });
    }

    function themMoiDonHang(action){
        $("#formThongTinKhachHang").resetValidation();
        var checkValid = $("#formThongTinKhachHang").validation({
            required: {
                ngayHoaDon: "Ngày hóa đơn không được trống!",
                hoTenKhachHang: "Họ tên khách hàng không được trống!",
                sdtKhachHang: "Số điện thoại khách hàng không được trống!",
                cccdKhachHang: "Định danh khách hàng không được trống!",
                ngaySinhKhachHang: "Ngày sinh khách hàng không được trống!"
            }
        });
        if (!checkValid.isValid) {
            $("#formThongTinKhachHang").bindError(checkValid);
            return;
        }
        let idKhachHang = $("#idKhachHang").val() ? $("#idKhachHang").val() : 0;
        if (idKhachHang <= 0){
            lib.showMessage('Thông tin khách hàng chưa được ghi!', 'error', function () {});
            return;
        }
        $("#formThongTinKhachHang").formTextTrim();
        var jsonData = $("#formThongTinKhachHang").getValue();
        lib.post({
            url: $("#PageContext").val() + "/do-don-hang",
            data: JSON.stringify({
                idKhachHang: idKhachHang,
                maDonHang: $("#soHoaDonKhachHang").val() ? $("#soHoaDonKhachHang").val() : "",
                ngayHoaDon: jsonData.ngayHoaDon,
                hoTen: jsonData.hoTenKhachHang,
                cccd: jsonData.cccdKhachHang,
                ngaySinh: jsonData.ngaySinhKhachHang,
                email: jsonData.emailKhachHang,
                soDienThoai: jsonData.sdtKhachHang,
                diaChi: jsonData.diaChiKhachHang
            }),
            beforePost:function(){
                $("#formThongTinKhachHang").uiLoading(true);
            },
            complete: function (response) {
                $("#formThongTinKhachHang").uiLoading(false);
                var res = response.responseJSON;
                if (res.errorCode < 0){
                    lib.showMessage('' + res.errorMessage, 'error', function () {
                        //
                    });
                }else {
                    lib.showMessage('' + res.errorMessage, 'success', function () {
                        $("#soHoaDonKhachHang").val(res.maDonHang);
                        getListHoaDonOfKhachHang(idKhachHang, '-1');
                    });
                }
            },
            error: function (ex) {
                $("#formThongTinKhachHang").uiLoading(false);
            }
        });
    }

    function openDialogSanPham(action, idHoaDon){
        $("#form-danh-muc-san-pham").shownDialog(
            {
                title: {
                    add: 'DANH MỤC SẢN PHẨM',
                    edit: 'SỬA BIẾN ĐỘNG HỘ KHÔNG CƯ TRÚ TẠI NƠI ĐĂNG KÝ THƯỜNG TRÚ',
                },
                action: action,
                onShown: function () {
                    lib.getApi({
                        url: $("#PageContext").val() + '/get-danh-muc-san-pham',
                        data: {
                            rownum: 100
                        },
                        complete: function (response) {
                            $("#id-don-hang").val(idHoaDon);
                            renderDanhMucSanPham(response);
                            getChiTietDonHang(idHoaDon);
                        },
                        error: function (ex) {}
                    });
                }
            });

        function renderDanhMucSanPham(data){
            const size = data.length;
            if (data){
                $("#modal-danh-muc-san-pham").empty();
                const maxCol = 4;
                var divRow = '';
                var divCol = '';
                let numCol = 0;
                for (let [index, item] of data.entries()){
                    numCol += 1;
                    divCol = divCol +
                          '<div class="col-md-3" prod-id="'+ item.idSanPham + '" prod-code="' + item.maSanPham + '" prod-don-gia="' + item.donGia + '">'
                        + '    <div class="card">'
                        + '        <div class="card-image">'
                        + '            <input class="card-image-input" type="image" src="data:image/png;base64,' + item.hinhAnhSanPham + '">'
                        + '        </div>'
                        + '        <div class="card-content">'
                        + '            <h4 class="card-title">'+ item.tenSanPham +'</h4>'
                        + '            <p class="card-description">' + (item.donGia).toLocaleString('vi-VN', { style: 'currency', currency: 'VND' }) + '</p>'
                        + '            <div class="card-footer">'
                        + '                <button class="card-button btn-primary add-shopping-cart" onclick="eventChooseProd(this)">Chọn</button>'
                        + '                <div class="quantity-wrapper">'
                        + '                     <label class="quantity-label">Số lượng</label>'
                        + '                     <input type="number"class="quantity-input" name="quantity" id="quantity" value="1" min="1"'
                        + '                             onkeypress="return event.charCode >= 48 && event.charCode <= 57"'
                        + '                             oninput="validateQuantity(this)"></div>'
                        + '            </div>'
                        + '        </div>'
                        + '    </div>'
                        + '</div>';
                    if (numCol == maxCol || (index + 1) == size){ /*đủ cột hoặc index cuối cùng*/
                        divRow = divRow + '<div class="row center" style="padding-top: 15px">' + divCol + '</div>'
                        numCol = 0;
                        divCol = '';
                    }
                }
            }
            $("#modal-danh-muc-san-pham")
                .append('<div class="form-title">Danh mục sản phẩm</div>')
                .append(divRow);
        }
    }

    function huyThongTin(){
        $("#formThongTinKhachHang").pathValue({
            soHoaDonKhachHang: "",
            ngayHoaDon: "",
            hoTenKhachHang: "",
            cccdKhachHang: "",
            ngaySinhKhachHang: "",
            emailKhachHang: "",
            sdtKhachHang: "",
            diaChiKhachHang: ""
            });
        $("#idKhachHang").val(0);
        $("#btn-tao-hoa-don").hide();
    }

    function getListHoaDonOfKhachHang(idKhacHang = 0, soHoaDon = '-1') {
        lib.getApi({
            url: $("#PageContext").val() + '/get-list-don-hang',
            data: {
                idKhachHang: idKhacHang,
                soHoaDon: soHoaDon
            },
            complete: function (response) {
                renderDanhSachHoaDon(response);
            },
            error: function (ex) {}
        });

        function renderDanhSachHoaDon(data){
            if (data){
                let khachHang = data;
                let hoaDons = data.danhSachDonHang;
                $("#danhSachHoaDonKhachHang").empty();
                $.each(hoaDons, function (i) {
                    let stt = i + 1;
                    let statusDesc = hoaDons[i].trangThai == 1 ? 'Đã thanh toán' : (hoaDons[i].trangThai == 2 ? 'Đã hủy' : 'Chưa thanh toán');
                    $('<tr class="tr-list">' +
                        '<td class="stt text-center">' +
                        '<input type="checkbox" name="row-hoadon" class="radio" ' +
                        'idHoadon = "'                          + hoaDons[i].idDonHang  +
                        '"soHoaDon ="'                          + hoaDons[i].maDonHang  +'"/></td>' +
                        '<td class="stt text-center">'          + stt                   + '</td>' +
                        '<td class="colf-ho-ten">'              + hoaDons[i].maDonHang     + '</td>' +
                        '<td class="colf-date">'                + hoaDons[i].ngayHoaDon    + '</td>' +
                        '<td class="colf-ho-ten">'              + khachHang.hoTen       + '</td>' +
                        '<td class="colf-date">'                + khachHang.ngaySinh    + '</td>' +
                        '<td class="colf-large text-center">'   + khachHang.cccd        + '</td>' +
                        '<td class="colf-large text-center">'   + khachHang.soDienThoai + '</td>' +
                        '<td class="colf-xl-large">'            + khachHang.email       + '</td>' +
                        '<td class="colf-xl-large">'            + khachHang.diaChi      + '</td>' +
                        '<td class="colf-status text-center">'  + statusDesc            + '</td>' +
                        '<td class="colf-xxl-large text-center">' +
                            '<a href="javascript:;" data-tooltip="true" title="Thêm" ' +
                                'class="not-click" onclick="openDialogSanPham(\'add\'\,' + hoaDons[i].idDonHang + ')">' +
                                '<span class="icon nc-icon-outline shopping_cart not-click"></span>' +
                            '</a>' +
                            '<a href="javascript:;" data-tooltip="true" title="Sửa" ' +
                                'class="not-click" onclick="">' +
                                '<span class="nc-icon-outline ui-1_edit-76 not-click"></span>' +
                            '</a>' +
                            '<a href="javascript:;" data-tooltip="true" title="Xóa" ' +
                                'class="not-click" onclick="">' +
                                '<span class="nc-icon-outline ui-1_trash-simple not-click"></span>' +
                            '</a></td>' +
                        '</tr>').appendTo("#danhSachHoaDonKhachHang");
                });
            }

        }
    }

    function getChiTietDonHang(idDonHang = 0) {
        lib.getApi({
            url: $("#PageContext").val() + '/get-chi-tiet-don-hang',
            data: {
                idDonHang: idDonHang,
            },
            complete: function (response) {
                renderChiTietHoaDon(response.chiTietDonHangs);
            },
            error: function (ex) {}
        });

        function renderChiTietHoaDon(data){
            if (data){
                $("#chiTietDonHang").empty();
                const vat = 0;
                const dvt = 'Cái';
                $.each(data, function (i) {
                    let stt = i + 1;
                    let sanPham = data[i].sanPhamDTO;
                    let thanhTien = (parseInt(data[i].soLuong) * parseFloat(data[i].donGia))
                    $('<tr class="tr-list">' +
                        '<td class="stt text-center">'         + stt                   + '</td>' +
                        '<td class="colf-xl-large">'           + sanPham.tenSanPham    + '</td>' +
                        '<td class="colf-status-center">'      + dvt                   + '</td>' +
                        '<td class="colf-status-center">'      + data[i].soLuong       + '</td>' +
                        '<td class="colf-status-center">'      + data[i].donGia        + '</td>' +
                        '<td class="colf-status-center">'      + vat                   + '</td>' +
                        '<td class="colf-xl-large">'                + (thanhTien).toLocaleString('vi-VN', { style: 'currency', currency: 'VND' }) + '</td>' +
                        '<td class="colf-xl-large text-center">'    +
                            '<a href="javascript:;" data-tooltip="true" title="Xóa" ' +
                            'class="not-click" onclick="xoaChiTietDonHang(' + data[i].idChiTiet + ')">' +
                            '<span class="nc-icon-outline ui-1_trash-simple not-click"></span>' +
                        '</a></td>' +
                        '</tr>').appendTo("#chiTietDonHang");
                });
            }

        }
    }

    function xoaChiTietDonHang(idChiTiet = 0){
        lib.post({
            url: $("#PageContext").val() + "/do-chi-tiet-don-hang",
            data: JSON.stringify({
                idDonHang: 0,
                idChiTiet: idChiTiet,
                soLuong: 0,
                donGia: 0,
                idSanPham: 0,
                trangThai: 0,
            }),
            beforePost:function(){
                $("#form-danh-muc-san-pham").uiLoading(true);
            },
            complete: function (response) {
                $("#form-danh-muc-san-pham").uiLoading(false);
                var res = response.responseJSON;
                if (res.errorCode < 0){
                    lib.showMessage('' + res.errorMessage, 'error', function () {
                        //
                    });
                }else {
                    lib.showMessage('' + res.errorMessage, 'success', function () {
                        let idDonHang = $("#id-don-hang").val();
                        getChiTietDonHang(idDonHang);
                    });
                }
            },
            error: function (ex) {
                $("#form-danh-muc-san-pham").uiLoading(false);
            }
        });
    }

    function thanhToan() {
        //Lấy thông tin chính từ form và modal
        const idDonHang = $("#id-don-hang").val() ? $("#id-don-hang").val() : 0;
        const idKhachHang = $("#idKhachHang").val() ? $("#idKhachHang").val() : 0;

        if (idDonHang <= 0) {
            lib.showMessage('Không có thông tin đơn hàng để thanh toán!', 'error');
            return;
        }

        // Lấy chi tiết đơn hàng
        lib.getApi({
            url: $("#PageContext").val() + '/get-chi-tiet-don-hang',
            data: {
                idDonHang: idDonHang,
            },
            beforePost: function () {
                // Hiển thị loading
                $("#form-danh-muc-san-pham").uiLoading(true);
            },
            complete: function (res) {
                // Kiểm tra giỏ hàng có rỗng không
                // 'res' chính là đối tượng JSON: { "idDonHang": 9, "chiTietDonHangs": [...] }
                if (!res || !res.chiTietDonHangs || res.chiTietDonHangs.length === 0) {
                    $("#form-danh-muc-san-pham").uiLoading(false);
                    lib.showMessage('Giỏ hàng trống, không thể thanh toán!', 'error');
                    return;
                }

                const maDonHang = res.maDonHang;
                const ngayHoaDon = res.ngayHoaDon;
                let chiTietDonHangs = res.chiTietDonHangs;
                const tongTien = chiTietDonHangs.reduce((total, item) => {
                    // item.soLuong và item.donGia
                    return total + (parseInt(item.soLuong) * parseFloat(item.donGia));
                }, 0);
                const trangThai = "1";

                // Gom toàn bộ dữ liệu đơn hàng
                const donHangData = {
                    idDonHang: idDonHang,
                    idKhachHang: idKhachHang,
                    maDonHang: maDonHang,
                    ngayHoaDon: ngayHoaDon,
                    tongTien: tongTien,
                    trangThai: trangThai,
                    chiTietDonHangs: chiTietDonHangs
                };

                console.log("Dữ liệu gửi lên /them-don-hang-json:", donHangData);

                fetch($("#PageContext").val() + "/api/donhang/them-don-hang-json", {
                    method: "POST",
                    headers: {
                        "Content-Type": "application/json"
                    },
                    body: JSON.stringify(donHangData)
                })
                    .then(response => {
                        $("#form-danh-muc-san-pham").uiLoading(false);
                        if (!response.ok) {
                            throw new Error("Gọi API thất bại: " + response.statusText);
                        }
                        return response.text();
                    })
                    .then(data => {
                        // Hiển thị thông báo thành công từ controller
                        lib.showMessage(data, 'success', function () {
                            $("#form-danh-muc-san-pham").hideDialog();
                            // Tải lại danh sách hóa đơn sau khi thanh toán thành công
                            getListHoaDonOfKhachHang(idKhachHang, '-1');
                        });
                    })
                    .catch(err => {
                        $("#form-danh-muc-san-pham").uiLoading(false);
                        console.error("Lỗi khi thanh toán: ", err);
                        lib.showMessage("Không thể lưu đơn hàng: " + err.message, 'error');
                    });

            },
            error: function (ex) {
                $("#form-danh-muc-san-pham").uiLoading(false);
                lib.showMessage('Lỗi khi lấy chi tiết giỏ hàng!', 'error');
            }
        });
    }
</script>