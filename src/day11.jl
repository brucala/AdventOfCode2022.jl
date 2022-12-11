module Day11
include("utils.jl")
using .Utils
import .Utils: parse_input

export solve1, solve2, parse_input

###
### Parse
###

struct Monkey
    items::Vector{Int}
    operator::Function
    operand::Int
    divisible::Int
    iftrue::Int
    iffalse::Int
end
function Monkey(s::AbstractString)
    lines = splitlines(s)
    items = parse_items(lines[2])
    operator, operand = parse_operation(lines[3])
    divisible = last_int(lines[4])
    iftrue = last_int(lines[5])
    iffalse = last_int(lines[6])
    return Monkey(items, operator, operand, divisible, iftrue, iffalse)
end

parse_items(s::AbstractString) = toint.(split(split(s, ": ")[2], ", "))
function parse_operation(s::AbstractString)
    operator, operand = split(s, "= old ")[2] |> split
    if operand == "old"
        operand = 2
        operator = operator == "*" ? "^" : operator == "+" ? "*" : ""
    else
        operand = toint(operand)
    end
    operator = operator == "+" ? (+) : operator == "*" ? (*) : operator == "^" ? (^) : identity
    return operator, operand
end
last_int(s) = toint(split(s)[end])

struct Monkeys
    monkeys::Dict{Int, Monkey}
    inspected::Dict{Int, Int}
    common::Int
end
function Monkeys(monkeys::Vector{Monkey})
    n = length(monkeys)
    Monkeys(
        Dict(i => monkeys[i+1] for i in 0:n-1),
        Dict(i => 0 for i in 0:n-1),
        prod(m.divisible for m in monkeys)
    )
end
Base.length(m::Monkeys) = length(m.monkeys)

function parse_input(x::AbstractString)
    return Monkeys(Monkey.(split(x, "\n\n")))
end

###
### Part 1
###

round!(m::Monkeys, relief::Bool = true) = foreach(i -> turn!(m, i, relief), 0:length(m)-1)

function turn!(m::Monkeys, i::Int, relief)
    items = m.monkeys[i].items
    n = length(items)
    n == 0 && return
    m.inspected[i] += n

    while length(items) > 0
        worry = popfirst!(items)
        inspect!(m, i, worry, relief)
    end
    return
end

function inspect!(m::Monkeys, i::Int, worry::Int, relief)
    monkey = m.monkeys[i]
    worry = monkey.operator(worry, monkey.operand)
    if relief
        worry ÷= 3
    else
        worry %= m.common
    end
    to = worry % monkey.divisible == 0 ? monkey.iftrue : monkey.iffalse
    append!(m.monkeys[to].items, worry)
    return
end

monkey_bussines(m::Monkeys) = prod(sort(collect(values(m.inspected)), rev=true)[1:2])

function solve1(x; relief=true, nrounds=20)
    x = deepcopy(x)
    foreach(i -> round!(x, relief), 1:nrounds)
    return monkey_bussines(x)
end

###
### Part 2
###

solve2(x) = solve1(x, relief = false, nrounds = 10_000)

end  # module
