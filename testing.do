

framegen using "C:\Users\acr\Dropbox\Academic\Academic-Research-Projects\Stata ADO\animatechart\testdatab-AR-20May17.dta", frames(30) over(year) y(y) x(x) id(id)

// keep if time<=2004

 animatechart using "C:\Users\acr\Dropbox\Academic\Academic-Research-Projects\Stata ADO\testdataa",   graphcmd(twoway scatter y x) over(year) mpeg progress consistent

 
 
 // Test Data B
 
 framegen using "C:\Users\acr\Dropbox\Academic\Academic-Research-Projects\Stata ADO\animatechart\testdataB.dta", frames(25) over(year) y(wage) id(occupation)



 animatechart using "C:\Users\acr\Dropbox\Academic\Academic-Research-Projects\Stata ADO\testdatab",  graphcmd(twoway line wage occupation) over(year) mpeg consistent y(wage) progress

 
 // Test Data C
 
 framegen using "C:\Users\acr\Dropbox\Academic\Academic-Research-Projects\Stata ADO\animatechart\testdataB.dta", frames(24) over(year) y(wage) id(occupation) quad  debug



 animatechart using "C:\Users\acr\Dropbox\Academic\Academic-Research-Projects\Stata ADO\testdatac",  graphcmd(twoway line wage occupation) over(year) mpeg consistent y(wage) progress

 
 
 
 /*  Manual commands for testing
 
 "C:\Program Files\FFmpeg\bin\ffmpeg.exe" -i "C:\Users\acr\Dropbox\Academic\Academic-Research-Projects\Stata ADO\frame_%03d.png" " -b:v 512k fps=10 " "C:\Users\acr\Dropbox\Academic\Academic-Research-Projects\Stata ADO\graph.mpg"



"C:\Program Files\FFmpeg\bin\ffmpeg.exe" -i "C:\Users\acr\Dropbox\Academic\Academic-Research-Projects\Stata ADO\frame_%03d.png" -b:v 512k "C:\Users\acr\Dropbox\Academic\Academic-Research-Projects\Stata ADO\/graph.mpg"
