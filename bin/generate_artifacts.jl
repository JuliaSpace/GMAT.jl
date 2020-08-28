using Pkg.Artifacts
using Pkg.GitTools
using Pkg.PlatformEngines

probe_platform_engines!()

toml = joinpath(@__DIR__, "..", "Artifacts.toml")
url = "https://downloads.sourceforge.net/project/gmat/GMAT/GMAT-R2020a/GMAT-datafiles-R2020a.zip"

hash = create_artifact() do artifact_dir
    tarball = download(url)
    @show artifact_dir
    try
        global tarball_hash = bytes2hex(GitTools.blob_hash(tarball))
        unpack(tarball, artifact_dir)
    finally
        rm(tarball)
    end
end

bind_artifact!(toml, "gmat_data", hash;
               download_info=[(url, tarball_hash)],
               lazy=true,
               force=true)
