# read in data
data = readlines("data.txt")

# indices of breaks
breaks = findall(isempty, data)

# start and end indices of breaks
start_points = [1; breaks .+ 1]
end_points = [breaks .- 1; length(data)]

# sum up calories for each elf
all_calories = Array{Int64}(undef, 0)
for (i, j) in zip(start_points, end_points)
    elf_calories = parse.(Int64, data[i:j])
    push!(all_calories, sum(elf_calories))
end

# part 1
maximum_calories = maximum(all_calories)
println("Maximum calories = $(maximum_calories).")

# part 2
top_three = partialsort(all_calories, 1:3, rev=true)
sum_top_three = sum(top_three)
println("Top three calories = $(top_three) => Sum = $(sum_top_three).")


###### better solution #######
f = readchomp("data.txt")
calories = eachsplit.(eachsplit(f, "\n\n"), "\n");
sum_calories = map(x -> parse.(Int, x) |> sum, calories);
top_three = partialsort!(sum_calories, 1:3, rev=true)
