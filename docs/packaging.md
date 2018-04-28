# Packaging

At present this generates 9 output formats:

1. a gem containing a Rails engine
2. a tarball containing Play Framework templates
3. a folder containing Mustache templates
4. a tarball containing Liquid templates
5. a tarball containing Mustache Inheritance templates
6. a tarball containing Jinja templates
7. a tarball containing plain HTML and assets
8. a tarball containing EJS (Embedded JavaScript) templates
9. a JAR file containing assets (but no templates) structured as per [WebJars](https://www.webjars.org/)
10. a tarball containing Django templates

## Gem version

This is available on rubygems.org.  To use it, add this line to your application's Gemfile:

    gem 'idsk_template'

And then execute:

    $ bundle

You can then use the `idsk_template` layout in your app.  If you need to extend the layout you can use [nested layouts](http://guides.rubyonrails.org/layouts_and_rendering.html#using-nested-layouts).

## Play version

To generate the tarball of Play Framework templates run `bundle exec rake build:play`. This will produce a tarball in the `pkg` directory.

## Mustache version

To generate the folder of Mustache templates run `bundle exec rake build:mustache`. This will produce a folder in the `pkg` directory.

## Liquid version

To generate the folder of Liquid templates run `bundle exec rake build:liquid`. This will produce a tarball in the `pkg` directory.

## Mustache Inheritance version

There is a [proposal for Mustache to support template inheritance](https://github.com/mustache/spec/issues/38) this is supported in both the `mustache.java` and the `hogan.js` implementations of Mustache.

To generate the tarball of the Mustache Inheritance templates run the `build:mustache_inheritance` rake task. This will produce a tarball in the `pkg` directory.

## Jinja version

To generate the folder of Jinja templates run `bundle exec rake build:jinja`. This will produce a tarball in the `pkg` directory.

## Tarball version

To generate the tarball, run the `bundle exec rake build:tar`. This will produce a tarball in the `pkg` directory.

## Embedded JavaScript version

To generate the folder of Embedded JavaScript templates run `bundle exec rake build:ejs`. This will produce a tarball in the `pkg` directory.

## WebJar version

To generate a JAR file of assets in WebJar format run `bundle exec rake build:webjar`. This will produce a JAR file in the `pkg` directory.

## Django version

To generate the folder of Django templates run `bundle exec rake build:django`. This will produce a tarball in the `pkg` directory.
