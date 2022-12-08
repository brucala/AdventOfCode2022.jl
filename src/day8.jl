module Day8
include("utils.jl")
using .Utils
import .Utils: parse_input

export solve1, solve2, parse_input

###
### Parse
###

parse_input(x::AbstractString) = parse.(Int8, getgrid(x))

###
### Part 1
###

function cummax(x::Matrix{Int8})
    n, _ = size(x)  # assume square
    l = fill(Int8(-1), n, n)
    r = fill(Int8(-1), n, n)
    t = fill(Int8(-1), n, n)
    b = fill(Int8(-1), n, n)
    for i in 2:n-1
        for j in 2:n-1
            l[i, j] = max(x[i, j-1], l[i, j-1])
            r[i, n-j+1] = max(x[i, n-j+2], r[i, n-j+2])
            t[i, j] = max(x[i-1, j], t[i-1, j])
            b[n-i+1, j] = max(x[n-i+2, j], b[n-i+2, j])
        end
    end
    return l, r, t, b
end

function solve1(x)
    l, r, t, b = cummax(x)
    return sum(x .> l .|| x.> r .|| x.> t .|| x.> b)
end

###
### Part 2
###

function scenic_view(x, i, j)
    n, _ = size(x)  # assume square
    scores = zeros(Int8, 4)
    for k in i+1:n
        scores[1] += 1
        x[k, j] >= x[i, j] && break
    end
    for k in j+1:n
        scores[2] += 1
        x[i, k] >= x[i, j] && break
    end
    for k in i-1:-1:1
        scores[3] += 1
        x[k, j] >= x[i, j] && break
    end
    for k in j-1:-1:1
        scores[4] += 1
        x[i, k] >= x[i, j] && break
    end
    return prod(scores)
end

function solve2(x)
    n, _ = size(x)  # assume square
    highest = 0
    for i in 2:n-1, j in 2:n-1
        sv = scenic_view(x, i, j)
        if sv > highest
            highest = sv
        end
    end
    return highest
end

end  # module
