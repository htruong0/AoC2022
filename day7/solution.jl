data = data = readlines("C:/Users/Henry/Documents/aoc2022/day7/data.txt")

paths = ["/"]
# keep track of file sizes in all unique directories
file_sizes = Dict{String, Int}()
# basically keep a vector of paths and sum up the file sizes
# for each absolute path in the vector
# if we move back one directory -> done with that path so remove it
for line in data[2:end]
    if line === "\$ cd .."
        pop!(paths)
    elseif startswith(line, "\$ cd ")
        directory_name = split(line, " ")[end]
        push!(paths, "$(last(paths))/$(directory_name)")
    elseif isdigit(line[1])
        size = parse(Int, split(line, " ")[1])
        # add dictionaries with the same absolute paths -> sums over subdirectories
        mergewith!(+, file_sizes, Dict(path => size for path in paths))
    end
end

sizes = file_sizes |> values |> collect

# part 1
pt1 = filter(x -> x < 100000, sizes) |> sum
println("Total sum of directories with less than 100000 in size = $(pt1)")

# part 2
required_size = file_sizes["/"] - 40_000_000
sorted_sizes = sort(sizes)
pt2 = sorted_sizes[searchsortedfirst(sorted_sizes, required_size)]
println("Size of file to remove = $(pt2)")
