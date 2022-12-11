data = readlines("data.txt")

mutable struct Knot
    Positions::Vector{Complex}
    CurrentPosition::Complex
    PreviousPosition::Complex
end

function int_divide(z, r)
    complex(real(z) ÷ r, imag(z) ÷ r)
end

global direction_lookup = Dict(
    "U" => 0+1im,
    "R" => 1+0im,
    "D" => 0-1im,
    "L" => -1+0im,
)

function parse_input(line)
    direction, magnitude = split(line, " ")
    direction = direction_lookup[direction]
    magnitude = parse(Int, magnitude)
    direction, magnitude
end

function make_head_move(move, positions)
    direction, magnitude = parse_input(move)
    for _ in 1:magnitude
        push!(positions, last(positions)+direction)
    end
    positions
end

function get_head_positions(moves)
    visited_positions = [0+0im]
    for move in moves
        visited_positions = make_head_move(move, visited_positions)
    end
    visited_positions
end

function move_tail(head, tail)
    tail.CurrentPosition = isempty(tail.Positions) ? 0+0im : tail.Positions[end]
    d = head.CurrentPosition - tail.CurrentPosition
    if abs(d) == 0 || abs(d) == √2
        push!(tail.Positions, tail.CurrentPosition)
    elseif abs(d) > √2
        if abs(d) == 2
            push!(tail.Positions, tail.CurrentPosition + int_divide(d, 2))
        elseif real(d) > 0 && imag(d) > 0 # UR
            push!(tail.Positions, tail.CurrentPosition + direction_lookup["U"] + direction_lookup["R"])
        elseif real(d) > 0 && imag(d) < 0 # DR
            push!(tail.Positions, tail.CurrentPosition + direction_lookup["D"] + direction_lookup["R"])
        elseif real(d) < 0 && imag(d) > 0 # UL
            push!(tail.Positions, tail.CurrentPosition + direction_lookup["U"] + direction_lookup["L"])
        elseif real(d) < 0 && imag(d) < 0 # DL
            push!(tail.Positions, tail.CurrentPosition + direction_lookup["D"] + direction_lookup["L"])
        end
    else
        push!(tail.Positions, tail.CurrentPosition)
    end
    tail.PreviousPosition = isempty(tail.Positions) ? 0+0im : tail.CurrentPosition
end

head_positions = get_head_positions(data)
head = Knot(head_positions, head_positions[1], head_positions[1])
knots = [Knot([], 0+0im, 0+0im) for _ in 1:9]
rope = [head; knots]

for j in 1:length(rope[1].Positions)
    for i in 2:length(rope)
        rope[i-1].CurrentPosition = rope[i-1].Positions[j]
        move_tail(rope[i-1], rope[i])
        rope[i-1].PreviousPosition = rope[i-1].Positions[j]
    end
end

# part 1
unique_positions = Set(rope[2].Positions) |> length
println("Part 1: unique positions = $(unique_positions)")

# part 2
unique_positions = Set(rope[end].Positions) |> length
println("Part 2: unique positions = $(unique_positions)")
