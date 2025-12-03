(function ($) {
	$(document).ready(function() { 
		
    } );
	  
	$('.table-datatable').DataTable( { 
		"dom": 'rt<"bottom"<"pull-left"l><"pull-right"p>>', 
		"pagingType": "full_numbers",
		"searching": false,
		"info":     false,
		"columnDefs": [{ targets: 'no-sort', orderable: false }],
    	lengthMenu: [[10, 20, 30], [10, 20, 30]],
        "language": {
        	"processing":   "\u0110ang x\u1eed l\u00fd...",
        	"search":       "T\u00ecm ki\u1ebfm:",
            "lengthMenu": "Hi\u1ec3n th\u1ecb _MENU_ d\u00f2ng m\u1ed9t trang",
            "zeroRecords": "Kh\u00f4ng t\u00ecm \u0111\u01b0\u1ee3c d\u1eef li\u1ec7u ph\u00f9 h\u1ee3p",
            "info": "Hi\u1ec3n th\u1ecb trang _PAGE_ / _PAGES_",
            "infoEmpty": "Kh\u00f4ng t\u00ecm \u0111\u01b0\u1ee3c d\u1eef li\u1ec7u ph\u00f9 h\u1ee3p",
            "infoFiltered": "(\u0110\u00e3 l\u1ecdc tr\u00ean t\u1ed5ng s\u1ed1 _MAX_ d\u00f2ng)",
            "paginate": {
                "sFirst":    "\u0110\u1ea7u",
                "sPrevious": "Tr\u01b0\u1edbc",
                "sNext":     "Ti\u1ebfp",
                "sLast":     "Cu\u1ed1i"
            }
        }
    } );
	
//	$('#row-select').DataTable( {
//        initComplete: function () {
//				this.api().columns().every( function () {
//					var column = this;
//					var select = $('<select class="form-control"><option value=""></option></select>')
//						.appendTo( $(column.footer()).empty() )
//						.on( 'change', function () {
//							var val = $.fn.dataTable.util.escapeRegex(
//								$(this).val()
//							);
//
//							column
//								.search( val ? '^'+val+'$' : '', true, false )
//								.draw();
//						} );
//
//					column.data().unique().sort().each( function ( d, j ) {
//						select.append( '<option value="'+d+'">'+d+'</option>' )
//					} );
//				} );
//			}
//		} );

})(jQuery);
