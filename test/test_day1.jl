module test_day1

using Test
using AdventOfCode2022.Day1

nday = 1

data = parse_input(nday)

test = parse_input(
"""
"""
)

@testset "Day$nday tests" begin
    @test solve1(test) == ?
    #@test solve2(test) == ?
end

@testset "Day$nday solutions" begin
    @test solve1(data) == ?
    #@test solve2(data) == ?
end

end  # module
