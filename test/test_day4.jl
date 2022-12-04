module test_day4

using Test
using AdventOfCode2022.Day4

nday = 4

data = parse_input(nday)

test = parse_input(
"""
2-4,6-8
2-3,4-5
5-7,7-9
2-8,3-7
6-6,4-6
2-6,4-8
"""
)

@testset "Day$nday tests" begin
    @test solve1(test) == 2
    @test solve2(test) == 4
end

@testset "Day$nday solutions" begin
    @test solve1(data) == 513
    @test solve2(data) == 878
end

end  # module
