var nunjucks = require('nunjucks'),
    fs = require('fs'),
    path = require('path'),
    env;

env = new nunjucks.Environment(new nunjucks.FileSystemLoader([
  path.normalize(__dirname + '/templates/'),
  path.normalize(__dirname + '/vendor/jinja_idsk_template/views/layouts/')
]));

fs.writeFileSync(
  path.normalize(__dirname + '/../../html_for_testing/nunchucks_integration_test_app.html'),
  env.render('test_template.html', {
      'html_lang': 'rb',
      'skip_link_message': 'Custom skip link text',
      'logo_link_title': 'Custom logo link title text',
      'crown_copyright_message': 'Custom crown copyright message text',
  }),
  { encoding : 'utf-8' }
);
