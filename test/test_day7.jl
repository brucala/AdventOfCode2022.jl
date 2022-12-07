module test_day7

using Test
using AdventOfCode2022.Day7

nday = 7

data = parse_input(nday)

test = parse_input(
raw"""
$ cd /
$ ls
dir a
14848514 b.txt
8504156 c.dat
dir d
$ cd a
$ ls
dir e
29116 f
2557 g
62596 h.lst
$ cd e
$ ls
584 i
$ cd ..
$ cd ..
$ cd d
$ ls
4060174 j
8033020 d.log
5626152 d.ext
7214296 k
""" |> strip
)

@testset "Day$nday tests" begin
    @test solve1(test) == 95437
    @test solve2(test) == 24933642
end

@testset "Day$nday solutions" begin
    @test solve1(data) == 1449447
    @test solve2(data) == 8679207
end

end  # module
