(function() {
  if (navigator.userAgent.match(/IEMobile\/10\.0/)) {
    var d = document,
        c = "appendChild",
        a = d.createElement("style");
    a[c](d.createTextNode("@-ms-viewport{width:auto!important}"));
    d.getElementsByTagName("head")[0][c](a);
  }
})();
