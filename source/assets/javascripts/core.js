(function() {
  "use strict"

  // fix for printing bug in Windows Safari
  var windowsSafari = (window.navigator.userAgent.match(/(\(Windows[\s\w\.]+\))[\/\(\s\w\.\,\)]+(Version\/[\d\.]+)\s(Safari\/[\d\.]+)/) !== null),
      style;

  if (windowsSafari) {
    // set the New Transport font to Arial for printing
    style = document.createElement('style');
    style.setAttribute('type', 'text/css');
    style.setAttribute('media', 'print');
    style.innerHTML = '@font-face { font-family: nta !important; src: local("Arial") !important; }';
    document.getElementsByTagName('head')[0].appendChild(style);
  }


  // add cookie message
  if (window.GOVUK && GOVUK.addCookieMessage) {
    GOVUK.addCookieMessage();
  }

  // header navigation toggle
  if (document.querySelectorAll){
    var els = document.querySelectorAll('.js-header-toggle'),
        i, _i;
    for(i=0,_i=els.length; i<_i; i++){
      els[i].addEventListener('click', function(e){
        e.preventDefault();
        var target = document.getElementById(this.getAttribute('href').substr(1)),
            targetClass = target.getAttribute('class') || '',
            sourceClass = this.getAttribute('class') || '';

        if(targetClass.indexOf('js-visible') !== -1){
          target.setAttribute('class', targetClass.replace(/(^|\s)js-visible(\s|$)/, ''));
        } else {
          target.setAttribute('class', targetClass + " js-visible");
        }
        if(sourceClass.indexOf('js-hidden') !== -1){
          this.setAttribute('class', sourceClass.replace(/(^|\s)js-hidden(\s|$)/, ''));
        } else {
          this.setAttribute('class', sourceClass + " js-hidden");
        }
      });
    }
  }
}).call(this);
