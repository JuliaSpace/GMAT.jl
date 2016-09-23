module GMAT

using Compat

const RELEASE = "R2015a"
@static if is_windows()
    const BASE = joinpath(@__DIR__, "..", "deps", "GMAT")
else
    const BASE = joinpath(@__DIR__, "..", "deps", "GMAT", RELEASE)
end
const BIN = joinpath(BASE, "bin")

const DEPS = joinpath(@__DIR__, "..", "deps", "deps.jl")
if isfile(DEPS)
    include(DEPS)
else
    error("GMAT was not found. Please run 'Pkg.build(\"GMAT\").")
end

type GmatError <: Exception end
Base.showerror(io::IO, err::GmatError) = print(io, "GMAT Error: ", last_message());

function start(dir)
    cd(dir) do
        code = ccall((:StartGmat, libCInterface), Cint, ())
        code != 0  && throw(GmatError())
        return code
    end
end
start() = start(BIN)

function load(dir, file)
    cd(dir) do
        code = ccall((:LoadScript, libCInterface), Cint, (Cstring,), file)
        code != 0  && throw(GmatError())
        return code
    end
end
load(path) = load(splitdir(path)...)

function run_summary()
    summary = ccall((:GetRunSummary, libCInterface), Cstring, ())
    unsafe_string(summary)
end

function state_description()
    desc = ccall((:GetStateDescription, libCInterface), Cstring, ())
    desc != C_NULL ? unsafe_string(desc) : ""
end

function state_size()
    ccall((:GetStateSize, libCInterface), Cint, ())
end

function run()
    cd(GMAT_DIR) do
        code = ccall((:RunScript, libCInterface), Cint, ())
        code != 0  && throw(GmatError())
    end
    print_message()
end

function last_message()
    unsafe_string(ccall((:getLastMessage, libCInterface), Cstring, ()))
end
print_message() = info(last_message())

end # module
