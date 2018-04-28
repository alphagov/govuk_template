import django
from django.conf import settings
from django.template.loader import render_to_string

settings.configure(
    TEMPLATES=[{
        "BACKEND": "django.template.backends.django.DjangoTemplates",
        "DIRS": ["vendor/django_idsk_template/idsk_template/templates", "templates"],
    }],
    INSTALLED_APPS=["django.contrib.staticfiles"],
    STATIC_URL="/static/"
)

django.setup()

context = {
    "html_lang": "rb",
    "skip_link_message": "Custom skip link text",
    "logo_link_title": "Custom logo link title text",
    "crown_copyright_message": "Custom crown copyright message text",
}

content = render_to_string("test_template.html", context)

with open("../../html_for_testing/django_integration_test_app.html", "w") as static_file:
    static_file.write(content)
