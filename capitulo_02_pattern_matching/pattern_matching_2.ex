

#[a,b,a] = [1,2,3] # ** (MatchError) no match of right hand side value: [1, 2, 3]

#[a,b,a] = [1,1,2] # (MatchError) no match of right hand side value: [1, 1, 2]

[a,b,a] = [1,2,1]
IO.inspect a #1
IO.inspect b #2



