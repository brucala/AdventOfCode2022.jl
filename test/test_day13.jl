module test_day13

using Test
using AdventOfCode2022.Day13

nday = 13

data = parse_input(nday)

test = parse_input(
"""
[1,1,3,1,1]
[1,1,5,1,1]

[[1],[2,3,4]]
[[1],4]

[9]
[[8,7,6]]

[[4,4],4,4]
[[4,4],4,4,4]

[7,7,7,7]
[7,7,7]

[]
[3]

[[[]]]
[[]]

[1,[2,[3,[4,[5,6,7]]]],8,9]
[1,[2,[3,[4,[5,6,0]]]],8,9]
""" |> strip
)

@testset "Day$nday tests" begin
    @test solve1(test) == 13
    @test solve2(test) == 140
end

@testset "Day$nday solutions" begin
    @test solve1(data) == 4821
    @test solve2(data) == 21890
end

end  # module
