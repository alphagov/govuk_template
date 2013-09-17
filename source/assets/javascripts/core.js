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

  if (window.GOVUK && GOVUK.addCookieMessage) {
    GOVUK.addCookieMessage();
  }
});
