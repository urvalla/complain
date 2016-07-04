require "complain/version"

# One-liner exception process
#
#   # replace
#   rescue => exc
#     $stderr.puts exc.message
#     $stderr.puts exc.backtrace
#   end
#   # with
#   rescue => exc
#     Complain.(exc)
#   end
#
module Complain
  # Calls exception writer
  # @param [Exception] exc Exception to write.
  # @param [Mixed] logger Logger - can be `:stderr`, `:stdout` or should respond to `error` or `puts`
  # @option [Boolean] :skip_exc - By default (false) internal exceptions will be rescued and written to logger,
  #                   and exception will be raised only if second writing is failed;
  #                   when set to true exception will not be handled.
  def self.call(exc, logger = :stderr, skip_exc: false)
    message = if exc.is_a?(Exception)
                [exc.message, exc.backtrace.join("\n")].join("\n")
              elsif exc.is_a?(String)
                exc
              elsif exc.respond_to?(:to_s)
                exc.to_s
              elsif exc.respond_to?(:inspect)
                exc.inspect
              else
                "Message can't be processed at #{caller.join("\n")}"
              end

    if logger.nil? || :stderr == logger
      $stderr.puts message
    elsif :stdout == logger
      $stdout.puts message
    elsif :exception == logger
      skip_exc = true
      raise exc
    elsif logger.respond_to?(:error)
      logger.error message
    elsif logger.respond_to?(:puts)
      logger.puts message
    else
      skip_exc = true
      Complain.("Can't write to logs:\n" + message, :exception, skip_exc: true)
    end
  rescue => exc
    if skip_exc
      raise exc
    else
      Complain.(exc, skip_exc: true)
    end
  end
end
