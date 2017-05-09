// Animate
// (c) Alasdair Rutherford
// May 2017


// animatechart


capture prog drop animatechart

program animatechart,

version 11
syntax using/ , frames(integer) over(varname) y(varname) id(varname) [gen(string)]

// frames(#) How many frames to generate
// time(var) the time variable for sequential plots
// y(var) the variable to smooth
// dataset() path to the dataset
// gen() output dataset



// Parameter checking


di "`using'"


// Create additional copies of observations for frames



// Test parameters

/*
local dataset = "C:\Users\ar34\Dropbox\Academic\Academic-Research-Projects\Stata ADO\animatechart\testdata.dta"
local time = "time"
local frames = 5
local y = "y"
local id = "x"
local gen = "C:\Users\ar34\Dropbox\Academic\Academic-Research-Projects\Stata ADO\animatechart\animatedata.dta"
*/

		// Load the dataset

		use "`using'", clear
		
		// Work out the range of time
		quietly sum `over'
		local tmax = r(max)
		local tmin = r(min)

		// Generate the observations for frames
		gen frame = 1
		forvalues ff = 2(1) `frames' {
			quietly append using "`using'",
			quietly replace frame = `ff' if frame==.
		}

		// Reshape for smoothing
		quietly reshape wide `y' , i(`over' `id') j(frame)
		quietly sort `id' `over'
		
		// Linear smoothing
		local smooth = 1/(`frames'+1)		
		forvalues ff = 2(1) `frames' {
			quietly replace `y'`ff' = ((1- (`smooth'*`ff'))*`y'`ff')  +   (`smooth' * `ff' * `y'1[_n+1])
		}												

		// Reshape dataset back again	
		quietly reshape long `y' , i(`over' `id') j(frame)

		// Report back to user
		di "Generated `frames' frames per `over', for a total of " `frames' * (`tmax' - `tmin') " frames."


		// Optionally, save the dataset with frames
		if "`gen'"!="" {				
			save "`gen'", replace
		}
	
		
		
end
