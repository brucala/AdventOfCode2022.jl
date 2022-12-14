module test_day14

using Test
using AdventOfCode2022.Day14

nday = 14

data = parse_input(nday)

test = parse_input(
"""
498,4 -> 498,6 -> 496,6
503,4 -> 502,4 -> 502,9 -> 494,9
""" |> strip
)

@testset "Day$nday tests" begin
    @test solve1(test) == 24
    @test solve2(test) == 93
end

@testset "Day$nday solutions" begin
    @test solve1(data) == 644
    @test solve2(data) == 27324
end

end  # module
