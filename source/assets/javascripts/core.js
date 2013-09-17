if (typeof window.GOVUK === 'undefined') {
  window.GOVUK = {};
}
/*
  Cookie methods
  ==============

  Usage: 

    Setting a cookie:
    GOVUK.cookie('hobnob', 'tasty', { days: 30 });
    
    Reading a cookie:
    GOVUK.cookie('hobnob');
    
    Deleting a cookie:
    GOVUK.cookie('hobnob', null);
*/   
GOVUK.cookie = function (name, value, options) {
  if(typeof value !== 'undefined'){
    if(value === false || value === null) {
      return GOVUK.setCookie(name, '', { days: -1 });
    } else {
      return GOVUK.setCookie(name, value, options);
    }
  } else {
    return GOVUK.getCookie(name);
  }
};
GOVUK.setCookie: function (name, value, options) {
  if(typeof options === 'undefined') {
    options = {};
  }
  var cookieString = name + "=" + value + "; path=/";
  if (options.days) {
    var date = new Date();
    date.setTime(date.getTime() + (options.days * 24 * 60 * 60 * 1000));
    cookieString = cookieString + "; expires=" + date.toGMTString();
  }
  if (document.location.protocol == 'https:'){
    cookieString = cookieString + "; Secure";
  }
  document.cookie = cookieString;
};
GOVUK.getCookie = function (name) {
  var nameEQ = name + "=";
  var cookies = document.cookie.split(';');
  for(var i = 0, len = cookies.length; i < len; i++) {
    var cookie = cookies[i];
    while (cookie.charAt(0) == ' ') {
      cookie = cookie.substring(1, cookie.length);
    }
    if (cookie.indexOf(nameEQ) === 0) {
      return decodeURIComponent(cookie.substring(nameEQ.length));
    }
  }
  return null;
};

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
  }
});


