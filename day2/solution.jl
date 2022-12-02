rules_1 = Dict(
    "A X" => 4,
    "A Y" => 8,
    "A Z" => 3,
    "B X" => 1,
    "B Y" => 5,
    "B Z" => 9,
    "C X" => 7,
    "C Y" => 2,
    "C Z" => 6
)

rules_2 = Dict(
    "A X" => 3,
    "A Y" => 4,
    "A Z" => 8,
    "B X" => 1,
    "B Y" => 5,
    "B Z" => 9,
    "C X" => 2,
    "C Y" => 6,
    "C Z" => 7
)

data = readchomp("data.txt")
rounds = split(data, "\n")

# part 1
scores_1 = getindex.(Ref(rules_1), rounds)
total_score_1 = sum(scores_1)
println("Total score for part 1 = $(total_score_1)")

# part 1
scores_2 = getindex.(Ref(rules_2), rounds)
total_score_2 = sum(scores_2)
println("Total score for part 1 = $(total_score_2)")
