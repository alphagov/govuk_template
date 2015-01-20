(function() {
  if (window.opera) {
    return;
  }

  setTimeout(function() {
    var a = document,
        g, b = {
          families: (g=["nta"]),
          urls: ["<%= asset_path "fonts-ie8.css" %>"]
        },
        c = "<%= asset_path "vendor/goog/webfont-debug.js" %>",
        d = "script",
        e = a.createElement(d),
        f = a.getElementsByTagName(d)[0],
        h = g.length;

    WebFontConfig = {
      custom: b
    },
    e.src = c,
    f.parentNode.insertBefore(e,f);
    for (; h = h-1; a.documentElement.className+=' wf-'+g[h].replace(/\s/g,'').toLowerCase()+'-n4-loading');
  }, 0)

})()
