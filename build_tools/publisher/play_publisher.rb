require 'govuk_template/version'

module Publisher 
  class PlayPublisher

    def publish
      puts "Releasing play_govuk_template"
      system "git clone -q git@github.com:alphagov/govuk_template_play.git"
      system "ls -1 | grep -v 'README.md' | xargs -I {} rm -rf {}"
      
      system "tar -xf pkg/play_govuk_template-#{GovukTemplate::VERSION}.tgz"
      system "cp -r play_govuk_template-#{GovukTemplate::VERSION}/ govuk_template_play"
      system "rm -rf play_govuk_template-#{GovukTemplate::VERSION}"

      system "cd govuk_template_play; git add -A ."
      system "cd govuk_template_play; git commit -q -m 'deploying Govuk Play templates #{GovukTemplate::VERSION}'"
      system "cd govuk_template_play; git tag -af v#{GovukTemplate::VERSION} -m 'deploying #{GovukTemplate::VERSION}'"

      system "cd govuk_template_play; git push origin master; git push --tags origin master"
      puts "Cleaning up"
      system "rm -rf govuk_template_play"
    end

    def version_released? 
      system "git ls-remote --tags git@github.com:alphagov/govuk_template_play.git | grep -o #{GovukTemplate::VERSION}"
    end

  end
end