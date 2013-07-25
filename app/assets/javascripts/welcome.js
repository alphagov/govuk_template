$(function() {
  if (typeof window.GOVUK === 'undefined') {
    window.GOVUK = {};
  }

  GOVUK.addCookieMessage = function () {
    var addStyle,
        $message = $('#global-cookie-message'),
        $relatedColumn = $('#wrapper .related-positioning'),
        hasCookieMessage = ($message.length && getCookie('seen_cookie_message') === null),
        release = ($('.beta-notice').length) ? 'beta' : null;
        addRelatedClass;

    function addRelatedClass() {
      var relatedClass = release ? 'related-' + release : 'related';

      if (hasCookieMessage) {
        // correct the related module top position to consider the cookie bar
        relatedClass = relatedClass + '-with-cookie';
      }

      if ($relatedColumn.length && (relatedClass !== 'related')) {
        $relatedColumn.addClass(relatedClass);
      }
    };

    if (hasCookieMessage) {
      if ($relatedColumn.length) {
        // related content box needs to know the top position of the footer
        // this changes when content is split into tabs
        if (typeof GOVUK.stopScrollingAtFooter !== 'undefined') {
          GOVUK.stopScrollingAtFooter.updateFooterTop();
        }
      }
      $message.show();
      setCookie('seen_cookie_message', 'yes', 28);
    }

    addRelatedClass();
  };
});
