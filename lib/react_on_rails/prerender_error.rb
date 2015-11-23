puts "ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ"
puts "prerender_error.rb: #{__LINE__},  method: #{__method__}"
puts "loaded!"
puts "ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ"

module ReactOnRails
  class PrerenderError < RuntimeError
    # err might be nil if JS caught the error
    def initialize(component_name: nil, err: nil, props: nil,
      js_code: nil, console_messages: nil, router_script: nil)
      puts "ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ"
      method_params = method(__method__).parameters.map(&:last)
      method_opts = method_params.map { |p| [p, eval(p.to_s)] }.to_h
      puts "CALLED #{__method__} with params: #{method_opts.ai}"
      puts "ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ"

      message = "ERROR in SERVER PRERENDERING"
      if err
        message << <<-MSG
Encountered error: \"#{err}\"
        MSG
        backtrace = err.backtrace.join("\n")
      else
        backtrace = nil
      end
      message << <<-MSG
when prerendering #{component_name} with props: #{props}
js_code was:
#{js_code}
      MSG

      if console_messages
        message << <<-MSG
console messages:
#{console_messages}
        MSG
      end

      if router_script
        message << <<-MSG
router script:
#{router_script}
        MSG
      end

      super([message, backtrace].compact.join("\n"))
    end
  end
end
