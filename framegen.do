// Animate
// (c) Alasdair Rutherford
// May 2017


// framegen


capture prog drop framegen

program framegen,

version 11
syntax using/ , frames(integer) over(string) y(string) [x(string)] id(string) [gen(string)] /// [quad(integer)] /// [debug()]

// frames(#) How many frames to generate
// over(var) the time variable for sequential plots
// y(var) the variable to smooth
// x(var) optionally smooth over x as well
// using path to the dataset
// gen() output dataset
// id() the variable denoting the same unit of observation


// Check everything is in order

	// Check source datafile exists
		confirm file "`using'"
		di "`using'"

	// Load the dataset
		use "`using'", clear

	// Parameter checking

		confirm variable `y'
		confirm variable `over'
		confirm variable `id'
		if "`x'"!="" {
			confirm variable `x'
		}
		
		
// Create additional copies of observations for frames


	// Work out the range of the over variable
		quietly sum `over'
		local tmax = r(max)
		local tmin = r(min)

	// Generate the observations for frames
		gen frame = 1
		forvalues ff = 2(1) `frames' {
			quietly append using "`using'",
			quietly replace frame = `ff' if frame==.
		}

// Smoothing ...		
		
	// Reshape for smoothing
		quietly reshape wide `y' `x' , i(`over' `id') j(frame)
		quietly sort `id' `over'
			
	// Linear smoothing of y
		local smooth = 1/(`frames'+1)		
		forvalues ff = 2(1) `frames' {
			quietly replace `y'`ff' = ((1- (`smooth'*`ff'))*`y'`ff')  +   (`smooth' * `ff' * `y'1[_n+1])
		}	

	// Linear smoothing of x
		if "`x'"!="" {
			local smooth = 1/(`frames'+1)		
			forvalues ff = 2(1) `frames' {
				quietly replace `x'`ff' = ((1- (`smooth'*`ff'))*`x'`ff')  +   (`smooth' * `ff' * `x'1[_n+1])
			}
		}
		

	// Reshape dataset back again	
		quietly reshape long `y' `x', i(`over' `id') j(frame)

		
// Reporting and finish up		
		
	// Report back to user
		di "Generated `frames' frames per `over', for a total of " `frames' * (`tmax' - `tmin') " frames."


	// Optionally, save the dataset with frames
		if "`gen'"!="" {				
			save "`gen'", replace
		}
	
		
		
end
