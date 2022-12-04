data = readchomp("C:/Users/Henry/Documents/AoC2022/day3/data.txt")
rucksacks = split(data, "\r\n")
priority = Dict(['a':'z';'A':'Z'] .=> collect(1:52))

function get_compartments(backpack)
    compartment_size = length(backpack) ÷ 2
    compartment_1 = backpack[1:compartment_size]
    compartment_2 = backpack[compartment_size+1:end]
    compartment_1, compartment_2
end

# part 1
compartments = map(x -> x |> get_compartments .|> Set, rucksacks)
priorities = map(x -> priority[intersect(x...)...], compartments) |> sum
println("Part 1: sum of priorities = $(priorities)")

# part 2
groups = Iterators.partition(rucksacks, 3);
priorities = map(x -> priority[intersect(Set.(x)...)...], groups) |> sum
println("Part 2: sum of priorities = $(priorities)")
