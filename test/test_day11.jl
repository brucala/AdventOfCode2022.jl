module test_day11

using Test
using AdventOfCode2022.Day11

nday = 11

data = parse_input(nday)

test = parse_input(
"""
Monkey 0:
  Starting items: 79, 98
  Operation: new = old * 19
  Test: divisible by 23
    If true: throw to monkey 2
    If false: throw to monkey 3

Monkey 1:
  Starting items: 54, 65, 75, 74
  Operation: new = old + 6
  Test: divisible by 19
    If true: throw to monkey 2
    If false: throw to monkey 0

Monkey 2:
  Starting items: 79, 60, 97
  Operation: new = old * old
  Test: divisible by 13
    If true: throw to monkey 1
    If false: throw to monkey 3

Monkey 3:
  Starting items: 74
  Operation: new = old + 3
  Test: divisible by 17
    If true: throw to monkey 0
    If false: throw to monkey 1
""" |> strip
)

@testset "Day$nday tests" begin
    @test solve1(test) == 10605
    @test solve2(test) == 2713310158
end

@testset "Day$nday solutions" begin
    @test solve1(data) == 58056
    @test solve2(data) == 15048718170
end

end  # module
