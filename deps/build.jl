using BinDeps

const BASE_URL = "http://downloads.sourceforge.net/project/gmat/GMAT"
const RELEASE = "R2015a"

@BinDeps.setup

libCInterface = library_dependency("libCInterface", aliases=["libCInterface.so.$RELEASE"])
#= @static if is_apple() =#
#=     provides(Binaries, URI("$BASE_URL/GMAT-$RELEASE/gmat-macosx-x64-$RELEASE.tar.gz"), gmat, unpacked_dir="GMAT/$RELEASE/bin") =#
#= elseif is_linux() =#
    provides(Binaries, URI("$BASE_URL/GMAT-$RELEASE/gmat-ubuntu-x64-$RELEASE.tar.gz"), libCInterface, unpacked_dir="GMAT/$RELEASE/bin")
#= else =#
#=     provides(Binaries, URI("$BASE_URL/GMAT-$RELEASE/gmat-win-i586-$RELEASE.zip"), gmat, unpacked_dir="GMAT/bin") =#
#= end =#

@BinDeps.install Dict(:libCInterface => :libCInterface)
