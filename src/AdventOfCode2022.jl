module AdventOfCode2022

solved_days = 20:23

for day = solved_days
    include("day$day.jl")
end

include("utils.jl")

export solved_days

end # module
