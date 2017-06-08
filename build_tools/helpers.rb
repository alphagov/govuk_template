module Helpers
  def run(command, custom_error=nil)
    output, status = Open3.capture2e(command)
    unless status.success?
      if custom_error
        error_message = "Error: '#{custom_error}': exit #{status.exitstatus}"
      else
        error_message = "Error running #{command}: exit #{status.exitstatus}\n#{output}"
      end
      abort error_message
    end
    output
  end
end
