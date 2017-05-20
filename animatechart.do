// Animate
// (c) Alasdair Rutherford
// May 2017


// animatechart


capture prog drop animatechart

program animatechart,

version 11
syntax using/ , graphcmd(string) over(string) [graphoptions(string) exportoptions(string) type(string) graphpath(string) mpeg mpegopt(string) gif gifopt(string) ffmpeg(string) consistent y(string) x(string) skip progress ]
		
// Check everything is in order

	set more off

	// Check source datafile exists
		// confirm file "`using'"
		di "`using'"
		di "`ffmpeg'"


	// Parameter checking

		confirm variable `over'
		confirm variable frame
		
	// Work out the range of the frames and over variable

		quietly sum frame
		local fmax = r(max)	
		
	// Defaults

		if "`type'"=="" {
			local type = "png"
		}

		if "`graphpath'"=="" {
			local graphpath = "`using'"
		}
		
		if "`mpegopt'"=="" {
			local mpegopt = "-b:v 512k"
		}
		
		if "`gifopt'" == "" {
			local gifopt = "-t 10 -r 10"
		}
		
		if "`ffmpeg'"=="" {
			local ffmpeg = "C:\Program Files\FFmpeg\bin\ffmpeg.exe"
		}
		

		
	// Check that FFMPEG is installed		
		capture confirm file "`ffmpeg'"
		
		if _rc!=0 {
			di in red "FFMPEG not found; please specify the correct path in ffmpeg()"
			exit
		}


if "`skip'"=="" {	
	
// Start animating		


	// Calculate range of key frames
		
		quietly sum `over'
		local tmax = r(max)
		local tmin = r(min)
		
	
	// Set up consistent axes
	
		if "`consistent'"!="" & "`y'" != "" {
			di "Consistent Y"
			quietly sum `y'
			local ymax = ceil(r(max))		
			local ymin = floor(r(min))		
			local consyaxes = " yscale(range(`ymin' `ymax')) "
			di "`consyaxes'"
			
		}
		
		if "`consistent'"!="" & "`x'" != "" {
			di "Consistent X"
			quietly sum `x'
			local xmax = ceil(r(max))		
			local xmin = floor(r(min))		
			local consxaxes = " xscale(range(`xmin' `xmax')) "
			di "`consxaxes'"
			
		}
		

	// Draw the graphs	

	
		if "`progress'" !="" {
			progressbar, init start(`tmin' 1) end(`tmax' `fmax') type(v v) time
		}
	
		local filenum=0

		forvalues tt = `tmin'(1)`tmax' {
			forvalues ff = 1(1)`fmax' {	
				
				if "`progress'" !="" {
					progressbar, time
				}
			
				local drawgraph = "`graphcmd'" + " if `over'==`tt' & frame==`ff'" + " , `graphoptions'" + " title(`tt') " + " `consyaxes' `consxaxes' "
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
		


		if "`gif'"!="" {
			di "mpeg: `mpeg' `mpegopt'  |  gif: `gif' `gifopt'  "
			
			// local mpegcmd = " -i `"`graphpath'/frame_%03d.png"' `mpegopt'  `"`graphpath'/graph.mpg"' "
			// di "`mpegcmd'"
			// shell `mpegcmd'
			shell "`ffmpeg'" -i "`graphpath'/frame_%03d.png" `mpegopt' "`graphpath'/graph.mpg"
			winexec "`ffmpeg'" -r 10 -i "`graphpath'/graph.mpg" `gifopt' "`graphpath'/graph.gif"
		}
		else {		
			if "`mpeg'"!="" {
				di "mpeg: `mpeg'  |  gif: `gif'  "
				winexec "`ffmpeg'" -i "`graphpath'/frame_%03d.png" `mpegopt' "`graphpath'/graph.mpg"
			}
		}
		
		
*/		
end
