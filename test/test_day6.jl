module test_day6

using Test
using AdventOfCode2022.Day6

nday = 6

data = parse_input(nday)

test = parse_input.(
"""
mjqjpqmgbljsphdztnvjfqwrcgsmlb
bvwbjplbgvbhsrlpgdmjqwftvncz
nppdvjthqldpwncqszvftbrmjlhg
nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg
zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw
""" |> strip |> Day6.splitlines
)

@testset "Day$nday tests" begin
    @test solve1.(test) == [7, 5, 6, 10, 11]
    @test solve2.(test) == [19,23,23,29,26]
end

@testset "Day$nday solutions" begin
    @test solve1(data) == 1544
    @test solve2(data) == 2145
end

end  # module
