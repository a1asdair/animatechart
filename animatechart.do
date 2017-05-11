// Animate
// (c) Alasdair Rutherford
// May 2017


// animatechart


capture prog drop animatechart

program animatechart,

version 11
syntax using/ , graphcmd(string) over(string) [graphoptions(string) exportoptions(string) type(string) graphpath(string) skip]
		
// Check everything is in order

	// Check source datafile exists
		// confirm file "`using'"
		di "`using'"

	// Parameter checking

		confirm variable `over'
		confirm variable frame
		
	// Defaults

		if "`type'"=="" {
			local type = "png"
		}

		if "`graphpath'"=="" {
			local graphpath = "`using'"
		}
	


if "`skip'"=="" {	
	
// Start animating		

	// Work out the range of the frames and over variable

		quietly sum frame
		local fmax = r(max)
		
		quietly sum `over'
		local tmax = r(max)
		local tmin = r(min)

	// Draw the graphs	
	
		local filenum=0

		forvalues tt = `tmin'(1)`tmax' {
			forvalues ff = 1(1)`fmax' {			
				local drawgraph = "`graphcmd'" + " if `over'==`tt' & frame==`ff'" + " , `graphoptions'" + " title(`tt')"
				di "`drawgraph'"
				`drawgraph'
				
				local fnum = string(`filenum', "%03.0f")
				graph export "`using'/frame_`fnum'.`type'", `exportoptions' replace
				local filenum = `filenum' + 1
			}
		}
		
}

	// Create animated GIF
	// Inspired by http://blog.stata.com/2014/03/24/how-to-create-animated-graphics-using-stata/
	di "`graphpath'"
	winexec "C:\Program Files\FFmpeg\bin\ffmpeg.exe" -i "`graphpath'/frame_%03d.png" -b:v 512k "`graphpath'/graph.mpg"
	winexec "C:\Program Files\FFmpeg\bin\ffmpeg.exe" -r 10 -i "`graphpath'graph.mpg" -t 10 -r 10 "`graphpath'graph.gif"
	
		
		
*/		
end
