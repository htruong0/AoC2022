function make_move(crate_map, instruction, rev)
    n, a, b = [parse(Int, m.match) for m in eachmatch(r"\d+", instruction)] |> collect
    crates_to_move = crate_map[a][1:n]
    # reverse string if the JCB moves them one by one
    if rev
        crates_to_move = crates_to_move |> reverse
    end
    crate_map[a] = chop(crate_map[a], head=n, tail=0)
    crate_map[b] = crates_to_move*crate_map[b]
    crate_map
end

data = readlines("data.txt")

# create map of crates
# find empty string to split crates and instructions
splitter = findfirst(isempty.(data))
n_crates = parse(Int, data[splitter-1][end-1])
crate_positions = [2+i*4 for i in 0:n_crates-1]

crates = map(x -> split(x[crate_positions], ""), data[1:splitter-2])
# transpose crates
crates = map(vcat, crates...)
# turn array into strings as only care about top crate
crate_map = map(x -> *(x...) |> strip, crates)

# make copies for modification
crate_map_pt1 = copy(crate_map)
crate_map_pt2 = copy(crate_map)

# get instructions
instructions = data[splitter+1:end]

# part 1
for instruction in instructions
    make_move(crate_map_pt1, instruction, true)
end
top_crates = *(first.(crate_map_pt1)...)
println("Part 1: top crates $(top_crates)")

# part 2
for instruction in instructions
    make_move(crate_map_pt2, instruction, false)
end
top_crates = *(first.(crate_map_pt2)...)
println("Part 2: top crates $(top_crates)")
