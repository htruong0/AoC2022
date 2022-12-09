function create_height_map(data)
    n = length(first(data))
    m = length(data)
    height_map = Matrix{Int}(undef, n, m)
    for i in 1:m
        for (j, val) in enumerate(data[i])
            height_map[i, j] = parse(Int, val)
        end
    end
    height_map
end

function check_direction(height_map, pos, direction)
    if direction == "north"
        view = height_map[pos[1]-1:-1:1, pos[2]]
    elseif direction == "east"
        view = height_map[pos[1], pos[2]+1:end]
    elseif direction == "south"
        view = height_map[pos[1]+1:end, pos[2]]
    elseif direction == "west"
        view = height_map[pos[1], pos[2]-1:-1:1]
    end
    # it is the tallest tree if no other tree is at the same height or taller
    visible = count(>=(height_map[pos...]), view) == 0
    # find first index in view that blocks view
    distance = findfirst(x -> x >= height_map[pos...], view)
    # if no match then we can look all the way to the edge
    distance = isnothing(distance) ? length(view) : distance
    
    visible, distance
end

function check_all_directions(height_map, pos)
    directions = ["north", "east", "south", "west"]
    res = [check_direction(height_map, pos, x) for x in directions]
    is_visible = getindex.(res, 1) |> any
    scenic_score = getindex.(res, 2) |> prod
    is_visible, scenic_score
end

data = readlines("C:/Users/Henry/Documents/aoc2022/day8/data.txt")

height_map = create_height_map(data)
n, m = height_map |> size
n_edges = 2*n + 2*m - 4

global visible = n_edges
global scenic_score = 0
for i in 2:n-1
    for j in 2:m-1
        is_vis, score = check_all_directions(height_map, (i, j))
        global visible += is_vis
        global scenic_score = max(score, scenic_score)
    end
end
println("Part 1: number of visible trees = $(visible)")
println("Part 2: max scenic score = $(scenic_score)")
