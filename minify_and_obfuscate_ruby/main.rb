class MinifyAndObfuscateRuby
	def initialize(shell_script="./main.sh")
    @shell_script = shell_script
    run_shell_script
  end

  private

  def run_shell_script
  	%x[sh #{@shell_script}]
  end
end

MinifyAndObfuscateRuby.new


