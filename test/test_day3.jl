module test_day3

using Test
using AdventOfCode2022.Day3

nday = 3

data = parse_input(nday)

test = parse_input(
"""
vJrwpWtwJgWrhcsFMMfFFhFp
jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL
PmmdzqPrVvPwwTWBwg
wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn
ttgJtRGJQctTZtZT
CrZsJsPPZsGzwwsLwLmpwMDw
"""
)

@testset "Day$nday tests" begin
    @test solve1(test) == 157
    @test solve2(test) == 70
end

@testset "Day$nday solutions" begin
    @test solve1(data) == 7742
    @test solve2(data) == 2276
end

end  # module
