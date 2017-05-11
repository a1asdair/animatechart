// Animate
// (c) Alasdair Rutherford
// May 2017


// animatechart


capture prog drop animatechart

program animatechart,

version 11
syntax using/ , graphcmd(string) graphoptions(string) over(varname)

// frames(#) How many frames to generate
// time(var) the time variable for sequential plots
// y(var) the variable to smooth
// dataset() path to the dataset
// gen() output dataset



// Parameter checking


di "`using'"

		quietly sum frame
		local fmax = r(max)
		
		quietly sum `over'
		local tmax = r(max)
		local tmin = r(min)

		// local cmd = "twoway scatter y x, over(z)"
		local comma = strpos("`cmd'",",")

forvalues tt = `tmin'(1)`tmax' {
	forvalues ff = 1(1)`fmax' {
		
		// local drawgraph = substr("`cmd'",1,`comma'-1) + " if `over'==`tt' & frame==`ff'" + substr("`cmd'",`comma',strlen("`cmd'"))
		local drawgraph = "`graphcmd'" + " if `over'==`tt' & frame==`ff'" + "`graphoptions'"
		di "`drawgraph'"
		`drawgraph'
	}
}

		
end
