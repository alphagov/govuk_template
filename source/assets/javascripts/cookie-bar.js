(function () {
  'use strict'
  var root = this
  if (typeof root.GOVUK === 'undefined') { root.GOVUK = {} }

  GOVUK.addCookieMessage = function () {
    var message = document.getElementById('global-cookie-message')

    var hasCookieMessage = (message && GOVUK.cookie('seen_cookie_message') !== 'true')

    if (hasCookieMessage) {
      message.style.display = 'block'

      var hideAnchors = document.querySelectorAll('a[data-hide]')
      hideAnchors.forEach(function (hideAnchor) {
        hideAnchor.addEventListener('click', function (event) {
          GOVUK.hideCookieMessage()

          var target = event.target
          if (target && target.getAttribute('href') === 'global-cookie-message') {
            event.preventDefault()
          }
        })
      })
    }
  }

  GOVUK.hideCookieMessage = function () {
    var message = document.getElementById('global-cookie-message')

    if (message) {
      message.style.display = 'none'
      GOVUK.cookie('seen_cookie_message', 'true')
    }
  }
}).call(this)
