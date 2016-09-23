using GMAT
using Compat
using Base.Test

@testset "Init" begin
    @test GMAT.start() == 0
    @test_throws GMAT.GmatError GMAT.start(@__DIR__)
end

@testset "Load & Run" begin
    file = joinpath(GMAT.BASE, "samples", "Ex_HohmannTransfer.script")
    GMAT.start()
    @test GMAT.load(file) == 0
    println(GMAT.run())
    println(GMAT.state_size())
    println(GMAT.state_description())
end
