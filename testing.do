

framegen using "C:\Users\acr\Dropbox\Academic\Academic-Research-Projects\Stata ADO\animatechart\testdata2.dta", frames() over(time) y(y) id(x)

 animatechart using "C:\Users\acr\Dropbox\Academic\Academic-Research-Projects\Stata ADO", graphcmd(twoway scatter y xs) over(time)
