

prefix = fn prefix ->
  fn nome ->
    "#{prefix} #{nome}"
  end
end


iex> sr = prefix.("Mr")
iex> sr = sr.("emerson")
iex> prefix.("Sr").("emerson")


