// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require underscore
//= require icanhaz-0.10
//= require jquery
//= require jquery_ujs
//= require gmaps

//= require_tree ./views
//= require_tree ./controllers


// Setting up contextual help
$(document).ready(function() {
  init_help();
  init_fancybox();
});

function init_help() {
  $(".help").click(function(e) {
    $(".help-pop").remove();
    $("body").append("<div class='help-pop'><div class='help-title'></div><div class='help-contents'><p>" + $(this).attr("title") + "</p></div>");
    e.preventDefault();
  });
  $(".help-pop").live("click", function() {
    $(this).remove();
  });
}

function init_fancybox() {
  $('.fancybox-media').fancybox({
      openEffect  : 'none',
      closeEffect : 'none',
      helpers : {
          overlay : null,
          media : {}
      }
  });
}
