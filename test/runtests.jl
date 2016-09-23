using GMAT
using Compat
using Base.Test

# write your own tests here
@testset "Init" begin
    @test GMAT.start() == 0
    @test_throws GMAT.GmatError GMAT.start(@__DIR__)
end

@testset "Load & Run" begin
    file = "/Users/helge/Downloads/GMAT/R2015a/samples/Ex_HohmannTransfer.script"
    GMAT.start()
    @test GMAT.load(file) == 0
println(GMAT.run())
println(GMAT.state_size())
println(GMAT.state_description())
end
