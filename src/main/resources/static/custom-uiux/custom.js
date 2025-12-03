$(document).ready(function () {
    var formAdvanceFocus = null;
    var KEY_BIEN_DONG_NHAN_KHAU_KHONG_THUONG_TRU = 2; /*biến động nhân khẩu không thường trú*/
    $(".btn-adv").click(function (e) {
        formAdvanceFocus = $(this).parents('form');
        // set gia tri form quick search sang form advanceSearch
        var valueQuickSearch = $(formAdvanceFocus).getValue();
        if (valueQuickSearch.citizenType != undefined && valueQuickSearch.citizenType == KEY_BIEN_DONG_NHAN_KHAU_KHONG_THUONG_TRU){
            $('#adv-search-citizen-out-regPlace').pathValue(valueQuickSearch);
            $('#adv-search-citizen-out-regPlace').shownDialog({});
        }else{
            $('#adv-search-content').pathValue(valueQuickSearch);
            $('#adv-search-content').shownDialog({});
        }
        e.stopPropagation();
    });


    $("#adv-search-content .close").click(function (e) {
        e.preventDefault();       
        $('#adv-search-content').hideDialog();
    });

    $('#adv-search-content').on('hidden.bs.modal', function (event) {
        if (formAdvanceFocus) {
            // set gia tri form advanceSearch sang form quick search
            var valueAdvanceSearch = $('#adv-search-content').getValue();
            $(formAdvanceFocus).pathValue(valueAdvanceSearch);
        }
    });

    $("#adv-search-citizen-out-regPlace .close").click(function (e) {
        e.preventDefault();
        $('#adv-search-citizen-out-regPlace').hideDialog();
    });

    $('#adv-search-citizen-out-regPlace').on('hidden.bs.modal', function (event) {
        if (formAdvanceFocus) {
            // set gia tri form advanceSearch sang form quick search
            var valueAdvanceSearch = $('#adv-search-citizen-out-regPlace').getValue();
            $(formAdvanceFocus).pathValue(valueAdvanceSearch);
        }
    });

    // adv in dialog
    var formAdvanceInDialogFocus = null;
    $(".btn-adv-dialog").click(function (e) {
        formAdvanceInDialogFocus = $(this).parents('form');
        // set gia tri form quick search sang form advanceSearch
        var valueQuickSearch = $(formAdvanceInDialogFocus).getValue();
        $('#adv-search-dialog').pathValue(valueQuickSearch);
        $('#adv-search-dialog').shownDialog({});
        e.stopPropagation();
    });


    $("#adv-search-dialog .close").click(function (e) {
        e.preventDefault();       
        $('#adv-search-dialog').hideDialog();
    });

    $('#adv-search-dialog').on('hidden.bs.modal', function (event) {
        if (formAdvanceInDialogFocus) {
            // set gia tri form advanceSearch sang form quick search
            var valueAdvanceSearch = $('#adv-search-dialog').getValue();
            $(formAdvanceInDialogFocus).pathValue(valueAdvanceSearch);
        }
    });
});