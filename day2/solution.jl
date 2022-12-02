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

# part 2
scores_2 = getindex.(Ref(rules_2), rounds)
total_score_2 = sum(scores_2)
println("Total score for part 1 = $(total_score_2)")

###### attempt 2 ######

@enum ShapeScore R=1 P=2 S=3

struct Shape
    shape::ShapeScore
    winAgainst::ShapeScore
    loseAgainst::ShapeScore
end

function get_score_pt1(round)
    opponentPick, playerPick = getindex.(Ref(convertToShape), split(round, " "))
    score = Int(playerPick.shape)
    if playerPick.winAgainst === opponentPick.shape
        score += 6
    elseif playerPick.shape === opponentPick.shape
        score += 3
    elseif playerPick.loseAgainst === opponentPick.shape
        score += 0
    end
end

function get_score_pt2(round)
    opponentPick, playerResult = getindex.(Ref(convertToResults), split(round, " "))
    score = playerResult
    if playerResult === 0
        score += Int(opponentPick.winAgainst)
    elseif playerResult === 3
        score += Int(opponentPick.shape)
    elseif playerResult === 6
        score += Int(opponentPick.loseAgainst)
    end
end

rock = Shape(R, S, P)
paper = Shape(P, R, S)
scissors = Shape(S, P, R)

convertToShape = Dict(
    "A" => rock,
    "B" => paper,
    "C" => scissors,
    "X" => rock,
    "Y" => paper,
    "Z" => scissors,
)

convertToResults = Dict(
    "A" => rock,
    "B" => paper,
    "C" => scissors,
    "X" => 0,
    "Y" => 3,
    "Z" => 6
)

score_pt1 = get_score_pt1.(rounds) |> sum
println("Score for part 1 = $(score_pt1)")

score_pt2 = get_score_pt2.(rounds) |> sum
println("Score for part 2 = $(score_pt2)")
