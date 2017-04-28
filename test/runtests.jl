using GMAT
using Compat
using Base.Test

@testset "Init" begin
    @test GMAT.start() == 0
    @test_throws GMAT.GmatError GMAT.start(@__DIR__)
end

@testset "Load & Run" begin
    file = joinpath(GMAT.BASE, "samples", "Ex_HohmannTransfer.script")
    tmp = tempname()
    cp(file, tmp, remove_destination=true)
    try
        GMAT.start()
        @test GMAT.load(tmp) == 0
    finally
        rm(tmp)
    end
end
