// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require bootstrap
//= require_tree .


function close_side_bar() {
    $(".side-bar-menu").css("margin-left", "-70%");
    $(".side-bar").addClass("hidden");
    $("body").removeClass("postition-fixed");
}

$(function() {

    $(document).on("click", "#menu-btn", function() {
        $(".side-bar").removeClass("hidden");
        $(".side-bar-menu").css("margin-left", "0%");
        $("body").addClass("postition-fixed");
    });

    $(document).on("click", ".side-bar", function() {
     $("body").removeClass("postition-fixed");
    })


    $(document).on("click", "#home-btn", function() {
        redirect_home();
    });

    var user_agent = navigator.userAgent.toLowerCase(); // detect the user agent
    var ios_devices = user_agent.match(/(iphone|ipod|ipad)/) ? "touchstart" : "click"; //check if the devices are ios devices

    $(".side-bar").bind(ios_devices, function(e) { //bind the ios devices to click event
        if ($(e.target)[0] == $(this)[0]) {
            close_side_bar();
        }
    });

    $(document).on("click touchstart", ".side-bar", function(e) {
        if ($(e.target)[0] == $(this)[0]) {
            close_side_bar();
        }
    });

    $(document).on("change", ".file", function(event) {
		    var preview = $(".upload-preview img");
		    var input = $(event.currentTarget);
		    var file = input[0].files[0];
		    var reader = new FileReader();
	    reader.onload = function(e){
	      image_base64 = e.target.result;
	      preview.attr("src", image_base64);
	    };

	    if (file==undefined || file.length<0){
	      $(".upload-preview img").hide();
	      return false;
	    } else{
	      reader.readAsDataURL(file);
	      $(".upload-preview img").show();
	    }
	  });

    $(document).on("click", ".file", function() {
      $('body').find('.profile-image-show').addClass('profile-image-circule');
    })
	  // Menu full button clickable    
    $('.home_menu').click(function() {
      var href = $(this).find("a").attr("href");
      if(href) {
        window.location = href;
      }
    });
});

