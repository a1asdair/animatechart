

framegen using "C:\Users\acr\Dropbox\Academic\Academic-Research-Projects\Stata ADO\animatechart\testdata2.dta", frames(10) over(time) y(y) x(xs) id(idx)

 animatechart using "C:\Users\acr\Dropbox\Academic\Academic-Research-Projects\Stata ADO\", skip  graphcmd(twoway scatter y xs) over(time)

 
 
 /*
 
 
 -r 10 -i "C:\Users\acr\Dropbox\Academic\Academic-Research-Projects\Stata ADO\graph.mpg" -t 10 -r 10 "C:\Users\acr\Dropbox\Academic\Academic-Research-Projects\Stata ADO\graph.gif"
