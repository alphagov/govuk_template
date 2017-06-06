module Helpers
  def version_released?
    output = run("git ls-remote --tags #{GIT_URL.shellescape}")
    return !! output.match(/v#{@version}/)
  end

  def run(command)
    output, status = Open3.capture2e(command)
    abort "Error running #{command}: exit #{status.exitstatus}\n#{output}" if status.exitstatus > 0
    output
  end 
end
