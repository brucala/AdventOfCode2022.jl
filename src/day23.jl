module Day23
include("utils.jl")
using .Utils
import .Utils: parse_input

export solve1, solve2, parse_input

###
### Parse
###

const Point = NTuple{2, Int}

function parse_input(x::AbstractString)
    elves = Point[]
    for (row, line) in enumerate(splitlines(x)), (col, c) in enumerate(line)
        c === '#' && push!(elves, (row, col))
    end
    return elves
end

###
### Part 1
###

const N, E, S, W, = (-1, 0), (0, 1), (1, 0), (0, -1)
const NE, NW, SE, SW = N .+ E, N .+ W, S .+ E, S .+ W
const adjacent = (N, E, S, W, NE, NW, SE, SW)
#const checks = Set.(([N, NE, NW], [S, SE, SW], [W, NW, SW], [E, NE, SE]))
const checks = ((N, NE, NW), (S, SE, SW), (W, NW, SW), (E, NE, SE))
const todir = (N, S, W, E)

neighbors(p::Point, elves::Set{Point}) = [dir for dir in adjacent if (p .+ dir) in elves]

function solve1(elves)
    elves = deepcopy(elves)
    for i in 1:10
        newpos = Dict{Point, Vector{Int}}()
        elfset = Set(elves)
        for (ielf, elf) in enumerate(elves)
            around = neighbors(elf, elfset)
            isempty(around) && continue
            for k in 0:3
                j = mod1(i+k, 4)
                isempty(around ∩ checks[j]) || continue
                push!(get!(newpos, elf .+ todir[j], []), ielf)
                break
            end
        end
        for (k, v) in newpos
            length(v) > 1 && continue
            elves[v[1]] = k
        end
    end
    rmin, rmax = extrema(i -> i[1], elves)
    cmin, cmax = extrema(i -> i[2], elves)
    return (rmax - rmin + 1) * (cmax - cmin + 1) - length(elves)
end

###
### Part 2
###

# TODO: extremely slow
function solve2(elves)
    elves = deepcopy(elves)
    for i in 1:10_000
        newpos = Dict{Point, Vector{Int}}()
        elfset = Set(elves)
        for (ielf, elf) in enumerate(elves)
            around = neighbors(elf, elfset)
            isempty(around) && continue
            for k in 0:3
                j = mod1(i+k, 4)
                all(e -> e ∉ checks[j], around) || continue
                all(e -> e ∉ checks[j], around) || continue
                push!(get!(newpos, elf .+ todir[j], []), ielf)
                break
            end
        end
        (isempty(newpos) || all(v -> length(v) > 1, values(newpos))) && return i
        for (k, v) in newpos
            length(v) > 1 && continue
            elves[v[1]] = k
        end
    end
end

###
### Extra
###

function Base.show(io::IO, elves::Vector{Point})
    rmin, rmax = extrema(i -> i[1], elves)
    cmin, cmax = extrema(i -> i[2], elves)
    for r in rmin:rmax
        for c in cmin:cmax
            print(io, (r,c) in elves ? '#' : '.')
        end
        println(io)
    end
end

end  # module
