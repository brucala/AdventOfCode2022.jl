module Day10
include("utils.jl")
using .Utils
import .Utils: parse_input, parse_example

export solve1, solve2, parse_input, parse_example

###
### Parse
###

parse_input(x::AbstractString) = splitlines(x)

###
### Part 1
###

function solve1(x)
    X = 1
    icycle = 0
    intercept = 20
    strength = 0
    for line in x
        sline = split(line)
        if length(sline) == 2
            toadd = toint(sline[2])
            icycle += 2
        else
            icycle += 1
            toadd = 0
        end
        if icycle >= intercept
            strength += intercept * X
            intercept += 40
            intercept > 220 && break
        end
        X += toadd
    end
    return strength
end

###
### Part 2
###

function solve2(x)
    X = 1
    icycle = 0
    pixels = Char[]
    for line in x
        sline = split(line)
        if length(sline) == 2
            X-1 <= icycle % 40 <= X+1 ? push!(pixels, '#') : push!(pixels, '.')
            (icycle + 1) % 40 == 0 && push!(pixels, '\n')
            X-1 <= (icycle+1) % 40 <= X+1 ? push!(pixels, '#') : push!(pixels, '.')
            X += toint(sline[2])
            icycle += 2
        else
            X-1 <= icycle % 40 <= X+1 ? push!(pixels, '#') : push!(pixels, '.')
            icycle += 1
        end
        icycle % 40 == 0 && push!(pixels, '\n')
    end
    return join(pixels)
end

end  # module
