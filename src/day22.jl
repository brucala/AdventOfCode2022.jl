module Day22
include("utils.jl")
using .Utils
import .Utils: parse_input

export solve1, solve2, parse_input

###
### Parse
###

const Point = NTuple{2, Int}

#abstract type Direction end
#struct N <: Direction end
#struct E <: Direction end
#struct S <: Direction end
#struct W <: Direction end

@enum Direction E=0 S=1 W=2 N=3
opposite(d::Direction) = Direction((Int(d) + 2) % 4)

abstract type AbstractMap end

mutable struct Map <: AbstractMap
    pos::Point
    facing::Direction
    tiles::Set{Point}
    walls::Set{Point}
    path::Vector{Union{Int, Symbol}}
end
function Map(x)
    board, path = split(x, "\n\n")
    pos, tiles, walls = parse_board(board)
    path = parse_path(path)
    Map(pos, E, tiles, walls, path)
end

restart!(m::Map) = (m.pos = minimum(m.tiles); m.facing = E)

function parse_board(board)
    tiles, walls = Set{Point}(), Set{Point}()
    pos::Point = (0, 0)
    for (row, line) in enumerate(splitlines(board)), (col, c) in enumerate(line)
        if c === '.'
            isempty(tiles) && (pos = (row, col))
            push!(tiles, (row, col))
        elseif c === '#'
            push!(walls, (row, col))
        end
    end
    return pos, tiles, walls
end
function parse_path(x)
    path = Union{Int, Symbol}[]
    number = ""
    for c in x
        if c in ('R', 'L')
            !isempty(number) && push!(path, toint(number))
            push!(path, Symbol(c))
            number = ""
        else
            number *= c
        end
    end
    !isempty(number) && push!(path, toint(number))
    return path
end

parse_input(x::AbstractString) = Map(x)

###
### Part 1
###

# (row, column)
delta = Dict(
    E => (0, 1),
    S => (1, 0),
    W => (0, -1),
    N => (-1, 0),
)

hslice(m::Map, r::Int) = Set(p for p in m.tiles if p[1] == r)
vslice(m::Map, c::Int) = Set(p for p in m.tiles if p[2] == c)

function move!(m::Map)
    pos, dpos = m.pos, delta[m.facing]
    newpos = pos .+ dpos
    newpos in m.walls && return false
    if newpos in m.tiles
        m.pos = newpos
        return true
    end
    # wrap
    d = m.facing
    slice = d in (E, W) ? hslice(m, pos[1]) :  vslice(m, pos[2])
    newpos = d in (S, E) ? minimum(slice) : maximum(slice)
    (newpos .- dpos) in m.walls && return false
    m.pos = newpos
    return true
end

function move!(m::AbstractMap, n::Int)
    for _ in 1:n
        move!(m) || return
    end
    return
end
function move!(m::AbstractMap, x::Symbol)
    x === :R && (m.facing = right(m.facing))
    x === :L && (m.facing = left(m.facing))
    return
end
right(d::Direction) = Direction((Int(d) + 1) % 4)
left(d::Direction) = Direction((Int(d) + 3) % 4)

password(m::AbstractMap) = m.pos[1] * 1000 + m.pos[2] * 4 + Int(m.facing)

function solve1(x)
    restart!(x)
    for action in x.path
        move!(x, action)
    end
    return password(x)
end

###
### Part 2
###

struct Square{N}
    pos::Point  # top left corner
    walls::Set{Point}
end

# assumes map consist of 6 squares of size N
mutable struct Map2{N} <: AbstractMap
    pos::Point
    facing::Direction
    squares::Vector{Square{N}}  # ordered by (row, col)
    path::Vector{Union{Int, Symbol}}
end
function Map2(m::Map, N::Int)
    tiles = deepcopy(m.tiles)
    squares = Square{N}[]
    foreach(i -> push!(squares, getsquare!(tiles, m.walls, N)), 1:6)
    @assert isempty(tiles)
    return Map2(m.pos, m.facing, squares, m.path)
end

function getsquare!(tiles::Set{Point}, walls::Set{Point}, N::Int)
    pos = minimum(tiles)
    setdiff!(tiles, pos .+ (x, y) for x in 0:(N-1), y in 0:(N-1))
    w = Set(p for p in walls if _in(p, pos, N))
    return Square{N}(pos, w)
end
_in(pos::Point, corner::Point, n::Int) = all(_in.(pos, corner, n))
_in(x::Int, y::Int, n::Int) = 0 <= x - y < n


Base.in(pos::Point, s::Square) = _in(pos, s.pos, size(s))
Base.in(pos::Point, m::Map2) = any(s -> pos in s, m.squares)
Base.size(::Square{N}) where N = N

restart!(m::Map2) = (m.pos = minimum(s -> s.pos, m.squares); m.facing = E)

isblocked(s::Square, pos::Point) = pos in s && pos in s.walls
function isblocked(m::Map2, pos::Point)
    for s in m.squares
        isblocked(s, pos) && return true
    end
    return false
end
function move!(m::Map2)
    pos, dpos = m.pos, delta[m.facing]
    newpos = pos .+ dpos
    isblocked(m, newpos) && return false
    if newpos in m
        m.pos = newpos
        return true
    end
    # wrap
    newpos, newdir = wrap(m, pos)
    isblocked(m, newpos) && return false
    m.pos = newpos
    m.facing = newdir
    return true
end


struct Wrap
    square1::Int  # index of square
    side1::Direction
    square2::Int
    side2::Direction
    reverse::Bool
end

# manually introduced :(
test_wraps = [
    Wrap(1, E, 6, E, true),
    Wrap(1, N, 2, N, true),
    Wrap(1, W, 3, N, false),
    Wrap(2, W, 6, S, true),
    Wrap(2, S, 5, S, true),
    Wrap(3, S, 5, W, true),
    Wrap(4, E, 6, N, true),
]
wraps = [
    Wrap(1, N, 6, W, false),
    Wrap(1, W, 4, W, true),
    Wrap(2, N, 6, S, false),
    Wrap(2, E, 5, E, true),
    Wrap(2, S, 3, E, false),
    Wrap(3, W, 4, N, false),
    Wrap(5, S, 6, E, false),
]


findsquare(m::Map2, pos::Point) = findfirst(i -> pos in m.squares[i], 1:6)
function findwrap(t::Tuple{Int, Direction}, wraps::Vector{Wrap})
    for w in wraps
        t == (w.square1, w.side1) && return (w.square2, w.side2, w.reverse)
        t == (w.square2, w.side2) && return (w.square1, w.side1, w.reverse)
    end
end

function wrap(square::Square, side::Direction, i::Int, rev::Bool)
    rev && (i = size(square) - i - 1) # 0:N-1
    pos = square.pos
    if side == W
        return (pos[1] + i, pos[2])
    elseif side == N
        return (pos[1], pos[2] + i)
    elseif side == E
        return (pos[1] + i, pos[2] + size(square) - 1)
    end
    return (pos[1] + size(square) - 1, pos[2] + i)
end
function wrap(m::Map2, pos::Point)
    square = findsquare(m, pos)
    side = m.facing
    w = 4 == size(m.squares[1]) ? test_wraps : wraps  # TODO: ugly
    newsquare, newside, rev = findwrap((square, side), w)  # TODO: test/no-test logic
    ipos = mod1(Int(side) + 1, 2)
    i = pos[ipos] - m.squares[square].pos[ipos]  # 0:n-1
    newsquare = m.squares[newsquare]
    newpos = wrap(newsquare, newside, i, rev)
    newdir = opposite(newside)
    return newpos, newdir
end

function solve2(x, n=50)
    m = Map2(x, n)
    restart!(m)
    for action in m.path
        move!(m, action)
    end
    return password(m)
end

end  # module
