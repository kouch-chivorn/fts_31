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
//= require jquery.countdown
//= require jquery.countdown-es
//= require_tree .

function remove_fields(link) {
  $(link).prev("input[type=hidden]").val("1");
  $(link).closest(".fields").hide();
}

function add_fields(link, association, content) {
  var new_id = new Date().getTime();
  var regexp = new RegExp("new_" + association, "g");
  $(link).parent().before(content.replace(regexp, new_id));
}

function ready(){
  $(".checkbox").on("change",function(){
    $(".checkbox").not(this).prop("checked", false)
  });

  $("#countdown").countdown({
    until: parseInt($("#duration").val()),
    format: "HMS",
    labels: ["Years", "Months", "weeks", "Days", "Hours", "Minutes", "Seconds"],
    onExpiry: function(){
      alert("Your exam is time out we are going to submit your test automaticaly");
      $("#submit_test_questions").trigger("click");
      $("#submit_test_questions").hidden();
    }
  });

  var d = new Date();
  d = d.getTime();
  if (jQuery("#reloadValue").val().length == 0)
  {
    jQuery("#reloadValue").val(d);
    jQuery("body").show();
  }
  else
  {
    jQuery("#reloadValue").val("Testing");
    location.reload();
  }
}


//$(document).ready(ready);
$(document).on("page:load", ready);
$(document).on("page:update", ready);
