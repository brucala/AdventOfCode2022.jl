module AdventOfCode2022

#solved_days = 1:23
solved_days = union(1:15, 17:17, 20:24)

for day = solved_days
    include("day$day.jl")
end

include("utils.jl")

export solved_days

end # module
