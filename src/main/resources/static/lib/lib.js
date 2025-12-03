var lib = new lib();

/*biendongdancu*/
var application = 'biendongdancu';
var dancu = dancu || {};
dancu.bddc = dancu.bddc || {};
dancu.bddc.config = dancu.bddc.config || {};

function lib() {

    this.compareDateWithCurrentDate = function (value) {
        //CurrentDate
        var todayTime = new Date();
        var month = (1 + todayTime.getMonth()).toString().padStart(2, '0');
        var day = todayTime.getDate().toString().padStart(2, '0');
        var year = todayTime.getFullYear();
        //
        var date = value.split('/');
        var currentDate = (day + "/" + month + "/" + year).split('/');

        var fromYear = +date[2];
        var fromMonth = +date[1];
        var fromDay = +date[0];
        var toYear = +currentDate[2];
        var toMonth = +currentDate[1];
        var toDay = +currentDate[0];
        if (fromYear > toYear) return 2;
        if (fromYear === toYear) {
            if (fromMonth > toMonth) return 2;
            if (fromMonth === toMonth) {
                if (fromDay > toDay || fromDay === toDay) return 2;
            }
        }
        return 1;
    }

    this.htmlEscape = function (text) {
        if (text == null || text == undefined) {
            return text;
        } else {
            return text.replace(/&/g, '&amp;').replace(/</g, '&lt;').  // it's not neccessary to escape >
                replace(/"/g, '&quot;').replace(/'/g, '&#039;');
        }
    };

    this.parsetoDate = function (strDate, split) {
        var date = strDate.split(split);
        return new Date(date[2], date[1] - 1, date[0]);
    };

    this.convertDate = function (strDate) {
        debugger
        var result;
        switch (strDate.toString().length) {
            case 4:
                result = strDate;
                break;
            case 6:
                result = strDate.toString().substr(4, 2) + "/" + strDate.toString().substr(0, 4);
                break;
            case 8:
                result = strDate.toString().substr(6, 2) + "/" + strDate.toString().substr(4,2) + "/" + strDate.toString().substr(0, 4);
                break;
            default:
                result = strDate;
                break;
        }
        return result;
    };

    this.parseBirthDate = function (rawDate, type) {
        if (rawDate == undefined || rawDate === ''){
            return rawDate;
        }
        var comp = rawDate.split("/");
        var result = rawDate;
        switch (comp.length) {
            case 1:
                var year = parseInt(comp[0], 10);
                var fulldate = '';
                if (type === 'end') {
                    fulldate = (year + 1) + '0101';
                } else {
                    fulldate = year + '0101'
                }
                result = fulldate;
                break;
            case 2:
                var month = parseInt(comp[0], 10);
                var year = parseInt(comp[1], 10);
                var fulldate = '';
                if (type === 'end'){
                    fulldate = new Date(year, month, 01);
                }else {
                    fulldate = new Date(year, month - 1, 01);
                }
                result = fulldate.getFullYear() + '' + plusZero(fulldate.getMonth() + 1)  + '' + plusZero(fulldate.getDate());
                break;
            case 3:
                var day = parseInt(comp[0], 10);
                var month = parseInt(comp[1], 10);
                var year = parseInt(comp[2], 10);
                var fulldate = '';
                if (type === 'end'){
                    fulldate = new Date(year, month - 1, day + 1);
                }else {
                    fulldate = new Date(year, month - 1, day);
                }
                result = fulldate.getFullYear() + '' + plusZero(fulldate.getMonth() + 1)  + '' + plusZero(fulldate.getDate());
                break;
            default:
                result = rawDate;
                break;
        }

        function plusZero(s) {
            return (s < 10) ? '0' + s : s;
        };
        return result;
    };
    // Hàm chuyển đổi thành phương thức doc / ghi / xoa lên server
    this.getAction = function (action) {
        var result = action;
        switch (action) {
            case "them":
            case "themKhongThuongTru":
                result = "doc";
                break;
            case "tiepnhan":
                result = "doc";
                break;
            case "sua":
                result = "doc";
                break;
            case "xem":
                result = "doc";
                break;
            case "capnhatngayve":
                result = "doc";
                break;
            default:
                result = action;
                break;
        }
        return result;
    };

    this.get = function (option) {
        if (option.beforePost) {
            option.beforePost();
        }
        $.ajax({
            type: "GET",
            contentType: "application/json",
            url: option.url,
            data: option.data,
            async: true,
            dataType: 'json',
            headers: {
                'Content-Type':'application/json',
            },
            complete: function (response) {
                lib.checkAut(response);
                try {
                    if (response.responseJSON.result === 'Success') {
                        if (option.complete) {
                            option.complete(response);
                        }
                    } else {
                        if(response.responseJSON.trackId) {
                            lib.showQrCode(response.responseJSON.trackId);
                        } else {
                            if (option.error) {
                                option.error(response);
                            }
                        }
                        $('body').uiLoading(false);
                    }
                } catch (e) {
                    console.log(e);
                    lib.showMessage('Lỗi hệ thống', 'error');
                }
            },
            error: function (jqXHR, exception) {
                if(jqXHR.responseJSON && jqXHR.status == 400){
                    lib.showMessage(jqXHR.responseJSON.message, 'error');
                }
            }
        });
    };

    this.getApi = function (option) {

        if (option.beforePost) {
            option.beforePost();
        }

        $.ajaxSetup({
            headers:{
                'Content-type': "application/json"
            }
        });

        $.get(option.url, option.data)
            .then(function (res) {
                var json = typeof res == 'string' ? JSON.parse(res) : res ;
                if(json.errors) {
                    if (option.error) {
                        option.error({
                            responseJSON:json
                        });
                    }
                } else {
                    if (option.complete) {
                        option.complete(res);
                    }
                }
                $('body').uiLoading(false);
            })
            .fail(function (err) {
                lib.checkAut(err);
                if (option.error) {
                    option.error(err);
                }

            });
    };

    this.postApi = function (option) {
        if (option.beforePost) {
            option.beforePost();
        }
        $.post(option.url, option.data)
            .then(function (res) {
                lib.checkAut(res);
                if (option.complete) {
                    option.complete(res);
                }
            })
            .fail(function (err) {
                lib.checkAut(err);
                if (option.error) {
                    option.error(err);
                }
            });
    };

    this.postDataAndFile = function (option) {
        if (option.beforePost) {
            option.beforePost();
        }
        $.ajax({
            type: "POST",
            enctype: 'multipart/form-data',
            url: lib.getBasePath() + url,
            data: option.data,
            processData: false,
            contentType: false,
            cache: false,
            timeout: 600000,
            dataType: 'json',
            complete: function (response) {
                lib.checkAut(response);
                try {
                    if (response.responseJSON.result === 'Success') {
                        if (option.complete) {
                            option.complete(response);
                        }
                    } else {
                        if(response.responseJSON.trackId) {
                            lib.showQrCode(response.responseJSON.trackId);
                        } else {
                            if (option.error) {
                                option.error(response);
                            }
                        }
                        $('body').uiLoading(false);
                    }
                } catch (e) {
                    console.log(e);
                    lib.showMessage('Lỗi hệ thống', 'error');
                }
            },
            error: function (jqXHR, exception) {
                if(jqXHR.responseJSON && jqXHR.status == 400){
                    lib.showMessage(jqXHR.responseJSON.message, 'error');
                }
            }
        });
    };

    this.post = function (option) {
        if (option.beforePost) {
            option.beforePost();
        }
        $.ajax({
            type: "POST",
            contentType: "application/json",
            url: option.url,
            data: option.data,
            async: option.async == undefined ? true : option.async,
            dataType: 'json',
            complete: function (response) {
                lib.checkAut(response);
                try {
                    if (response.responseJSON.result === 'Success') {
                        if (option.complete) {
                            option.complete(response);
                        }
                    } else {
                        if(response.responseJSON.trackId) {
                            lib.showQrCode(response.responseJSON.trackId);
                        } else {
                            if (option.error) {
                                option.error(response);
                            }
                        }
                        $('body').uiLoading(false);
                    }
                } catch (e) {
                    console.log(e);
                    lib.showMessage('Lỗi hệ thống', 'error');
                }
            },
            error: function (jqXHR, exception) {
                if(jqXHR.responseJSON && jqXHR.status == 400){
                    lib.showMessage(jqXHR.responseJSON.message, 'error');
                }

            }
        });
    };

    this.checkAut = function(response){
        if (response.statusText && response.statusText.toLowerCase() === 'error' && response.status != 400 && response.status != 302) { /*request có chứa cú pháp sai*/
            location.reload();
            return;
        }

        if (response.responseJSON && response.responseJSON.status == 302){
            location.href =  lib.getBasePath() + '/login?message=' + response.responseJSON.message;
            return;
        }

        if (response.responseJSON && response.responseJSON.error === 'Unauthorized'){
            var msg = escape("Hệ thống tạo session bị lỗi do kết nối lấy thông tin tài khoản bị gián đoạn");
            location.href =  lib.getBasePath() + '/login?message=' + msg;
            return;
        }
    };

    this.getBasePath = function() {
        try {
            if (dancu.bddc.config && Object.keys(dancu.bddc.config).length !== 0) {
                return dancu.bddc.config.basePath;
            }
            else {
                return "/biendongdancu";
            }
        } catch(e) {
            return "/biendongdancu";
        }
    };

    this.changeAlias = function (alias) {
        var str = alias;
        str = str.toLowerCase();
        str = str.replace(/à|á|ạ|ả|ã|â|ầ|ấ|ậ|ẩ|ẫ|ă|ằ|ắ|ặ|ẳ|ẵ/g, "a");
        str = str.replace(/è|é|ẹ|ẻ|ẽ|ê|ề|ế|ệ|ể|ễ/g, "e");
        str = str.replace(/ì|í|ị|ỉ|ĩ/g, "i");
        str = str.replace(/ò|ó|ọ|ỏ|õ|ô|ồ|ố|ộ|ổ|ỗ|ơ|ờ|ớ|ợ|ở|ỡ/g, "o");
        str = str.replace(/ù|ú|ụ|ủ|ũ|ư|ừ|ứ|ự|ử|ữ/g, "u");
        str = str.replace(/ỳ|ý|ỵ|ỷ|ỹ/g, "y");
        str = str.replace(/đ/g, "d");
        str = str.replace(/ + /g, " ");
        str = str.trim();
        return str;
    };

    this.clearValueRespon = function (res) {
        var value = JSON.parse(JSON.stringify(res));
        delete value.msg;
        delete value.result;
        return value;
    };

    this.getClassInputForm = function (name) {
        return name ?
            'input[name="' + name + '"],textarea[name="' + name + '"],select[name="' + name + '"]' :
            'input,textarea,select';
    };

    this.confirm = function (content) {
        return confirm(content);
    };

    this.confirm = function (content, resultFC) {
        $.confirm({
            title: '',
            type: '',
            columnClass: 'col-md-4 col-md-offset-4',
            content: content,
            buttons: {
                btnCancel: {
                    text: 'Đóng',
                    btnClass: 'btn-second',
                    action: function () {
                        if (resultFC) {
                            resultFC(false);
                        }
                    }
                },
                btnAccept: {
                    text: 'Đồng ý',
                    btnClass: 'btn-main',
                    action: function () {
                        if (resultFC) {
                            resultFC(true);
                        }
                    }
                }
            }
        });
    };

    this.showQrCode = function (trackId, message = 'Lỗi hệ thống') {
        $.dialog({
            title: message,
            content: `
        <div style="display: flex">
            <div style="margin: auto; text-align: center; padding: 10px;">
                <div id="qrcode"></div>
                <div style="padding-top: 10px;">
                <span style="margin-bottom: 5px;padding: 5px">${trackId}</span>
                </div>
            </div>
        </div>`
        });

        setTimeout(function () {
            $('#qrcode').qrcode({ width: 200, height: 200, text: trackId });
        }, 10);
    };

    this.showMessage = function (message) {
        var messageTxt = message;
        if (Array.isArray(message)) {
            messageTxt = '';
            for (const item of message) {
                messageTxt += item + '\n';
            }

        }
        alert(messageTxt);
    };

    this.showMessage = function (message, type, resultFC) {
        var typeClass = 'blue';
        if (type === 'error') {
            typeClass = 'red';
        } else if (type === 'success') {
            typeClass = 'green';
        }
        var messageTxt = message;
        if (Array.isArray(message)) {
            messageTxt = '';
            for (const item of message) {
                messageTxt += item + '<br/>';
            }

        }

        toastr.options = {
            "closeButton": false,
            "debug": false,
            "newestOnTop": false,
            "progressBar": false,
            "positionClass": "toast-top-right",
            "preventDuplicates": false,
            "onclick": null,
            "showDuration": "300",
            "hideDuration": "1000",
            "timeOut": "5000",
            "extendedTimeOut": "1000",
            "showEasing": "swing",
            "hideEasing": "linear",
            "showMethod": "fadeIn",
            "hideMethod": "fadeOut"
        };


        if (type === 'error') {
            debugger;
            toastr["error"](messageTxt);
        } else if (type === 'success') {
            toastr["success"](messageTxt);
        } else {
            toastr["primary"](messageTxt);
        }
        if (resultFC) {
            setTimeout(function () {
                resultFC();
            }, 1000);
        }

        // $.alert({
        //     title: '',
        //     type: typeClass,
        //     columnClass: 'col-md-4 col-md-offset-4',
        //     content: messageTxt,
        //     buttons: {
        //         btnAccept: {
        //             text: 'Đóng',
        //             btnClass: 'btn-second',
        //             action: function () {
        //                 if (resultFC) {
        //                     resultFC();
        //                 }
        //             }
        //         }
        //     }
        // });
    };

    this.getValueControl = function (control) {
        var result;
        if (control.length === 1) {
            var type = control[0].getAttribute('type');
            switch (type) {
                case 'checkbox':
                    result = control[0].checked ? true : false;
                    break;
                case 'radio':
                    result = control[0].checked ? true : false;
                    break;
                case 'number':
                    var valueInt = parseFloat(control[0].value);
                    if (isNaN(valueInt)) {
                        valueInt = null;
                    }
                    result = valueInt;
                    break;
                default:
                    result = control.val();
                    break;
            }
        } else if (control.length > 1) {
            var type = control[0].getAttribute('type');
            switch (type) {
                case 'checkbox':
                    result = getValueControlChecked(control);
                    break;
                case 'radio':
                    result = getValueControlRadioChecked(control);
                    break;
            }
        }
        return result;

        function getValueControlChecked(control) {
            var result = [];
            for (let index = 0; index < control.length; index++) {
                const item = control[index];
                if (item.checked) {
                    result.push(item.value);
                }
            }
            return result;
        }

        //Khangtn.tgg
        function getValueControlRadioChecked(control) {
            var result = "0";
            for (var index = 0; index < control.length; index++) {
                var item = control[index];
                if (item.checked) {
                    result = item.value;
                }
            }
            return result;
        }
    };

    this.setValueControl = function (control, value) {
        var type = control.attr('type');
        var element = control[0].tagName;
        if (element === 'SELECT') {
            type = element;
        }
        if ($(control).hasClass('date')) {
            type = 'date';
        }
        switch (type) {
            case 'checkbox':
                $(control[0]).prop("checked", value);
                break;
            case 'radio': //khangtn.tgg
                for (var i = 0; i < control.length; i++) {
                    var item = control[i];
                    if (item.value === value.toString()) {
                        $("#" + item.id + "").prop("checked", true);
                    }
                }
                break;
            case 'SELECT':
                control.val(value).change();
                // truong hop set value nhung select chua co du lieu set
                if (!control.select2('data').find(x => (x.id + '') === (value + '')) && value !== '' && value !== null && value !== undefined) {
                    lib.setDefaultValueSelect2(control[0], value);
                }
                break;
            case 'date':
                var dateValue = value ? value.split('/') : null;
                $(control).datepicker("setDate", value ? new Date(dateValue[2], +dateValue[1] - 1, dateValue[0]) : null);
                break;
            default:
                control.val(value);
                break;
        }

        if (value !== null && value !== undefined && value !== '') {
            $(control).parents('.form-group').addClass('active');
        } else {
            //nếu control trống mà ko disable thì mới bỏ active
            if (!control[0].hasAttribute('disabled')) {
                $(control).parents('.form-group').removeClass('active');
            }
        }
    };

    this.mergeValue = function (source1, source2) {
        var dataClone1 = JSON.parse(JSON.stringify(source1));
        var dataClone2 = JSON.parse(JSON.stringify(source2));
        for (const key in dataClone1) {
            dataClone2[key] = dataClone1[key];
        }
        return dataClone2;
    };

    this.reload = function () {
        location.reload();
    };

    this.getParamsUrl = function (search) {
        // if (!search) {
        //     return {};
        // }
        var search = location.search.substring(1);
        return JSON.parse('{"' + decodeURI(search).replace(/"/g, '\\"').replace(/&/g, '","').replace(/=/g, '":"') + '"}');
    };

    this.replaceUrlParam = function (url, paramName, paramValue) {
        if (paramValue === null) {
            paramValue = '';
        }
        var pattern = new RegExp('\\b(' + paramName + '=).*?(&|#|$)');
        if (url.search(pattern) >= 0) {
            return url.replace(pattern, '$1' + paramValue + '$2');
        }
        url = url.replace(/[?#]$/, '');
        return url + (url.indexOf('?') > 0 ? '&' : '?') + paramName + '=' + paramValue;
    };

    this.setDefaultValueSelect2 = function (item, valueDefault) {
        var multiple = item.hasAttribute("multiple");
        var dataUrl = item.getAttribute("data-url");
        var dataParam = item.getAttribute("data-param");
        valueDefault = multiple ? JSON.parse(valueDefault) : valueDefault;
        if (!dataUrl) {
            $(item).val(valueDefault).change();
            $(item).parents('.form-group').addClass('active');
            return;
        }
        var paramJson = {
            valueSearch: multiple ? valueDefault.join(',') : valueDefault
        };
        if (dataParam) {
            var dataParamObject = JSON.parse(dataParam);
            for (var keyName in dataParamObject) {
                paramJson[keyName] = dataParamObject[keyName];
            }
        }
        lib.get({
            url: dataUrl,
            data: paramJson,
            complete: function (response) {
                findOneResult(response);
            },
            error: function (ex) {
                lib.showMessage(ex.responseText, 'error');
            }
        });

        function findOneResult(res) {
            if (res.responseJSON.data) {
                var sourceOption = $(item).find('option');
                $(item).empty();
                var listOptionOld = [];
                for (var i = 0; i < sourceOption.length; i++) {
                    var text = $(sourceOption[i]).text();
                    var value = $(sourceOption[i]).attr('value');
                    var newOption = new Option(text, value, false, false);
                    $(item).append(newOption).trigger('change');
                    listOptionOld.push({ value: value, text: text });
                }
                if(!Array.isArray(res.responseJSON.data)) {
                    for (let key in res.responseJSON.data) {
                        var itemValue = {};
                        itemValue.id = key;
                        itemValue.text = res.responseJSON.data[key];
                        var newOption = new Option(itemValue.text, itemValue.id, false, false);
                        if (listOptionOld.findIndex(x => (x.value + '') === (itemValue.id + '')) === -1) {
                            $(item).append(newOption).trigger('change');
                        }
                    }
                } else {
                    for (let key of res.responseJSON.data) {
                        var itemValue = {};
                        itemValue.id = key.value;
                        itemValue.text = key.text;
                        var newOption = new Option(itemValue.text, itemValue.id, false, false);
                        if (listOptionOld.findIndex(x => (x.value + '') === (itemValue.id + '')) === -1) {
                            $(item).append(newOption).trigger('change');
                        }
                    }
                }


                $(item).val(valueDefault).change();
                $(item).parents('.form-group').addClass('active');
            }
        }
    };

    this.rowTableSelect = function (that, className = 'tr-list') {
        var rpId;
        rpId = $(that).attr('lst-id');
        $('.' + className).css("background-color", "");
        $(that).css("background-color", "#33CCCC");
        return rpId;
    };

    this.replaceUrlObject = function (url, objectParam) {
        for (var key in objectParam) {
            url = lib.replaceUrlParam(url, key, objectParam[key]);
        }
        return url;
    };

    this.fillNumberCount = function (param = "", length = 2, char = "0") {
        if ((param + '').length >= length) {
            return param;
        } else {
            var sub = length = (param + '').length;
            return char.repeat(sub) + param;
        }
    };

    this.stringToDate = function (dateString) {
        var dateParts = dateString.split("/");
        return new Date(+dateParts[2], dateParts[1] - 1, +dateParts[0]);
    };

    this.convertDataToSeriesColumnsChart = function (data) {
        var series = [];
        for (var key in label) {
            // console.log(key);
            var childSerie = {};
            childSerie.name = label[key];
            let arrayTemp = [];
            for (var item of data) {
                arrayTemp.push(item[key]);
            }
            childSerie.data = arrayTemp;
            series.push(childSerie);
        }
        return series;
    };

    this.convertDataToSeriesLineChart = function (data) {
        return this.convertDataToSeriesColumnsChart(data);
    };

    this.convertDataToSeriesPieChart = function (data) {
        return null;
    };

    this.convertDataToSeriesTableChart = function (data) {
        return null;
    };
    this.escapeHTML = function (value) {
        return value.replace(/&/g,'&amp;').replace(/</g,'&lt;').replace(/>/g,'&gt;');
    }
};

// rp thu vien bao cao

var rp = new rp();

function rp() {

    this.dowloadFile = function (formId, type) {
        var urlBase = lib.getBasePath() + '/exploitReportDataPost';
        var formData = $(formId).getValue();
        for( var item in formData) {
            var control = $(formId).find('select[name="'+item+'"][multiple]');
            if (control.length > 0){
                formData[item] = formData[item]? JSON.stringify(formData[item].map(x=>+x)) : '[]';
            }
        }
        formData.fileType = type;
        urlBase = encodeURI(lib.replaceUrlObject(urlBase, formData));
        location.href = urlBase;
    };

    this.dowloadFileParam = function (jsonParam, type) {
        var urlBase = lib.getBasePath() + '/exploitReportDataPost';
        // var formData = $(formId).getValue();
        jsonParam.fileType = type;
        urlBase = lib.replaceUrlObject(urlBase, jsonParam);
        location.href = urlBase;
    };

    this.renderIframe = function (formId, loadDone) {
        var urlOld = $("#reportviewer").attr('src');
        var urlBase = lib.getBasePath() + '/exploitReportDataPost';
        //view bao cao pdf
        var formData = $(formId).getValue();
        for( var item in formData) {
            var control = $(formId).find('select[name="'+item+'"][multiple]');
            if (control.length > 0){
                formData[item] = formData[item]? JSON.stringify(formData[item].map(x=>+x)) : '[]';
            }
        }
        formData.isView = true;
        formData.fileType = 'pdf';
        urlBase = lib.replaceUrlObject(urlBase, formData);
        if (urlBase !== urlOld || application == 'biendongdancu') {
            //tạo event lắng nghe iframe lắng nghe duy nhất 1 lần rồi tự hủy khi thành công
            var reportElement = document.getElementById("reportviewer");
            reportElement.addEventListener('load', function _listener() {
                if (loadDone) {
                    loadDone();
                }
                $(formId).uiLoading(false);
                reportElement.removeEventListener('load', _listener, true);
            }, true);
            $("#reportviewer").attr('src', encodeURI(urlBase));
        } else {
            if (loadDone) {
                loadDone();
            }
            $(formId).uiLoading(false);
        }
    };


    this.renderIframeParam = function (formData, reportviewerId, loadDone) {
        var urlOld = $('#' + reportviewerId).attr('src');
        var urlBase = lib.getBasePath() + '/exploitReportDataPost';
        //view bao cao pdf
        formData.isView = true;
        formData.fileType = 'pdf';
        urlBase = lib.replaceUrlObject(urlBase, formData);
        if (urlBase !== urlOld || application == 'biendongdancu') {
            //tạo event lắng nghe iframe lắng nghe duy nhất 1 lần rồi tự hủy khi thành công
            var reportElement = document.getElementById(reportviewerId);
            reportElement.addEventListener('load', function _listener() {
                if (loadDone) {
                    loadDone();
                }
                reportElement.removeEventListener('load', _listener, true);
            }, true);
            $("#" + reportviewerId).attr('src', urlBase);
        } else {
            if (loadDone) {
                loadDone();
            }
        }
    };

    this.view = function (formId, iframeId = 'reportviewer') {
        $(formId).uiLoading(true);
        rp.renderIframe(formId, null, iframeId);
        $("#reportviewer").show();
    };

    this.viewParam = function (jsonParam, reportviewer) {
        rp.renderIframeParam(jsonParam, reportviewer, null);
        $("#reportviewer").show();
	};
    this.print = function (formId, iframeId = 'reportviewer') {
        rp.renderIframe(formId, function () {
            window.frames.reportviewer.print();
        }, iframeId);
    };

    this.printParam = function (jsonParam, reportviewer) {
        rp.renderIframeParam(jsonParam, reportviewer, function () {
            window.frames.reportviewer.print();
        });
    };

    // BCTK# ghi log 14 báo cáo
    this.writeLog = function (formId, type, object) {
        let urlBase = lib.getBasePath() + '/rpt/write-log-view-print-export';
        const obj = {
            'view': 1,
            'print': 2,
            'rtf': 3,
            'xlsx': 3,
            'pdf': 3
        };

        if(formId) {
            const formData = $(formId).getValue();

            formData.queryType = obj[type];
            lib.post({
                url: urlBase,
                data: JSON.stringify(formData),
                complete: function (response) {

                },
                error: function (ex) {

                }
            });
        } else {
            const formData = object;
            formData.queryType = obj[type];
            lib.post({
                url: urlBase,
                data: JSON.stringify(formData),
                complete: function (response) {

                },
                error: function (ex) {

                }
            });
        }

    };

    //BCTK# function dành riêng cho 14 báo cáo
    this.countReportRun = function (formId, done, failed) {
        let urlBase = lib.getBasePath() + '/rpt/count-report-run';
        const formData = $(formId).getValue();
        lib.post({
            url: urlBase,
            data: JSON.stringify(formData),
            complete: function (response) {
                if (response.responseJSON.data < 1){
                    if (done) done();
                } else {
                    if (failed) failed();
                    else
                        lib.showMessage("Không có dữ liệu",'error');
                }
            }
        });
    };
}


// extention jQuery
jQuery.fn.extend({
    shownDialog: function (options) {
        // set title dialog
        switch (options.action) {
            case 'xem':
                if (options.title && options.title.view) {
                    $(this).find(".modal-title").html(options.title.view);
                }
                break;
            case 'them':
            case 'tiepnhan':
            case 'themKhongThuongTru':
                if (options.title && options.title.add) {
                    $(this).find(".modal-title").html(options.title.add);
                }
                break;
            case 'sua':
            case 'capnhat':
                if (options.title && options.title.edit) {
                    $(this).find(".modal-title").html(options.title.edit);
                }
                break;
            case 'capnhatngayve':
                if (options.title && options.title.capnhatngayve) {
                    $(this).find(".modal-title").html(options.title.capnhatngayve);
                }
                break;
            default:
                if (options.title) {
                    $(this).find(".modal-title").html(options.title);
                }
                break;
        }

        $(this).unbind('shown.bs.modal');
        // shown dialog
        $(this).modal({
            show: true,
            keyboard: false,
            backdrop: 'static'
        });
        // event dialog
        $(this).on('shown.bs.modal', function () {
            if (options.onShown) {
                options.onShown();
            }
        });
    },
    shownDialogBC: function (options) {
        var myform = this;
        $(this).find(".modal-title").html(options.title[options.action]);
        $(this).unbind('shown.bs.modal');
        // shown dialog
        $(this).modal({
            show: true,
            keyboard: false,
            backdrop: 'static'
        });
        // event dialog
        $(this).on('shown.bs.modal', function () {
            if (options.onShown) {
                options.onShown();
                //focus first control
                for (var property in $(this).getValue()) {
                    var control = $(myform).find(lib.getClassInputForm(property));
                    if ($(control).is(':disabled')) {
                        continue;
                    }
                    setTimeout(function () {
                        $(myform).find(lib.getClassInputForm(property)).focus();
                    }, 300);
                    break;
                }
            }
        });
        if (options.buttons) {
            $(this).find('.modal-footer').empty();
            if (options.buttons[options.action]) {
                for (const btn of options.buttons[options.action]) {
                    const objButton = {};
                    if (btn.id) {
                        objButton.id = btn.id;
                    }
                    if (btn.class) {
                        objButton.class = btn.class;
                    } else {
                        objButton.class = 'btn btn-line';
                    }
                    if (btn.name) {
                        objButton.name = btn.name;
                    }
                    if (btn.tabindex) {
                        objButton.tabindex = btn.tabindex;
                    }
                    objButton.type = 'button';
                    console.log(objButton);
                    const $btn = $("<Button>", objButton);
                    if (btn.func) {
                        $btn.click(btn.func);
                    }
                    $btn.html(btn.title);
                    $(this).find('.modal-footer').append($btn);
                }
            }
        }
        if (!options.hideClose)
            $(this).find('.modal-footer').append('<button class="btn btn-line" name="btn-close">Quay lại</button>');
    },
    focusFristControl: function () {
        for (var property in $(this).getValue()) {
            var control = $(this).find(lib.getClassInputForm(property));
            if ($(control).is(':disabled')) {
                continue;
            }
            setTimeout(function () {
                $(this).find(lib.getClassInputForm(property)).focus();
            }, 1000);
            break;
        }
    },
    hideDialog: function () {
        $(this).modal('hide');
    },
    pathValue: function (value) {
        for (const property in value) {
            var valueItem = value[property];
            var control = $(this).find(lib.getClassInputForm(property));
            if (control.length > 0) {
                // todo check box in array
                lib.setValueControl(control, valueItem);
            }
        }
    },
    resetValueControl: function (value) {
        for (const property in value) {
            var valueItem = value[property];
            var control = $(this).find(lib.getClassInputForm(property));
            if (control.length > 0) {
                // todo check box in array
                lib.setValueControl(control, valueItem);
                $(control).parents('.form-group').find('.form-control').removeClass('control-invalid');
                $(control).parents('.form-group').removeClass('group-invalid');
                $(control).parents('.form-group').find('.error-message').remove();
                if (!control[0].hasAttribute('disabled')) {
                    $(control).parents('.form-group').removeClass('active');
                }
            }
        }
    },
    disableControl: function (items, value) {
        for (var property in items) {
            var control = $(this).find(lib.getClassInputForm(property));
            if (control.length > 0) {
                $(control[0]).prop("disabled", value);
                $(control).parents('.form-group').addClass('active');
            }
        }
    },
    disableControlValue: function (items) {
        for (var property in items) {
            var control = $(this).find(lib.getClassInputForm(property));
            if (control.length > 0) {
                $(control[0]).prop("disabled", items[property]);
                $(control).parents('.form-group').addClass('active');
            }
        }
    },
    disableAllControl: function (value) {
        $(this).find(lib.getClassInputForm()).prop("disabled", value);
        $(this).find(lib.getClassInputForm()).parents('.form-group').addClass("active");
    },
    showHideControlValue: function (items) {
        for (var property in items) {
            var control = $(this).find(lib.getClassInputForm(property));
            if (control.length > 0) {
                if (items[property])
                    $(control[0]).show();
                else
                    $(control[0]).hide();

            }
        }
    },
    showHideControlValueById: function (items) {
        for (var property in items) {
            var control = $(this).find(lib.getClassInputForm(property));
            if (items[property])
                $("#" + property).show();
            else
                $("#" + property).hide();

        }
    },
    clearAllControl: function (value) {
        var control = $(this).find(lib.getClassInputForm()).val(value);
    },
    clearControlValue: function (items) {
        for (var property in items) {
            var control = $(this).find(lib.getClassInputForm(property));
            if (control.length > 0) {
                $(control[0]).val(items[property]);
            }
        }
    },
    validation: function (options) {
        var formId = this;
        var result = {
            isValid: true,
            errors: [],
            controlErrors: []
        };
        var controlFirstError = null;
        $(formId).find(lib.getClassInputForm()).removeClass('control-invalid');

        validationLogic();

        if (controlFirstError) {
            $(controlFirstError).focus();
        }
        return result;

        // --Functions--
        function setControlFirst(control) {
            if (!controlFirstError) {
                controlFirstError = control;
            }
        }

        function addControlError(key, objError) {
            if (!result.controlErrors[key]) {
                result.controlErrors[key] = [objError];
            }
            result.controlErrors[key].push(objError);
        }

        function validationLogic() {
            // required
            if (options.required) { // exp: { [keyname]: '[message error]'}
                for (const property in options.required) {
                    var control = $(formId).find(lib.getClassInputForm(property));
                    if (control.length > 0) {
                        var controlValue = lib.getValueControl(control) + '';
                        if (!controlValue || controlValue === 'NULL' || controlValue === null || controlValue === 'null') {
                            setControlFirst(control[0]);
                            $(control[0]).addClass('control-invalid');
                            result.isValid = false;
                            result.errors.push(options.required[property]);
                            addControlError(property, {
                                required: options.required[property]
                            });
                        }
                    }
                }
            }

            /*check Birthday: 2020 || 11/2020 || 11/11/2020*/
            if (options.checkBirthdate) { // exp: { [keyname]: '[message error]'}
                for (const property in options.checkBirthdate) {
                    var checkDate = true;
                    var control = $(formId).find(lib.getClassInputForm(property));
                    if (control.length > 0) {
                        for (var i = 0; i < control.length; i++){
                            var controlValue = control[i].value;
                            if (controlValue) {
                                var comp = controlValue.split('/');
                                switch (comp.length) {
                                    case 1:
                                        var year = parseInt(comp[0], 10);
                                        var date = new Date(year,0,01);
                                        if (date.getFullYear() != year){
                                            checkDate = false;
                                        }
                                        break;
                                    case 2:
                                        var month = parseInt(comp[0], 10);
                                        var year = parseInt(comp[1], 10);
                                        var date = new Date(year,month-1, 01);
                                        if (date.getFullYear() != year || date.getMonth() + 1 != month){
                                            checkDate = false;
                                        }
                                        break;
                                    case 3:
                                        var day = parseInt(comp[0], 10);
                                        var month = parseInt(comp[1], 10);
                                        var year = parseInt(comp[2], 10);
                                        var date = new Date(year,month-1, day);
                                        if (date.getFullYear() != year || date.getMonth() + 1 != month || date.getDate() != day){
                                            checkDate = false;
                                        }
                                        break;
                                }
                                if (!checkDate) {
                                    setControlFirst(control[0]);
                                    //$(control[0]).addClass('control-invalid');
                                    result.isValid = false;
                                    result.errors.push(options.checkBirthdate[property]);
                                    addControlError(property, {
                                        checkBirthdate: options.checkBirthdate[property]
                                    });
                                    break;
                                }
                            }
                        }
                    }
                }
            }

            if (options.checkFullDate) { // exp: { [keyname]: '[message error]'}
                for (const property in options.checkFullDate) {
                    var control = $(formId).find(lib.getClassInputForm(property));
                    if (control.length > 0) {
                        var controlValue = lib.getValueControl(control) + '';
                        if (controlValue) {
                            var comp = controlValue.split('/');
                            var day = parseInt(comp[0], 10);
                            var month = parseInt(comp[1], 10);
                            var year = parseInt(comp[2], 10);
                            var fulldate = comp[2] + comp[1] + comp[0];
                            var date = new Date(year,month-1,day);
                            if (date.getFullYear() != year || date.getMonth() + 1 != month || date.getDate() != day || fulldate.length != 8) {
                                setControlFirst(control[0]);
                                $(control[0]).addClass('control-invalid');
                                result.isValid = false;
                                result.errors.push(options.checkFullDate[property]);
                                addControlError(property, {
                                    checkFullDate: options.checkFullDate[property]
                                });
                            }
                        }
                    }
                }
            }
            // minlength
            if (options.minlength) { // exp: {[keyname]: {value: [value min
                // length],message:'[message error]'}}
                for (const property in options.minlength) {
                    var control = $(formId).find(lib.getClassInputForm(property));
                    if (control.length > 0) {
                        var controlValue = lib.getValueControl(control);
                        if (controlValue && controlValue !== 'NULL' && controlValue !== null && (controlValue + '').length < options.minlength[property].value) {
                            setControlFirst(control[0]);
                            $(control[0]).addClass('control-invalid');
                            result.isValid = false;
                            result.errors.push(options.minlength[property].message);
                            addControlError(property, {
                                minlength: options.minlength[property].message
                            });
                        }
                    }
                }
            }
            // maxlength
            if (options.maxlength) { // exp: {[keyname]: {value: [value max
                // length],message:'[message error]'}}
                for (const property in options.maxlength) {
                    var control = $(formId).find(lib.getClassInputForm(property));
                    if (control.length > 0) {
                        var controlValue = lib.getValueControl(control);
                        if (controlValue && controlValue !== 'NULL' && controlValue !== null && (controlValue + '').length > options.maxlength[property].value) {
                            setControlFirst(control[0]);
                            $(control[0]).addClass('control-invalid');
                            result.isValid = false;
                            result.errors.push(options.maxlength[property].message);
                            addControlError(property, {
                                maxlength: options.maxlength[property].message
                            });
                        }
                    }
                }
            }
            // min
            if (options.min) { // exp: {[keyname]: {value: [value
                // min],message:'[message error]'}}
                for (const property in options.min) {
                    var control = $(formId).find(lib.getClassInputForm(property));
                    if (control.length > 0) {
                        var controlValue = lib.getValueControl(control) + '';
                        if (controlValue && controlValue !== 'NULL' && controlValue !== null && controlValue !== 'null' && +controlValue < options.min[property].value) {
                            setControlFirst(control[0]);
                            $(control[0]).addClass('control-invalid');
                            result.isValid = false;
                            result.errors.push(options.min[property].message);
                            addControlError(property, {
                                min: options.min[property].message
                            });
                        }
                    }
                }
            }

            if (options.max) { // exp: {[keyname]: {value: [value
                // max],message:'[message error]'}}
                for (const property in options.max) {
                    var control = $(formId).find(lib.getClassInputForm(property));
                    if (control.length > 0) {
                        var controlValue = lib.getValueControl(control);
                        if (controlValue && controlValue !== 'NULL' && controlValue !== null && +controlValue > options.max[property].value) {
                            setControlFirst(control[0]);
                            $(control[0]).addClass('control-invalid');
                            result.isValid = false;
                            result.errors.push(options.max[property].message);
                            addControlError(property, {
                                max: options.max[property].message
                            });
                        }
                    }
                }
            }

            if (options.phone) { // exp: {[keyname]:[message]}
                var phoneRegex = /^[\+]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{4,6}$/im;
                for (const property in options.phone) {
                    var control = $(formId).find(lib.getClassInputForm(property));
                    if (control.length > 0) {
                        var controlValue = lib.getValueControl(control);
                        if (controlValue && controlValue !== 'NULL' && controlValue !== null && !phoneRegex.test(controlValue)) {
                            setControlFirst(control[0]);
                            $(control[0]).addClass('control-invalid');
                            result.isValid = false;
                            result.errors.push(options.phone[property]);
                            addControlError(property, {
                                phone: options.phone[property]
                            });
                        }
                    }
                }
            }

            if (options.email) { // exp: {[keyname]:[message error]}
                var emailRegex = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
                for (const property in options.email) {
                    var control = $(formId).find(lib.getClassInputForm(property));
                    if (control.length > 0) {
                        var controlValue = lib.getValueControl(control);
                        if (controlValue && controlValue !== 'NULL' && controlValue !== null && !emailRegex.test(String(controlValue).toLowerCase())) {
                            setControlFirst(control[0]);
                            $(control[0]).addClass('control-invalid');
                            result.isValid = false;
                            result.errors.push(options.email[property]);
                            addControlError(property, {
                                email: options.email[property]
                            });
                        }
                    }
                }
            }

            if (options.number) { // exp: {[keyname]:[message error]}
                var numberRegex = /^\d+$/;
                for (const property in options.number) {
                    var control = $(formId).find(lib.getClassInputForm(property));
                    if (control.length > 0) {
                        var controlValue = lib.getValueControl(control);
                        if (controlValue && controlValue !== 'NULL' && controlValue !== null && !numberRegex.test(controlValue)) {
                            setControlFirst(control[0]);
                            $(control[0]).addClass('control-invalid');
                            result.isValid = false;
                            result.errors.push(options.number[property]);
                            addControlError(property, {
                                number: options.number[property]
                            });
                        }
                    }
                }
            }

            if (options.regex) { // exp:
                // {[keyname]:{value:[regex],message:[message
                // error]}}
                for (const property in options.regex) {
                    var control = $(formId).find(lib.getClassInputForm(property));
                    if (control.length > 0) {
                        var controlValue = control[0].value;
                        var regexValue = options.regex[property].value;
                        if (controlValue && controlValue !== 'NULL' && controlValue !== null && !regexValue.test(controlValue)) {
                            setControlFirst(control[0]);
                            $(control[0]).addClass('control-invalid');
                            result.isValid = false;
                            result.errors.push(options.regex[property].message);
                            addControlError(property, {
                                regex: options.regex[property].message
                            });
                        }
                    }
                }
            }
        }
    },
    resetValidation: function () {
        $(this).find('.form-control').removeClass('control-invalid');
        $(this).find('.form-group').removeClass('group-invalid');
        $(this).find('.form-group').find('.error-message').remove();
    },
    getValue: function () {
        var result = {};
        var control = $(this).find(lib.getClassInputForm());
        var controlName = [];
        for (let index = 0; index < control.length; index++) {
            var name = control[index].getAttribute('name');
            if (!controlName.find(x => x === name)) {
                controlName.push(name);
            }
        }
        for (const name of controlName) {
            var controls = $(this).find(lib.getClassInputForm(name));
            var ctlValue = lib.getValueControl(controls);
            if (ctlValue !== undefined) {
                result[name] = ctlValue;
            }
        }
        return result;
    },
    uiLoading: function (value) {
        // if (value){
        //     $('body').addClass('loading');
        // } else {
        //     setTimeout(function () {
        //         $('body').removeClass('loading');
        //     }, 300)
        // }
        if (value) {
            $('#loading').show();
        } else {
            $('#loading').hide();
        }
    },
    setError: function (obj, showMessage = true) {
        for (var key in obj) {
            if (obj[key]) {
                //check control exist
                if ($(this).find(lib.getClassInputForm(key)).length === 0) {
                    lib.showMessage(obj[key], 'error');
                    return;
                }
                $(this).find(lib.getClassInputForm(key)).addClass('control-invalid');
                $(this).find(lib.getClassInputForm(key)).parents('.form-group').eq(0).addClass('group-invalid');
                var spanMess = $(this).find(lib.getClassInputForm(key)).parents('.form-group').eq(0).find('.error-message');
                if (spanMess.length === 0) {
                    $(this).find(lib.getClassInputForm(key)).parents('.form-group').eq(0).append('<span class="error-message">' + obj[key] + '</span>');
                } else {
                    spanMess.html('<span class="error-message">' + obj[key] + '</span>');
                }

            } else {
                $(this).find(lib.getClassInputForm(key)).removeClass('control-invalid');
                $(this).find(lib.getClassInputForm(key)).parents('.form-group').eq(0).removeClass('group-invalid');
                var spanMess = $(this).find(lib.getClassInputForm(key)).parents('.form-group').eq(0).find('.error-message');
                if (spanMess.length > 0) {
                    $(spanMess).remove();
                }
            }
        }
    },
    bindError: function (res) {
        try {
            if (res.controlErrors) {
                //loi tu valid
                $(this).resetValidation();
                for (const key in res.controlErrors) {
                    if (res.controlErrors[key].length > 0) {
                        for (const item in res.controlErrors[key][0]) {
                            const element = res.controlErrors[key][0][item];
                            var control = {};
                            control[key] = element;
                            $(this).setError(control);
                        }
                    }
                }
            } else {
                //loi tu api
                var result = res.responseJSON;
                if (result && result.errors) {
                    for (const key in result.errors) {
                        if(key === ''){
                            lib.showMessage(result.errors[key], 'error');
                            return;
                        }
                        var control = {};
                        control[key] = result.errors[key];
                        $(this).setError(control);
                    }
                }
            }
        } catch (error) {
            lib.showMessage(res.responseText, 'error');
        }
    },
    paging: function (option) {
        var pagingElement = this;

        //hủy event va khởi tạo lại từ đầu
        $(pagingElement).unbind();

        var pageValue = $(pagingElement).attr('data-page');
        var sizeValue = $(pagingElement).attr('data-size');
        var count = $(pagingElement).attr('data-count');
        var fnChange = $(pagingElement).attr('change');
        var filtersize = true; // = $(pagingElement).attr('filter-size');
        var textPage = '';
        var countFrom = 0;
        var countTo = 0;
        if (!filtersize) {
            filtersize = true;
        }
        if (option) {
            if (option.page) {
                pageValue = option.page;
            }
            if (option.size) {
                sizeValue = option.size;
            }
            if (option.count || option.count === 0) {
                count = option.count;
            }
        }

        pageValue = pageValue ? +pageValue : 1;
        sizeValue = sizeValue ? +sizeValue : 10;
        count = count ? +count : 0;

        var lstPage = [];
        if (!count || count === 0) {
            $(pagingElement).html('');
            return;
        }
        var totalPage = Math.ceil(count / sizeValue);
        var view = 5;

        if (totalPage > 1) {
            var showItem = view;
            if (totalPage < view) {
                showItem = totalPage;
            }
            // index slot curent page
            var index = pageValue;
            if (showItem === view) {
                index = showItem % 2 === 0 ? (showItem / 2) : parseInt((showItem / 2).toString()) + 1;
            }

            var fix = pageValue < index ? (index - pageValue) : 0;
            if (pageValue > (totalPage - index) && showItem === view) {
                fix = (totalPage - index) - pageValue + 1;
            }
            for (let i = 1; i <= showItem; i++) {
                lstPage.push(pageValue - index + i + fix);
            }
        } else {
            lstPage.push(1);
        }

        if (totalPage === 1 && filtersize !== true) {
            $(pagingElement).html('');
            return;
        }
        /*điều chỉnh lại cách hiển thị phân trang*/
        // countFrom = (pageValue * sizeValue) + 1 - (sizeValue);
        // countTo = (pageValue * sizeValue) > count ? count : (pageValue * sizeValue);
        // textPage = 'Số hàng mỗi trang: ';

        var htmlRender = '';

        htmlRender += '<div class="paging-control">';
        htmlRender += '<ul class="wapper">${listControl}</ul>';
        htmlRender += '</div>';
        if(pageValue === totalPage){
            htmlRender += '<div class="pull-left">Có '+count+' kết quả được tìm thấy</div>';
        }else {
            if (count>100){
                htmlRender += '<div class="pull-left">Có hơn 100 kết quả được tìm thấy</div>';
            }else{
                htmlRender += '<div class="pull-left">Có '+count+' kết quả được tìm thấy</div>';
            }
        }

        htmlRender += '<div class="paging-size' + (filtersize === true ? '' : ' hiden-pg') + '">';
        htmlRender += '<div class="wapper">';
        htmlRender += '<div class="pull-left p-m-r-5">Số hàng mỗi trang:</div>';
        htmlRender += '<div class="pull-left form-group active p-m-r-5">';
        htmlRender += '<div class="dropdown">';
        htmlRender += '<button class="form-control dropdown-toggle" type="button" data-toggle="dropdown">' + sizeValue;
        htmlRender += '<span class="caret"></span></button>';
        htmlRender += '<ul class="dropdown-menu">';
        htmlRender += '<li><a href="javascript:;" class="change-size-page">10</a></li>';
        htmlRender += '<li><a href="javascript:;" class="change-size-page">20</a></li>';
        htmlRender += '<li><a href="javascript:;" class="change-size-page">30</a></li>';
        htmlRender += '</ul>';
        htmlRender += '</div>';
        htmlRender += '</div>';
        htmlRender += '</div>';
        htmlRender += '</div>';

        //if (totalPage > 1) {
        var pagingHtml = '';
        // render htm paging
        var url = lib.replaceUrlParam(location.href, 'page', 1);
        pagingHtml += '<li title="Trang đầu" class="item-control ' + (pageValue === 1 ? 'disable' : '') + '"><a href="' + url + '" class="a-vnpt-paging" data-page="1"><span class="fa fa-angle-double-left"></span></a></li>';
        url = lib.replaceUrlParam(location.href, 'page', pageValue - 1);
        pagingHtml += '<li title="Trang trước" class="item-control ' + (pageValue === 1 ? 'disable' : '') + '"><a href="' + url + '" class="a-vnpt-paging" data-page="' + (pageValue > 1 ? pageValue - 1 : 1) + '"><span class="fa fa-angle-left"></span></a></li>';
        for (const x of lstPage) {
            url = lib.replaceUrlParam(location.href, 'page', x);
            pagingHtml += '<li class="item-control ' + (pageValue === x ? 'active' : '') + '"><a href="' + url + '" class="a-vnpt-paging" data-page="' + x + '">' + x + '</a></li>';
        }
        url = lib.replaceUrlParam(location.href, 'page', pageValue + 1);
        pagingHtml += '<li title="Trang sau" class="item-control ' + (pageValue === totalPage ? 'disable' : '') + '"><a href="' + url + '" class="a-vnpt-paging" data-page="' + (pageValue + 1) + '"><span class="fa fa-angle-right"></span></a></li>';
        url = lib.replaceUrlParam(location.href, 'page', totalPage);
        pagingHtml += '<li title="Trang cuối" class="item-control ' + (pageValue === totalPage ? 'disable' : '') + '"><a href="' + url + '" class="a-vnpt-paging" data-page="-1"><span class="fa fa-angle-double-right"></span></a></li>';

        htmlRender = htmlRender.replace('${listControl}', pagingHtml);

        $(pagingElement).html(htmlRender);

        $(pagingElement).on('click', '.change-size-page', function (e) {
            if (fnChange) {
                eval(fnChange.replace('$event', '1,' + parseInt(this.text)));
            } else {
                var url = lib.replaceUrlParam(location.href, 'page', 1);
                url = lib.replaceUrlParam(url, 'size', parseInt(this.text));
                location.href = url;
            }
            $(this).text(this.text + ' / ' + count);
        });

        $(pagingElement).on('click', '.a-vnpt-paging', function (e) {
            if (fnChange) {
                e.preventDefault();
                eval(fnChange.replace('$event', +this.getAttribute('data-page') + ',' + sizeValue));
            }
        });
    },
    getSelectRow: function () {
        var listId = [];
        var selected = $(this).find('input:checkbox[class="select-row"]:checked');
        for (let i = 0; i < selected.length; i++) {
            var element = selected.eq(i);
            listId.push(+element.val());
        }
        return listId;
    },
    getSelectRowMore: function (ref = "") {
        var listId = [];
        var selected = $(this).find('input:checkbox[ref="' + ref + '"]:checked');
        for (let i = 0; i < selected.length; i++) {
            var element = selected.eq(i);
            listId.push(element.val());
        }
        return listId;
    },
    getSelectRowWithAttr: function (ref = "", attr = "") {
        var listValue = [];
        var selected = $(this).find('input:checkbox[ref="' + ref + '"]:checked');
        for (let i = 0; i < selected.length; i++) {
            var element = selected.eq(i);
            listValue.push(+element.attr(attr));
        }
        return listValue;
    },
    selectAddRows: function (check) {
        $(this).find('input:checkbox[class=select-row]:checked').prop('checked', check);
    },
    formTextTrim: function () {
        var result = {};
        var control = $(this).find(lib.getClassInputForm());
        var controlName = [];
        for (let index = 0; index < control.length; index++) {
            var name = control[index].getAttribute('name');
            var type = control[index].getAttribute('type');
            if (type !== 'text') continue;
            if (!controlName.find(x => x === name)) {
                controlName.push(name);
            }
        }
        for (const name of controlName) {
            var controls = $(this).find(lib.getClassInputForm(name));
            var ctlValue = lib.getValueControl(controls);
            if (ctlValue !== undefined) {
                result[name] = (ctlValue + '').trim();
            }
        }
        $(this).pathValue(result);
    },

    formTextTrimControl: function (items) {
        var result = {};
        var controlName = [];
        for (var property in items) {
            var control = $(this).find(lib.getClassInputForm(property));
            var name = control[0].getAttribute('name');
            var type = control[0].getAttribute('type');
            if (type !== 'text') continue;
            if (!controlName.find(x => x === name)) {
                controlName.push(name);
            }
        }
        for (const name of controlName) {
            var controls = $(this).find(lib.getClassInputForm(name));
            var ctlValue = lib.getValueControl(controls);
            if (ctlValue !== undefined) {
                result[name] = (ctlValue + '').trim();
            }
        }
        $(this).pathValue(result);
    },

    pathParamsSelectApi: function (items) {
        for (var property in items) {
            // .attr('data-param', '{"cityId":${regPlaceCityIdReport}}');
            var control = $(this).find('select[name="'+property+'"]');
            if (control.length > 0) {
                $(control).attr('data-param', items[property]);
            }
        }
    },
});

String.prototype.compose = (function () {
    var re = /\{{(.+?)\}}/g;
    return function (o) {
        return this.replace(re, function (_, k) {
            return typeof o[k] != 'undefined' ? o[k] : '';
        });
    };
}());

// init control js
$(document).ready(function () {
    // select2 init
    var selectControl = $(this).find('select');
    $(selectControl).each(function () {
        var item = this;
        var name = item.name;
        var sort = item.getAttribute("sort");
        if (name) {
            var dataUrl = item.getAttribute("data-url");
            var placeholder = item.getAttribute("placeholder");
            var allowClear = item.hasAttribute("allowClear");
            var allowSearch = dataUrl ? null : -1;
            var valueDefault = item.getAttribute("value");
            if (item.hasAttribute("allowSearch")) {
                allowSearch = item.hasAttribute("allowSearch") === 'true' ? null : -1;
            }

            var sourceOptionArray = [];
            var sourceOption = $(item).find('option');
            for (var i = 0; i < sourceOption.length; i++) {
                var text = $(sourceOption[i]).text();
                var value = $(sourceOption[i]).attr('value');
                sourceOptionArray.push({
                    id: value,
                    text
                });
            }
            var itemSizePerPage = 50;
            var divParent = $(item).parents('.form-group').eq(0);
            $(item).select2({
                dropdownParent: divParent,
                language: 'es',
                allowClear: allowClear,
                placeholder: placeholder,
                minimumResultsForSearch: allowSearch,
                language: {
                    noResults: function () {
                        return "Không có dữ liệu được tìm thấy";
                    },
                    searching: function () {
                        return 'Đang tìm kiếm…';
                    },
                    loadingMore: function () {
                        return 'Đang tải thêm dữ liệu…';
                    },
                },
                ajax: !dataUrl ? null : {
                    delay: 350,
                    url: dataUrl,
                    processResults: function (res, params) {
                        params.page = params.page || 1;
                        var options = [];
                        if (params.page === 1) {
                            //nếu là trang 1 add thêm các option có sẵn trên html
                            options = JSON.parse(JSON.stringify(sourceOptionArray.filter(x => x.text.includes(params.term ? params.term : ''))));
                        }
                        var countItem = 0;
                        if(!Array.isArray(res.data)) {
                            for (let key in res.data) {
                                var itemValue = {};
                                itemValue.id = key;
                                itemValue.text = res.data[key];
                                options.push(itemValue);
                                countItem += 1;
                            }
                        } else {
                            for (let key of res.data) {
                                var itemValue = {};
                                itemValue.id = key.value;
                                itemValue.text = key.text;
                                options.push(itemValue);
                                countItem += 1;
                            }
                        }

                        return {
                            results: options,
                            pagination: {
                                more: countItem >= itemSizePerPage
                            }
                        };
                    },
                    data: function (params) {
                        var query = {
                            keySearch: params.term,
                            page: params.page || 1,
                            size: itemSizePerPage
                        };
                        //bo sung them tham so truyen len server json object
                        var paramData = $(item).attr('data-param');
                        if (paramData) {
                            var paramJson = JSON.parse(paramData);
                            for (var key in paramJson) {
                                query[key] = paramJson[key];
                            }
                        }
                        return query;
                    },
                    error: function (jqXHR, exception) {
                        if(jqXHR.responseJSON && jqXHR.status == 400){
                            lib.showMessage(jqXHR.responseJSON.message, 'error');
                        }
                    }
                }
            });
            if (valueDefault) {
                lib.setDefaultValueSelect2(item, valueDefault);
            }
        }

    });
    $(selectControl).on('change', function (e) {
        // Do something
        $(this).parents('.form-group').addClass('active');
    });
    $(selectControl).on('select2:open', function () {
        var control = this;
        var multile = control.hasAttribute('multiple');
        if (!multile) {
            setTimeout(() => {
                $(control).parents('.form-group').eq(0).find('.select2-search__field').focus();
            }, 300);
        }
    });
    // init page
    $('.vnpt-paging[data-count]').paging();
    // init datetime
    $('input[type="date"]').each(function () {
        var control = this;
        $(control).attr('type', 'text');
        $(control).addClass('date');
        $(control).attr('autocomplete', 'off');
        setTimeout(function () {
            $(control).datepicker({
                format: "dd/mm/yyyy",
                language: 'vi',
                autoclose: true,
                showOnFocus: true,
                todayHighlight: true
            });
            $(control).mask('00/00/0000', {
                placeholder: "dd/mm/yyyy"
            });
            var controlValue = $(control).attr('value');
            if (controlValue) {
                setTimeout(function () {
                    lib.setValueControl($(control), controlValue);
                }, 50);
            }
        }, 100);
        $(control).on('change', function () {
            $(control).parents('.form-group').addClass('active');
        });
    });

    //checkbox all
    var isSelectAll = true;
    $(document).on('click', 'input:checkbox[name="selectAllRows"]', function ($event) {
        $('input:checkbox[class="select-row"]').prop('checked', isSelectAll);
        isSelectAll = !isSelectAll;
    });

    $(document).on('click', 'input:checkbox[class="select-all-rows"]', function ($event) {
        var isCheckAll = $(this).is(':checked');
        var childref = $(this).attr("childref");
        $('input:checkbox[ref="' + childref + '"]').prop('checked', isCheckAll);
    });
    $(document).on('click', 'input:checkbox', function ($event) {
        if ($(this).attr('ref')) {
            var childref = $(this).attr('ref');
            if ($('input:checkbox[ref="' + childref + '"]:checked').length === $('td[ref="' + childref + '"]').length) {
                $('input:checkbox[childref="' + childref + '"]').prop('checked', true);
            } else {
                $('input:checkbox[childref="' + childref + '"]').prop('checked', false);
            }
        }
    });
    //tr click select checkbox
    $(document).on('click', '.tr-list', function ($event) {
        if (event.target.type !== 'checkbox') {
            if ($(event.target).attr('class')) {
                if (!($(event.target).attr('class')).includes('vnpt-underline-blue') && !($(event.target).attr('class')).includes('not-click')) {
                    $(':checkbox', this).trigger('click');
                }
            } else {
                $(':checkbox', this).trigger('click');
            }
        }
    });
    // toggle form search
    $(document).on('click', '.expand-collapse-icon', function ($event) {
        if ($event.currentTarget.textContent.trim() === 'ẨN ĐIỀU KIỆN TÌM KIẾM') {
            $($event.currentTarget).html('<i class="fa fa-chevron-circle-down text-primary" aria-hidden="true"></i> HIỆN ĐIỀU KIỆN TÌM KIẾM');
        } else {
            $($event.currentTarget).html('<i class="fa fa-chevron-circle-up text-primary" aria-hidden="true"></i> ẨN ĐIỀU KIỆN TÌM KIẾM');
        }
    });
    // init text mask date
    var typeTmDate = 1;
    var maskOptions = {
        placeholder: "",
        translation: {
            '*': {
                pattern: /[0-9\/]/, optional: true
            }
        },
        onKeyPress: function (cep, e, field, options) {
            var masks = ["99********", "00/0000**", "00/00/0000"];
            var lengh = cep.replace(/[^0-9]/g, "").length;
            var mask = masks[0];
            if (lengh <= 4) {
                if (typeTmDate !== 1) {
                    typeTmDate = 1;
                    mask = masks[0];
                }
            }
            if (lengh > 4 && lengh <= 6) {
                if (typeTmDate !== 2) {
                    typeTmDate = 2;
                    mask = masks[1];
                }
            }
            if (lengh > 6) {
                if (typeTmDate !== 3) {
                    typeTmDate = 3;
                    mask = masks[2];
                }
            }
            $(e.currentTarget).mask(mask, options);
        }
    };
    $(".text-mask-date").mask('99********', maskOptions);
    //
});

//set result Error
function setResultError(result, param, message) {
    result.isValid = false;
    result.errors.push(message);
    result.controlErrors[param] = [{ required: message }];
    result.controlErrors[param].push(message);
    return result;
}
