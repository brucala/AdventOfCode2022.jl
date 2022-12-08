module test_day8

using Test
using AdventOfCode2022.Day8

nday = 8

data = parse_input(nday)

test = parse_input(
"""
30373
25512
65332
33549
35390
""" |> strip
)

@testset "Day$nday tests" begin
    @test solve1(test) == 21
    @test solve2(test) == 8
end

@testset "Day$nday solutions" begin
    @test solve1(data) == 1835
    @test solve2(data) == 263670
end

end  # module
