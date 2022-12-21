module test_day20

using Test
using AdventOfCode2022.Day20

nday = 20

data = parse_input(nday)

test = parse_input(
"""
1
2
-3
3
-2
0
4
""" |> strip
)

@testset "Day$nday tests" begin
    @test solve1(test) == 3
    @test solve2(test) == 1623178306
end

@testset "Day$nday solutions" begin
    @test solve1(data) == 7395
    @test solve2(data) == 1640221678213
end

end  # module
