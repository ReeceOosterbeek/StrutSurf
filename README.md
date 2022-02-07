# StrutSurf
A tool for analysis of strut morphology and surface roughness in additively manufactured lattices

StrutSurf is written in MATLAB and requires the MATLAB Runtime environment (to run the executable installer) or MATLAB and the iso2mesh toolbox (to run the source code) 


## Executable Installer

**Prerequisites for Deployment**

Verify that version 9.9 (R2020b) of the MATLAB Runtime is installed.   
If not, you can download and install the Windows version of the MATLAB Runtime for R2020b from the following link on the MathWorks website:

    https://www.mathworks.com/products/compiler/mcr/index.html
   
For more information about the MATLAB Runtime and the MATLAB Runtime installer, see 
"Distribute Applications" in the MATLAB Compiler documentation in the MathWorks Documentation Center.


## Running from source code

**Prerequisites for Deployment** 

MATLAB (R2020b or later) should be installed according to your system requirements.

Install the iso2mesh toolbox (http://iso2mesh.sf.net) according to the instructions (http://iso2mesh.sourceforge.net/cgi-bin/index.cgi?Doc/Installation)
* Download the iso2mesh toolbox and extract it to a folder
* Add this folder to your MATLAB path using the `pathtool` command

You can then run StrutSurf from the main file StrutSurf.m
