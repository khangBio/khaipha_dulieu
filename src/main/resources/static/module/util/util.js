
(function ($) {
	
    var namespace;

    namespace = {
        showMes: function showMes(id, mes, focus) {
            var openMes = "<div class=\"row\">" +
                "	<div class=\"col-sm-12\"> 		" +
                " 		<div class=\"alert  alert-success alert-dismissible fade show\" role=\"alert\">	" +
                " 			<span class=\"badge badge-pill badge-success\">Thông báo</span>	";

            var closeMes = "<button type=\"button\" class=\"close\" data-dismiss=\"alert\" aria-label=\"Close\">	" +
                " 				<span aria-hidden=\"true\">×</span>	" +
                " 			</button>	" +
                " 		</div> " +
                " 	</div>	" +
                "</div>		";

            $("#" + id).html(openMes + mes + closeMes);
            $("#" + focus).focus();
            document.body.scrollTop = 0; // For Safari
            document.documentElement.scrollTop = 0; // For Chrome, Firefox, IE and Opera
        },

        showMsgPopup: function showMsgPopup(id, res) {
            if (res.result == 'Error') {
                var openMes = "<div class=\"row\">" +
                    "	<div class=\"col-sm-12\"> 		" +
                    " 		<div class=\"alert  alert-danger alert-dismissible fade show\" role=\"alert\">	";

                var closeMes = "</div> " +
                    " 	</div>	" +
                    "</div>		";

                $("#" + id).html(openMes + res.msg + closeMes);
            } else {
                var openMes = "<div class=\"row\">" +
                    "	<div class=\"col-sm-12\"> 		" +
                    " 		<div class=\"alert  alert-success alert-dismissible fade show\" role=\"alert\">	";

                var closeMes = "</div> " +
                    " 	</div>	" +
                    "</div>		";

                $("#" + id).html(openMes + res.msg + closeMes);
            }

            $('#mess_pop').modal('show');
        }
    };

    window.ns = namespace;
})(jQuery);