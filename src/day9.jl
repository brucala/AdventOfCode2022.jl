module Day9
include("utils.jl")
using .Utils
import .Utils: parse_input

export solve1, solve2, parse_input

###
### Parse
###

function parseline(x)
    d, n = split(x)
    return Symbol(d), toint(n)
end

parse_input(x::AbstractString) = parseline.(splitlines(x))

###
### Part 1
###

mutable struct Rope
    head::NTuple{2, Int} #Pair{Int}
    tail::NTuple{2, Int} #Pair{Int}
    visited::Set{NTuple{2, Int}}
end
Rope() = Rope((0, 0), (0, 0), Set([(0, 0)]))

distance(r::Rope) = r.head .- r.tail
minusone(x::Int) = abs(x) <= 1 ? x : sign(x) * (abs(x) - 1)
function catchup!(r::Rope)
    d = distance(r)
    all(x -> abs(x)<2, d) && return
    r.tail = r.tail .+ minusone.(d)
    push!(r.visited, r.tail)
    return
end

move!(r::Rope, d::Symbol, n::Int) = foreach(i -> move!(r, d), 1:n)

function move!(r::Rope, d)
    if d === :U
        r.head = r.head .+ (1, 0)
    elseif d === :D
        r.head = r.head .+ (-1, 0)
    elseif d === :R
        r.head = r.head .+ (0, 1)
    else
        r.head = r.head .+ (0, -1)
    end
    catchup!(r)
end

function solve1(x)
    r = Rope()
    for (d, n) in x
        move!(r, d, n)
    end
    return r.visited |> length
end

###
### Part 2
###

mutable struct Rope2
    knot::Vector{NTuple{2, Int}}
    visited::Set{NTuple{2, Int}}
end
Rope2() = Rope2(fill((0, 0), 10), Set([(0, 0)]))

distance(r::Rope2, i::Int) = r.knot[i] .- r.knot[i+1]
function catchup!(r::Rope2, i::Int)
    d = distance(r, i)
    all(x -> abs(x)<2, d) && return
    r.knot[i+1] = r.knot[i+1] .+ minusone.(d)
    i==9 && push!(r.visited, r.knot[10])
    return
end

move!(r::Rope2, d::Symbol, n::Int) = foreach(i -> move!(r, d), 1:n)

function move!(r::Rope2, d)
    if d === :U
        r.knot[1] = r.knot[1] .+ (1, 0)
    elseif d === :D
        r.knot[1] = r.knot[1] .+ (-1, 0)
    elseif d === :R
        r.knot[1] = r.knot[1] .+ (0, 1)
    else
        r.knot[1] = r.knot[1] .+ (0, -1)
    end
    foreach(i -> catchup!(r, i), 1:9)
    #@show d, r.knot[1], r.knot[10]
end


function solve2(x)
    r = Rope2()
    for (d, n) in x
        move!(r, d, n)
    end
    return r.visited |> length
end

end  # module
