module test_day18

using Test
using AdventOfCode2022.Day18

nday = 18

data = parse_input(nday)

test = parse_input(
"""
2,2,2
1,2,2
3,2,2
2,1,2
2,3,2
2,2,1
2,2,3
2,2,4
2,2,6
1,2,5
3,2,5
2,1,5
2,3,5
""" |> rstrip
)

@testset "Day$nday tests" begin
    @test solve1(test) == 64
    @test solve2(test) == 58
end

@testset "Day$nday solutions" begin
    @test solve1(data) == 4364
    @test solve2(data) == 2508
end

end  # module
