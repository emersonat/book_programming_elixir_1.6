
a = ["1","2","3"]
IO.inspect a # ["1","2","3"]

a = 4
IO.inspect a # 4

# [a,b] = [1,2,3] # (MatchError) no match of right hand side value: [1, 2, 3]

[a] = [ [1,2,3] ]
IO.inspect a #[1,2,3]

#[ [a] ] = [ [1,2,3] ] # no match of right hand side value: [[1, 2, 3]]



