module Day12
include("utils.jl")
using .Utils
import .Utils: parse_input

export solve1, solve2, parse_input

###
### Parse
###

function parse_input(x::AbstractString)
    heighmap = getgrid(x) .- 'a'
    start = findfirst(==(-14), heighmap)
    goal = findfirst(==(-28), heighmap)
    heighmap[start] = 0
    heighmap[goal] = 'z' - 'a'
    return start.I, goal.I, heighmap
end
###
### Part 1
###

cando(heightmap, from, to) = heightmap[to...] - heightmap[from...] <=1

function neighbors(heightmap, pos)
    neighbors = typeof(pos)[]
    for d in ((0,1), (0, -1), (1, 0), (-1, 0))
        p = pos .+ d
        checkbounds(Bool, heightmap, p...) && push!(neighbors, p)
    end
    return neighbors
end

function solve(start, goal, grid, nmax=typemax(Int))
    queue = [(start, 0)]
    seen = typeof(start)[]
    while !isempty(queue)
        pos, n = popfirst!(queue)
        n > nmax && break
        pos == goal && return n
        pos in seen && continue
        push!(seen, pos)
        n += 1
        for p in neighbors(grid, pos)
            p in seen && continue
            cando(grid, pos, p) && push!(queue, (p, n))
        end
    end
    return nmax
end

solve1(x) = solve(x...)

###
### Part 2
###

function solve2(x)
    _, goal, grid = x
    nmin = 9999
    for start in findall(==(0), grid)
        n = solve(start.I, goal, grid, nmin)
        nmin = min(n, nmin)
    end
    return nmin
end

end  # module
