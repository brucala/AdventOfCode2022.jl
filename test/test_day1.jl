module test_day1

using Test
using AdventOfCode2022.Day1

nday = 1

data = parse_input(nday)

test = parse_input(
"""
1000
2000
3000

4000

5000
6000

7000
8000
9000

10000
"""
)

@testset "Day$nday tests" begin
    @test solve1(test) == 24000
    @test solve2(test) == 45000
end

@testset "Day$nday solutions" begin
    @test solve1(data) == 69310
    @test solve2(data) == 206104
end

end  # module
