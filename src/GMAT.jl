module GMAT

using Pkg.Artifacts

using GMAT_jll

export run_script

include("startup_file.jl")

"""
	run_script(script;
		data=joinpath(artifact"data", "gmat-data-2020a"),
		output=joinpath(pwd(), "gmat-output"),
	)

Run a GMAT `script` while optionally specifying the path to the `data` package and an
`output` directory. The function will return a list of output files.

### References

- [GMAT Documentation](http://gmat.sourceforge.net/docs/R2020a/html/index.html)
"""
function run_script(script;
	data=joinpath(artifact"data", "gmat-data-2020a"),
	output=joinpath(pwd(), "gmat-output"),
)
	# Create output dir if it does not exist
	isdir(output) || mkpath(output)
	# Write the GMAT startup file to a temp file
	startup = tempname()
	open(startup, "w") do f
		write(f, startup_file(data, output))
	end
	gmatconsole() do exe
		run(`$exe -s $startup -r $script`)
	end
	return readdir(output)
end

end # module
