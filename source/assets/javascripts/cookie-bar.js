(function () {
  'use strict'
  var root = this
  if (typeof root.GOVUK === 'undefined') { root.GOVUK = {} }

  GOVUK.addCookieMessage = function () {
    var message = document.getElementById('global-cookie-message')

    var hasCookieMessage = (message && GOVUK.cookie('seen_cookie_message') === null)

    if (hasCookieMessage) {
      message.style.display = 'block'
      GOVUK.cookie('seen_cookie_message', 'yes', { days: 28 })

      document.addEventListener('DOMContentLoaded', function (event) {
        if (GOVUK.analytics && typeof GOVUK.analytics.trackEvent === 'function') {
          GOVUK.analytics.trackEvent('cookieBanner', 'Cookie banner shown', {
            value: 1,
            nonInteraction: true
          })
        }
      })
    };
  }
}).call(this)
