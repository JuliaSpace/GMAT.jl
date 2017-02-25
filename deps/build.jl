using BinDeps

const BASE_URL = "http://downloads.sourceforge.net/project/gmat/GMAT"
const RELEASE = "R2016a"

@BinDeps.setup

@static if is_linux()
    push!(BinDeps.defaults, Binaries)
end
gmat = library_dependency("libCInterface")
provides(Binaries, URI("$BASE_URL/GMAT-$RELEASE/gmat-macosx-x64-$RELEASE.zip"), gmat, os=:Darwin, unpacked_dir=joinpath("GMAT", RELEASE, "bin"))
provides(Binaries, URI("$BASE_URL/GMAT-$RELEASE/gmat-ubuntu-x64-$RELEASE.tar.gz"), gmat, os=:Linux, unpacked_dir=joinpath("GMAT", RELEASE, "bin"))
provides(Binaries, URI("$BASE_URL/GMAT-$RELEASE/gmat-win-i586-$RELEASE.zip"), gmat, os=:Windows, unpacked_dir=joinpath("GMAT", "bin"))

@BinDeps.install Dict(:libCInterface => :libCInterface)
