

iex> func = fn
  0,0,_ -> "FizzBuzz"
  0,_,_ -> "Fizz"
  _,0,_ -> "Buzz"
  _,_,a -> a
end


iex> func2 = fn n ->
  func.(rem(n,3),rem(n,5),n)
end

iex> [func2.(10), func2.(11), func2.(12), func2.(13), func2.(14), func2.(15), func2.(16) ]




