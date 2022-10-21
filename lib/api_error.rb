class ApiError
  JWT = 0

  def initialize(code)
    @code = code
  end

  def messages
    case @code
    when HELPER
      return "Helper Error"
    else
      return %Q{ Unknown Error }
    end
  end
end