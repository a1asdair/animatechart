

framegen using "C:\Users\acr\Dropbox\Academic\Academic-Research-Projects\Stata ADO\animatechart\testdata2.dta", frames(10) over(time) y(y) x(xs) id(idx)

keep if time<=2004

 animatechart using "C:\Users\acr\Dropbox\Academic\Academic-Research-Projects\Stata ADO\", skip  graphcmd(twoway scatter y xs) over(time) mpeg gif 

 
 
 // Test Data B
 
 framegen using "C:\Users\acr\Dropbox\Academic\Academic-Research-Projects\Stata ADO\animatechart\testdataB.dta", frames(25) over(year) y(wage) id(occupation)



 animatechart using "C:\Users\acr\Dropbox\Academic\Academic-Research-Projects\Stata ADO\testdatab",  graphcmd(twoway line wage occupation) over(year) mpeg consistent y(wage)

 
 
 
 /*  Manual commands for testing
 
 "C:\Program Files\FFmpeg\bin\ffmpeg.exe" -i "C:\Users\acr\Dropbox\Academic\Academic-Research-Projects\Stata ADO\frame_%03d.png" " -b:v 512k fps=10 " "C:\Users\acr\Dropbox\Academic\Academic-Research-Projects\Stata ADO\graph.mpg"



"C:\Program Files\FFmpeg\bin\ffmpeg.exe" -i "C:\Users\acr\Dropbox\Academic\Academic-Research-Projects\Stata ADO\frame_%03d.png" -b:v 512k "C:\Users\acr\Dropbox\Academic\Academic-Research-Projects\Stata ADO\/graph.mpg"
