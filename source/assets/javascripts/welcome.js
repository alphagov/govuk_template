$(function() {
  if (typeof window.GOVUK === 'undefined') {
    window.GOVUK = {};
  }

  GOVUK.addCookieMessage = function () {
    var $message = $('#global-cookie-message'),
        hasCookieMessage = ($message.length && getCookie('seen_cookie_message') === null);

    if (hasCookieMessage) {
      $message.show();
      setCookie('seen_cookie_message', 'yes', 28);
    }
  };
});
