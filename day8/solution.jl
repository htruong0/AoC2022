data = readlines("C:/Users/Henry/Documents/aoc2022/day8/data.txt")

# turn trees into an array of Ints
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

# look from edge towards tree
# the tree is visible if it is the strictly (unique) tallest tree
function check_from_direction(height_map, pos, direction)
    if direction == "north"
        view = height_map[1:pos[1], pos[2]]
    elseif direction == "east"
        view = height_map[pos[1], pos[2]:end]
    elseif direction == "south"
        view = height_map[pos[1]:end, pos[2]]
    elseif direction == "west"
        view = height_map[pos[1], 1:pos[2]]
    end
    # it is the tallest tree if no other tree is at the same height or taller
    count(>=(height_map[pos...]), view) == 1
end

# look from tree towards edge
# view is blocked when first tree is same height or taller than tree
function look_in_direction(height_map, pos, direction)
    if direction == "north"
        view = height_map[pos[1]-1:-1:1, pos[2]]
    elseif direction == "east"
        view = height_map[pos[1], pos[2]+1:end]
    elseif direction == "south"
        view = height_map[pos[1]+1:end, pos[2]]
    elseif direction == "west"
        view = height_map[pos[1], pos[2]-1:-1:1]
    end
    # find first index in view that blocks view
    distance = findfirst(x -> x >= height_map[pos...], view)
    # if no match then we can look all the way to the edge
    isnothing(distance) ? length(view) : distance
end

# loop over cardinal directions
function check_all_directions(height_map, pos)
    directions = ["north", "east", "south", "west"]
    any([check_from_direction(height_map, pos, direction) for direction in directions])
end

function look_all_directions(height_map, pos)
    directions = ["north", "east", "south", "west"]
    [look_in_direction(height_map, pos, direction) for direction in directions]
end

height_map = create_height_map(data)
n, m = height_map |> size

# part 1
n_edges = 2*n + 2*m - 4
visible = n_edges
for i in 2:n-1
    for j in 2:m-1
        global visible += check_all_directions(height_map, (i, j))
    end
end
println("Part 1: number of visible trees = $(visible)")

# part 2
scenic_score = 0
# ignore edges as will multiply by 0 anyway
for i in 2:n-1
    for j in 2:m-1
        d = prod(look_all_directions(height_map, (i, j)))
        global scenic_score = max(d, scenic_score)
    end
end
println("Part 2: max scenic score = $(scenic_score)")
