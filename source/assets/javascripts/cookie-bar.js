(function () {
  "use strict"
  var root = this;
  if(typeof root.GOVUK === 'undefined') { root.GOVUK = {}; }

  GOVUK.addCookieMessage = function () {
    var message = document.getElementById('global-cookie-message'),
        hasCookieMessage = (message && GOVUK.cookie('seen_cookie_message') !== 'true');

    if (hasCookieMessage) {
      message.style.display = 'block';

      var hideAnchor = document.querySelector("a[data-hide]")
      if(hideAnchor) {
        hideAnchor.addEventListener("click", function(event) {
          event.preventDefault()
          GOVUK.hideCookieMessage()
        })
      }
    }
  };

  GOVUK.hideCookieMessage = function () {
    var message = document.getElementById('global-cookie-message')

    if (message) {
      message.style.display = 'none';
      GOVUK.cookie('seen_cookie_message', 'true');
    }

  };
}).call(this);
