
module Convert

  def escape_letter(str)

    for i in 0..str.length
      case str[i]
      when '&' then
        str[i] = '%26'
      when '<' then
        str[i] = '%3C'
      when '>' then
        str[i] = '%3E'
      when '"' then
        str[i] = '%22'
      when '+' then
        str[i] = '%2B'
      else
      end
    end

    return str
  end
  
  module_function :escape_letter
end
