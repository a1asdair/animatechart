// Animate
// (c) Alasdair Rutherford
// May 2017


// framegen


capture prog drop framegen

program framegen,

version 11
syntax using/ , frames(integer) over(string) y(string) [x(string)] id(string) [gen(string) quad debug]

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

	if "`quad'" == "" {
	
		// Linear smoothing
		
			// Linear smoothing of y
				local smooth = 1/(`frames'+1)		
				forvalues ff = 2(1)`frames' {
					quietly replace `y'`ff' = ((1- (`smooth'*`ff'))*`y'`ff')  +   (`smooth' * `ff' * `y'1[_n+1])
				}	

			// Linear smoothing of x
				if "`x'"!="" {
					local smooth = 1/(`frames'+1)		
					forvalues ff = 2(1) `frames' {
						quietly replace `x'`ff' = ((1- (`smooth'*`ff'))*`x'`ff')  +   (`smooth' * `ff' * `x'1[_n+1])
					}
				}
	}
	else {
	
		// Quadratic smoothing
		
				// Quadratic smoothing of y
					// Calculate denominator
					local quadtotal = 0
					forvalues jj = 1(1)`frames' {
						local quadtotal = `quadtotal' + ((`frames'+1) * `jj') - `jj'^2
					}
						if "`debug'" != "" {
							gen qtotaly=`quadtotal'
						}					
					// and then smooth
					forvalues ff = 2(1) `frames' {
						// Smooth formula is a + (b - a)*y[i] where a is time t and b time t+1, y[i] is the smoothing factor at frame i
						local ffn = `ff' - 1
						quietly replace `y'`ff' = `y'`ffn' + (`y'1[_n+1]  - `y'1) * ( (((`frames'+1)*`ff') - `ff'^2) / `quadtotal')
						
							if "`debug'" != "" {
								gen qdify`ff' = ( (((`frames'+1)*`ff') - `ff'^2) / `quadtotal')
							}
		
					}	
					
				// Quadratic smoothing of x				
				if "`x'"!="" {
					// Calculate denominator
					local quadtotal = 0
					forvalues jj = 1(1)`frames' {
						local quadtotal = `quadtotal' + ((`frames'+1) * `jj') - `jj'^2
					}
						if "`debug'" != "" {
							gen qtotalx=`quadtotal'
						}					
					// and then smooth
					forvalues ff = 2(1) `frames' {
						// Smooth formula is a + (b - a)*y[i] where a is time t and b time t+1, y[i] is the smoothing factor at frame i
						local ffn = `ff' - 1
						quietly replace `x'`ff' = `x'`ffn' + (`x'1[_n+1]  - `x'1) * ( (((`frames'+1)*`ff') - `ff'^2) / `quadtotal')
						
							if "`debug'" != "" {
								gen qdifx`ff' = ( (((`frames'+1)*`ff') - `ff'^2) / `quadtotal')
							}							
					}
				}
				
		
		
	}
		

	// Reshape dataset back again	
	
			if "`debug'" != "" {
				local debugreshape = "qdify"
				if "`x'"!="" {
					local debugreshape = "`debugreshape' qdifx"
				}								
			}
	
		quietly reshape long `y' `x' `debugreshape', i(`over' `id') j(frame)

		
// Reporting and finish up		
		
	// Report back to user
		di "Generated `frames' frames per `over', for a total of " `frames' * (`tmax' - `tmin') " frames."


	// Optionally, save the dataset with frames
		if "`gen'"!="" {				
			save "`gen'", replace
		}
	
		
		
end
