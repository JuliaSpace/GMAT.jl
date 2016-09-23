using BinDeps

const BASE_URL = "http://downloads.sourceforge.net/project/gmat/GMAT"
const RELEASE = "R2015a"

@BinDeps.setup

gmat = library_dependency("libCInterface")
provides(Binaries, URI("$BASE_URL/GMAT-$RELEASE/gmat-macosx-x64-$RELEASE.tar.gz"), gmat, os=:Darwin, unpacked_dir="GMAT/$RELEASE/bin")
provides(Binaries, URI("$BASE_URL/GMAT-$RELEASE/gmat-ubuntu-x64-$RELEASE.tar.gz"), gmat, os=:Linux, unpacked_dir="GMAT/$RELEASE/bin")
provides(Binaries, URI("$BASE_URL/GMAT-$RELEASE/gmat-win-i586-$RELEASE.zip"), gmat, os=:Windows, unpacked_dir="GMAT/bin")

@BinDeps.install Dict(:libCInterface => :libCInterface)
