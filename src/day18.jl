module Day18
include("utils.jl")
using .Utils
import .Utils: parse_input

export solve1, solve2, parse_input

###
### Parse
###

const Point = NTuple{3, Int}
Point(s::AbstractString) = Point(toint.(split(s, ",")))

parse_input(x::AbstractString) = Set(Point.(splitlines(x)))

###
### Part 1
###

const dirs = ((1,0,0), (0,1,0), (0,0,1), (-1,0,0), (0,-1,0), (0,0,-1))
neighbors(p::Point) = map(d -> p .+ d, dirs)

function solve1(cubes)
    sol = 0
    for cube in cubes
        sol += 6 - sum(n -> n in cubes, neighbors(cube))
    end
    return sol
end

###
### Part 2
###

xslice(cubes, y, z) = (xx for (xx, yy, zz) in cubes if y == yy && z == zz)
yslice(cubes, x, z) = (yy for (xx, yy, zz) in cubes if x == xx && z == zz)
zslice(cubes, x, y) = (zz for (xx, yy, zz) in cubes if y == yy && x == xx)
function xrange(cubes, y, z)
    s = xslice(cubes, y, z)
    return isempty(s) ? (1:0) : range(extrema(s)...)
end
function yrange(cubes, x, z)
    s = yslice(cubes, x, z)
    return isempty(s) ? (1:0) : range(extrema(s)...)
end
function zrange(cubes, x, y)
    s = zslice(cubes, x, y)
    return isempty(s) ? (1:0) : range(extrema(s)...)
end

"""true is certain, false is unknown"""
function isexterior(cubes, point)
    x, y, z = point
    x in xrange(cubes, y, z) && y in yrange(cubes, x, z) && z in zrange(cubes, x, y) && return false
    return true
end

function find_island(cubes, point)
    queue = [point]
    island = Set{Point}()
    exterior = false
    while !isempty(queue)
        p = pop!(queue)
        (p in cubes || p in island) && continue
        if isexterior(cubes, p)
            exterior = true
            continue
        end
        push!(island, p)
        append!(queue, neighbors(p))
    end
    return island, exterior
end

function solve2(cubes)
    sol = 0
    interior_islands = Set{Point}[]
    exterior_islands = Set{Point}[]
    for cube in cubes
        for n in neighbors(cube)
            (n in cubes || any(i -> n in i, interior_islands)) && continue
            if any(i -> n in i, exterior_islands)
                sol += 1
                continue
            end
            island, exterior = find_island(cubes, n)
            if exterior
                isempty(island) || push!(exterior_islands, island)
                sol += 1
            else
                push!(interior_islands, island)
            end
        end
    end
    return sol
end

end  # module
