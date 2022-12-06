function find_marker(input, window_size)
    for i in 1:(length(input)-window_size)
        marker = input[i:i-1+window_size] |> Set |> length
        if marker === window_size
            marker_position = i + window_size - 1
            return marker_position
        end
    end
end

data = readchomp("data.txt")

# part 1
marker_position = find_marker(data, 4)
println("Part 1: marker at $(marker_position)")

# part 2
marker_position = find_marker(data, 14)
println("Part 2: marker at $(marker_position)")
