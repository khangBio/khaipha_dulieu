var expandMenu;
(function ($) {
    "use strict";
    if ($('.scroll-top').length) {
        var scrollTrigger = 100, // px
            backToTop = function () {
                var scrollTop = $(window).scrollTop();
                if (scrollTop > scrollTrigger) {
                    $('.scroll-top').addClass('show');

                } else {
                    $('.scroll-top').removeClass('show');
                }
            };
        backToTop();
        $(window).on('scroll', function () {
            backToTop();
        });
        $('.scroll-top').on('click', function (e) {
            e.preventDefault();
            $('html,body').animate({
                scrollTop: 0
            }, 700);
        });
    }

    $(document).on('click', '.menus a', function (e) {
        var parent = $(this).parent();
        if (parent.find("ul").length) {
            e.preventDefault();
            parent.siblings().removeClass("open");
            if (parent.hasClass("open")) {
                parent.removeClass("open");

            } else {
                parent.addClass("open");
            }
        }
    })

    $(".header .nav-icon").click(function () {
        var width = $(window).width();
        if (width <= 768) {
            $(".overlay-common").addClass("show");
        }
        $("body").toggleClass("minimize-menu");

    });
    $(".overlay-common").click(function () {
        $("body").removeClass("minimize-menu");
    });
    $(".overlay-common").click(function () {
        $(".header .menus").removeClass("open");
        $(".nav-toggle").removeClass("active");
        $(this).removeClass("show");
    });

    $(".toolbar-setting .nav-icon").click(function () {
        if ($(this).hasClass("active")) {
            $(this).removeClass("active");
            $(this).parent().removeClass("open");
            $(this).find(".fa").addClass("fa-spin");
        } else {
            $(this).addClass("active");
            $(this).parent().addClass("open");
            $(this).find(".fa").removeClass("fa-spin");
        }
    });


})(jQuery);
$(document).ready(function () {
    if ($('[data-tooltip="true"]').length) {
        $('[data-tooltip="true"]').tooltip();
    }

    $(".form-label-top .form-control").each(function () {
        if ($(this).val() == null || $(this).val() == "") {
            $(this).parents(".form-label-top").removeClass("active");
        } else {
            $(this).parents(".form-label-top").addClass("active");
        }
    });

    $('.form-label-top').on('change','.form-control', function(){
        if ($(this).val() === null || $(this).val() === "") {
            if (!this.hasAttribute('disabled')) {
                $(this).parents('.form-group').removeClass('active');
            }
        } else {
            $(this).parents(".form-label-top").addClass("active");
        }
    })

    // $(".form-label-top").click(function(){
    //     $(this).find(".form-control").focus();
    //     $(this).addClass("focus");
    // });
    // $(".form-label-top .form-control").focusout(function(){
    //      if($(this).val()==null || $(this).val()==""){
    //         $(this).parents(".form-label-top").removeClass("active focus");
    //     }else{
    //         $(this).parents(".form-label-top").addClass("active").removeClass("focus");
    //     }
    // });

    // $(".form-label-top .form-control").focus(function(){
    //     $(this).parents(".form-label-top").addClass("focus");
    // });

    $('.upload input[type=file]').change(function () {
        var pathArray = $(this).val().split('\\');
        if (pathArray.length > 0) {
            $(this).parent().find(">.txt").text(pathArray[pathArray.length - 1]);
            $(this).parent().find(">.btn .fa").removeClass("fa-cloud-upload").addClass("fa-refresh");
            $(this).parent().find(">.btn .txt").text("Tải lại tệp");
        }
    });
});

$(document).on('hidden.bs.modal', function (event) {
    if ($('.modal:visible').length > 0) {
        $('body').addClass('modal-open');
    }
});

// function auto_grow(element) {
//     element.style.height = "5px";
//     element.style.height = (element.scrollHeight)+"px";
// }



