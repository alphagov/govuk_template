require 'govuk_template/version'

module Publisher 
	class PlayPublisher

    def self.publish
      new.publish
    end

		def publish
			puts "Releasing play_govuk_template"
			system "git clone -q git@github.com:michaeldfallen/govuk_template_play.git"
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
	end
end