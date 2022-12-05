module test_day2

using Test
using AdventOfCode2022.Day2

nday = 2

data = parse_input(nday)

test = parse_input(
"""
A Y
B X
C Z
""" |> strip
)

@testset "Day$nday tests" begin
    @test solve1(test) == 15
    @test solve2(test) == 12
end

@testset "Day$nday solutions" begin
    @test solve1(data) == 15691
    @test solve2(data) == 12989
end

end  # module
