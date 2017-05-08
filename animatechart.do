// Animate
// (c) Alasdair Rutherford
// May 2017


// animchart


capture prog drop animchart

program animchart,

version 11
syntax , frames() time() y() dataset()

// frames(#) How many frames to generate
// time(var) the time variable for sequential plots
// y(var) the variable to smooth
// dataset() path to the dataset


Load in the dataset
sort by the time variable
tsset
