from jinja2 import Environment, FileSystemLoader

env = Environment(loader=FileSystemLoader([
    'vendor/jinja_idsk_template/views/layouts',
    'templates'
]))
template = env.get_template('test_template.html')
content = template.render({
    "html_lang": "rb",
    "skip_link_message": "Custom skip link text",
    "logo_link_title": "Custom logo link title text",
    "crown_copyright_message": "Custom crown copyright message text",
})

with open("../../html_for_testing/jinja_integration_test_app.html", "w") as static_file:
    static_file.write(content)
