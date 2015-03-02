namespace :build do
  desc "Build GovUK.Template.Razor.#{GovukTemplate::VERSION}.nupkg into the pkg directory"
  task :razor => :compile do
    puts "Building pkg/GovUK.Template.Razor.#{GovukTemplate::VERSION}.nupkg"
    require 'packager/razor_packager'
    Packager::RazorPackager.build
  end
end
