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

"""
    start(dir)

Start the GMAT binary located in `dir` and connect to its interface. Needs to be
called before calling any other function in GMAT.jl.
"""
function start(dir)
    cd(dir) do
        code = ccall((:StartGmat, libCInterface), Cint, ())
        code != 0  && throw(GmatError())
        return code
    end
end

"""
    start()

Start standard GMAT binary and connect to its interface. Needs to be
called before calling any other function in GMAT.jl.
"""
start() = start(BIN)

"""
    load(dir, file)

Load the GMAT script `file` located in directory `dir`.
"""
function load(dir, file)
    cd(dir) do
        code = ccall((:LoadScript, libCInterface), Cint, (Cstring,), file)
        code != 0  && throw(GmatError())
        return code
    end
end

"""
    load(dir, file)

Load the GMAT script located at `path`.
"""
load(path) = load(splitdir(path)...)

"""
    run_summary()

Get the summary string for the last GMAT run.
"""
function run_summary()
    summary = ccall((:GetRunSummary, libCInterface), Cstring, ())
    unsafe_string(summary)
end

"""
    state_description()

Get the string describing the elements of the currently loaded state vector.
"""
function state_description()
    desc = ccall((:GetStateDescription, libCInterface), Cstring, ())
    desc != C_NULL ? unsafe_string(desc) : ""
end

"""
    state_size()

Get the size of the currently loaded state vector.
"""
function state_size()
    ccall((:GetStateSize, libCInterface), Cint, ())
end

"""
    run(dir)

Run the script currently loaded in the GMAT instance located at directory `dir`.
"""
function run(dir)
    cd(dir) do
        code = ccall((:RunScript, libCInterface), Cint, ())
        code != 0  && throw(GmatError())
    end
    print_message()
end

"""
    run()

Run the script currently loaded in the standard GMAT instance.
"""
run() = run(BIN)

"""
    last_message()

Get the last status message from GMAT.
"""
function last_message()
    unsafe_string(ccall((:getLastMessage, libCInterface), Cstring, ()))
end
print_message() = info(last_message())

end # module
