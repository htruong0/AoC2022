function get_assignments(line)
    map(x -> parse.(Int, x), line)
end

function convert_assignments(assignment)
    assignment_1, assignment_2 = assignment
    assignment_1 = Set(collect(assignment_1[1]:assignment_1[2]))
    assignment_2 = Set(collect(assignment_2[1]:assignment_2[2]))
    assignment_1, assignment_2
end

data = readchomp("C:/Users/Henry/Documents/aoc2022/day4/data.txt")
lines = map(x -> split.(x, "-"), split.(split(data, "\r\n"), ","))
sets = map(x -> x |> get_assignments |> convert_assignments, lines)

# part 1
total_overlaps = map(x -> length(x[1]) <= length(x[2]) ? issubset(x[1], x[2]) : issubset(x[2], x[1]), sets) |> sum
println("Part 1: pairs with complete overlap = $(total_overlaps)")

# part 2
any_overlaps = map(x -> length(intersect(x[1], x[2])) > 0, sets) |> sum
println("Part 2: pairs with any overlap = $(any_overlaps)")
