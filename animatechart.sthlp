{smcl}
{* *! version 1.2.1  07mar2013}{...}
{findalias asfradohelp}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[R] help" "help help"}{...}
{viewerjumpto "Syntax" "examplehelpfile##syntax"}{...}
{viewerjumpto "Description" "examplehelpfile##description"}{...}
{viewerjumpto "Options" "examplehelpfile##options"}{...}
{viewerjumpto "Remarks" "examplehelpfile##remarks"}{...}
{viewerjumpto "Examples" "examplehelpfile##examples"}{...}
{title:Title}

{phang}
{bf:animatechart} {hline 2} Generate a series of graphs from frames, and save them as an animation.


{marker syntax}{...}
{title:Syntax}

{p 8 17 2}
{cmdab:progressbar}
[{cmd:,} {it:options}]

{synoptset 20 tabbed}{...}
{synopthdr}
{synoptline}

{syntab:Required}
{synopt:{opt graphcmd()}}The full graph command for the graph to be generated{p_end}
{synopt:{opt over()}}The discrete variable over which the graphs are drawn{p_end}


{syntab:Optional}
{synopt:{opt consistent}}This is optional, but recommended, and forces the axes to be fixed across frames.
{synopt:{opt y(varname)}}Specifies the y-variable, so that the y-axis can be fixed. Either y() or x() is required if consistent is specified. 
{synopt:{opt x(varname)}}Specifies the x-variable, so that the x-axis can be fixed.
{synopt:{opt graphoptions()}}The options for the overall graph{p_end}
{synopt:{opt exportoptions()}}The options for the exporting of the individual frames{p_end}
{synopt:{opt type()}}The filetype for the individual frames{p_end}
{synopt:{opt graphpath()}}The path for saving the animated graph (if different from using){p_end}
{synopt:{opt mpeg}}Combines the frames into an MPEG video file using the external library FFMPEG{p_end}
{synopt:{opt mpegopt()}}Allows the options for MPEG genration in FFMPEG to be altered (for advanced users){p_end}
{synopt:{opt gif}}Combines the frames into an animated GIF file using the external library FFMPEG{p_end}
{synopt:{opt giftopt()}}Allows the options for GIF generation in FFMPEG to be altered (for advanced users){p_end}
{synopt:{opt ffmpeg()}}Allows the path to the FFMPEG library to be specified if it is not stored in the default location.
{synopt:{opt skip}}Skips generating of the frames and goes straight to animating{p_end}
{synoptline}
{p2colreset}{...}
{p 4 6 2}


{marker description}{...}
{title:Description}

{pstd}
{cmd:animatechart} produces a series of graphs to as frames for animation.  It can either produce a series of image files which can then be incorporated into video software, or it can use the free plug-in FFMPEG to produce either .mpeg or animated .gif files.

{pstd}
{cmd:animatechart} works together with {cmd:framegen}, a command which can produce the data for the intermediate frames.

{marker options}{...}
{title:Options}

{dlgtab:Required}

Only two options are actually mandatory.

{phang}
{opt graphcmd} This is a conventional Stata graph command, expected to be a {cmd:twoway} plot.  It should be the full command preceding the overall graph options.  It will be executed unedited.

{phang}
{opt over()} This specifies the discrete variable over which the graphs are drawn. Ideally it should be an ordered characetristics that links the series of graphs e.g. years.

{dlgtab:Optional}

There are several options that allow you to customise the operation of {cmd:animatechart}

{phang}
{opt consistent} This is optional, but strongly recommended.  It forces that y-axis (and optionally x-axis) to be fixed across all frames.  This will provide much smoother animations.  If consistent is specified, then either (or both) y() or x() must also be specified.

{phang}
{opt graphoptions()} This allows you to specify overall graph options using standard {cmd:twoway} options.  These options will be included unedited.  Specifying axis range() options could interfere with the presentation of the animation.

{phang}
{opt exportoptions()} This allows you to specify any standard options for the {cmd:graph export} command that generates the frames.

{phang}
{opt type()}This specifies the filetype for the exported frames.  The standard file formats available in {cmd:graph export} can be specified.  If you are using FFMPEG to generate the animation you should leav out this option unless you are an advanced user.

{phang}
{opt graphpath()}Specifies the path to save the final animated graph to.  This can be omitted if the path is the same as the path specified in using.

{phang}
{opt mpeg}This option uses FFMPEG to generate a video file in .mpeg format from the graph frames produced.

{phang}
{opt mpegopt()}(For advanced users only) This allows you to manually specify the FFMPEG options.  Documentation for FFMPEG is available separately.

{phang}
{opt gif}This option uses FFMPEG to generate an animated gif file in .gif format from the graph frames produced. This requires first producing an .mpeg file, so specifying the gif option implies the mpeg option.

{phang}
{opt giftopt()}(For advanced users only) This allows you to manually specify the FFMPEG options.  Documentation for FFMPEG is available separately.

{phang}
{opt ffmpeg()}(For advanced users only) This allows you to manually specify the path to the FFMPEG library.  Only required if it is not in the default location: 
"C:\Program Files\FFmpeg\bin\ffmpeg.exe"

{phang}
{opt skip}This option skips generating the frames, allowing you to re-use frame images that were generated earlier.

{phang}
{opt ()}


