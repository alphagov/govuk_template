//Reusable functions
var Alphagov = {
  daysInMsec: function(d) {
    return d * 24 * 60 * 60 * 1000;
  },
  cookie_domain: function() {
    var host_parts = document.location.host.split(':')[0].split('.').slice(-3);
    return '.' + host_parts.join('.');
  },
  read_cookie: function(name) {
    var cookieValue = null;
    if (document.cookie && document.cookie !== '') {
      var cookies = document.cookie.split(';');
      for (var i = 0; i < cookies.length; i++) {
        var cookie = jQuery.trim(cookies[i]);
        if (cookie.substring(0, name.length + 1) == (name + '=')) {
          cookieValue = decodeURIComponent(cookie.substring(name.length + 1));
          break;
        }
      }
    }
    return cookieValue;
  },
  delete_cookie: function(name) {
    if (document.cookie && document.cookie !== '') {
      var date = new Date();
      date.setTime(date.getTime() - Alphagov.daysInMsec(1)); // 1 day ago
      document.cookie = name + "=; expires=" + date.toGMTString() + "; domain=" + Alphagov.cookie_domain() + "; path=/";
    }
  },
  write_cookie: function(name, value) {
    var date = new Date();
    date.setTime(date.getTime() + Alphagov.daysInMsec(4 * 30)); // 4 nominal 30-day months in the future
    document.cookie = name + "=" + encodeURIComponent(value) + "; expires=" + date.toGMTString() + "; domain=" + Alphagov.cookie_domain() + "; path=/";
  }
};

function recordOutboundLink(e) {
  _gat._getTrackerByName()._trackEvent(this.href, 'Outbound Links');
  setTimeout('document.location = "' + this.href + '"', 100);
  return false;
}

var ReportAProblem = {
  handleErrorInSubmission: function (jqXHR) {
    var response = $.parseJSON(jqXHR.responseText);
    if (response.message !== '') {
      $('.report-a-problem-container').html(response.message);
    }
  },

  submit: function() {
    $('.report-a-problem-container .error-notification').remove();

    var submitButton = $(this).find('.button');
    submitButton.attr("disabled", true);
    $.ajax({
      type: "POST",
      url: "/feedback",
      dataType: "json",
      data: $('.report-a-problem-container form').serialize(),
      success: function(data) {
        $('.report-a-problem-container').html(data.message);
      },
      error: function(jqXHR) {
        if (jqXHR.status == 422) {
          submitButton.attr("disabled", false);
          $('<p class="error-notification">Please enter details of what you were doing.</p>').insertAfter('.report-a-problem-container p:first-child');
        } else {
          ReportAProblem.handleErrorInSubmission(jqXHR);
        }
      },
      statusCode: {
        500: ReportAProblem.handleErrorInSubmission
      }
    });
    return false;
  }
}

$(document).ready(function() {
  $('.print-link a').attr('target', '_blank');

  // header search toggle
  $('.js-header-toggle').on('click', function(e) {
    e.preventDefault();
    $($(e.target).attr('href')).toggleClass('js-visible');
    $(this).toggleClass('js-hidden');
  });

  var $searchFocus = $('.js-search-focus');
  $searchFocus.each(function(i, el){
    if($(el).val() !== ''){
      $(el).addClass('focus');
    }
  });
  $searchFocus.on('focus', function(e){
    $(e.target).addClass('focus');
  });
  $searchFocus.on('blur', function(e){
    if($(e.target).val() === ''){
      $(e.target).removeClass('focus');
    }
  });

  $("nav").delegate('a', 'click', function(){
    var hash;
    var href = $(this).attr('href');
    if(href.charAt(0) === '#'){
      hash = href;
    }
    else if(href.indexOf("#") > 0){
      hash = "#" + href.split("#")[1];
    }
    if($(hash).length == 1){
      $("html, body").animate({scrollTop: $(hash).offset().top - $("#global-header").height()},10);
    }
  });

  // toggle for reporting a problem (on all content pages)
  $('.report-a-problem-toggle a').on('click', function() {
    $('.report-a-problem-container').toggle();
      return false;
  });

  // form submission for reporting a problem
  var $forms = $('.report-a-problem-container form, .report-a-problem form');
  $forms.append('<input type="hidden" name="javascript_enabled" value="true"/>');
  $forms.append($('<input type="hidden" name="referrer">').val(document.referrer || "unknown"));

  $('.report-a-problem-container form').submit(ReportAProblem.submit);

  // hover, active and focus states for buttons in IE<8
  if ($.browser.msie && $.browser.version < 8) {
    $('.button').not('a')
      .on('click focus', function (e) {
        $(this).addClass('button-active');
      })
      .on('blur', function (e) {
        $(this).removeClass('button-active');
      });

    $('.button')
      .on('mouseover', function (e) {
        $(this).addClass('button-hover');
      })
      .on('mouseout', function (e) {
        $(this).removeClass('button-hover');
      });
  }

  // fix for printing bug in Windows Safari
  (function () {
    var windows_safari = (window.navigator.userAgent.match(/(\(Windows[\s\w\.]+\))[\/\(\s\w\.\,\)]+(Version\/[\d\.]+)\s(Safari\/[\d\.]+)/) !== null),
        $new_styles;

    if (windows_safari) {
      // set the New Transport font to Arial for printing
      $new_styles = $("<style type='text/css' media='print'>" +
                      "@font-face {" +
                      "font-family: nta !important;" +
                      "src: local('Arial') !important;" +
                      "}" +
                      "</style>");
      document.getElementsByTagName('head')[0].appendChild($new_styles[0]);
    }
  }());

  if (window.GOVUK) {
    if (GOVUK.addCookieMessage) {
      GOVUK.addCookieMessage();
    }

    if (GOVUK.userSatisfaction){
      var currentURL = window.location.pathname;

      function stringContains(str, substr) {
        return str.indexOf(substr) > -1;
      }

      // We don't want the satisfaction survey appearing for users who
      // have completed a transaction as they may complete the survey with
      // the department's transaction in mind as opposed to the GOV.UK content.
      if (!stringContains(currentURL, "/done") &&
          !stringContains(currentURL, "/transaction-finished") &&
          !stringContains(currentURL, "/driving-transaction-finished")) {
        GOVUK.userSatisfaction.randomlyShowSurveyBar();
      }
    }
  }
});


