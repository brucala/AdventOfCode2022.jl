module Day24
include("utils.jl")
using .Utils
import .Utils: parse_input

export solve1, solve2, parse_input

###
### Parse
###

struct Wind
    N::Int
    initial::Int
    reverse::Bool
end
Wind(c::Char, N::Int, x::Int) = Wind(N, x, c in ('^', '<'))
value(w::Wind, t::Int) = mod1(w.initial + (w.reverse ? -t : t), w.N)

struct Valley
    nrow::Int
    ncol::Int
    horizontal::Dict{Int, Vector{Wind}}
    vertical::Dict{Int, Vector{Wind}}
end
function Valley(x)
    lines = splitlines(x)
    nrow, ncol = length(lines) - 2, length(lines[1]) - 2
    v = Valley(nrow, ncol, Dict(), Dict())
    for (row, line) in enumerate(lines[2:end-1]), (col, c) in enumerate(line[2:end-1])
        c === '.' && continue
        if c in ('>', '<')
            push!(get!(v.horizontal, row, []), Wind(c, ncol, col))
        else
            push!(get!(v.vertical, col, []), Wind(c, nrow, row))
        end
    end
    return v
end
Base.size(v::Valley) = (v.nrow, v.ncol)

parse_input(x::AbstractString) = Valley(x)

###
### Part 1
###

function cango(v::Valley, pos::NTuple{2, Int}, t::Int)
    r, c = pos
    (r < 1 || c < 1 || r > v.nrow || c > v.ncol) && return false
    haskey(v.horizontal, r) && any(x -> c in value(x, t), v.horizontal[r]) && return false
    haskey(v.vertical, c) && any(x -> r in value(x, t), v.vertical[c]) && return false
    return true
end

function solve(x::Valley; start=nothing, goal=nothing, t0=0)
    isnothing(start) && (start = (0,1))
    isnothing(goal) && (goal = size(x))
    MAX_T = 1000
    queue = [(t0, start)]  # (time, position)
    seen = Set{Tuple{Int, NTuple{2, Int}}}()
    while !isempty(queue)
        t, pos = popfirst!(queue)
        (t, pos) in seen && continue
        push!(seen, (t, pos))
        t >= MAX_T && return t, -1
        #@show t, pos
        for dir in ((0, 0), (0, 1), (0, -1), (1, 0), (-1, 0))
            nextpos = pos .+ dir
            if cango(x, nextpos, t + 1)
                #@show "cango", t+1, nextpos
                nextpos == goal && return t + 2
                push!(queue, (t + 1, nextpos))
            end
            pos == start && dir == (0, 0) && push!(queue, (t + 1, pos))
        end
        #@show queue
    end
end


solve1(x) = solve(x)

###
### Part 2
###

function solve2(x)
    t = solve(x)
    t = solve(x; start=(x.nrow+1, x.ncol), goal=(1, 1), t0=t)
    return solve(x; t0=t)
end

###
### Extra
###

function atpos(v::Valley, pos::NTuple{2, Int}, t::Int)
    r, c = pos
    winds = Char[]
    haskey(v.horizontal, r) && append!(winds, [(w.reverse ? '<' : '>') for w in v.horizontal[r] if c == value(w, t)])
    haskey(v.vertical, c) && append!(winds, [(w.reverse ? '^' : 'v') for w in v.vertical[c] if r == value(w, t)])
    return winds
end

function show_valley(v::Valley, t::Int)
    for row in 1:v.nrow
        for col in 1:v.ncol
            w = atpos(v, (row, col), t)
            if length(w) > 1
                print(length(w))
            elseif length(w) == 1
                print(w[1])
            else
                print('.')
            end
        end
        println()
    end
end

end  # module
