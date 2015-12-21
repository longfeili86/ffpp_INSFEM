eval 'exec perl -S $0 ${1+"$@"}'
if 0;
#!/usr/bin/perl
# perl program to generate runScript for ff++_INSFEM
#  usage: 
#         generateRunScript -outputDir=<> -runName=<> -mu=<> -rho=<> ....
#


use Getopt::Long qw(GetOptions);


# default ff++_INSFEM parameter values
$outputDir_Val = "";
$runName_Val = "testRun";
$mu_Val = 0.1;
$rho_Val = 1.0;
$tf_Val = 0.1;
$t0_Val = 0.0;
$cfl_Val = 0.5;
$ts_Val = "IMEXPC";
$dd_Val = "true";
$NS_Val = "true";
$WABE_Val="true"; 
$quadOrder_Val=10;
$vSOLVER_Val="UMFPACK";
$pSOLVER_Val="UMFPACK";
$pn_Val=1;
$meshName_Val = "disk";
$splitNumber_Val = 1;
$tplot_Val=0.05;
$isPlot_Val="true";
$vwait_Val ="false";
$vfill_Val = "true";   
$vvalue_Val = "true";  
$saveDataForMATLAB_Val="true";
$isTwilightzone_Val = "true";
$funcDefFILE_Val ="tzTrig1Functions.edp";
$a_Val=0.1;
$fx_Val=1.;
$fy_Val=1.;
$ft_Val=1.2;




GetOptions('cmd=s'=>\$cmdFile,'grid=s'=>\$gN);






$filename = $runName_Val."_runScript.edp";
$timeString = localtime();
open($OUTFILE,'>',$filename);     #> overwrite, >> append
print $OUTFILE "/*
This script was gerenerated by generateRunScript.pl  
============================================================================
 To run with different options, one can use generateRunScript.pl to genererate a new runScript or
 make a copy of this file  and modify the option.
============================================================================

$timeString
*/";
print $OUTFILE "
\n
\n
// define output location to store results:
string outputDir = \"$outputDir_Val\"; // empty to store in 'pwd'
string runName = \"$runName_Val\"\;   // folder name for the output data, can not be empty
\n
// physical parameters
real mu=$mu_Val;
real rho=$rho_Val;
\n
// PDE options
real tf=$tf_Val; // finial time
real t0=$t0_Val; // initial time
real cfl=$cfl_Val; // fraction of the computed dt to use, i.e., dt = cfl*dt;
string ts=\"$ts_Val\"; // time-stepping method. Support: FE,AB2,PC2, IMEX, IMEXPC
bool dd=$dd_Val; // divergence damping option
bool NS =$NS_Val; // Navier-Stokes or Stokes
bool WABE=$WABE_Val; // WABE or TN pressure boundary conditions
int  quadOrder=$quadOrder_Val; // order of quadrature formula for integration
macro vSOLVER $vSOLVER_Val //EOM //solver for velocity
macro pSOLVER $pSOLVER_Val //EOM //solver for pressure
macro Pn P$pn_Val //EOM //use Pn finite-element space. P1,...,P4
int pn = $pn_Val; //need to specify pn in int as well due to FF++ syntax
\n
// mesh options
string meshName = \"$meshName_Val\"; //name of the mesh. A meshName.msh file must be created first in mesh/
int splitNumber = $splitNumber_Val; // split each side of a triangle into splitNumber pieces. specify 1 for no splitting. This is used for mesh refinement
\n
// plot options
real tplot=$tplot_Val; // plot frequency
bool isPlot=$isPlot_Val; // plot option
bool vwait=$vwait_Val; // plot with wait or not
bool vfill=$vfill_Val; // fill the plot or not
bool vvalue=$vvalue_Val; // show the colorbar with values or not
bool saveDataForMATLAB=$saveDataForMATLAB_Val; // write data into matlab format or not
\n
// twilightzone options.
bool isTwilightzone=$isTwilightzone_Val;
\n
// specify the name of the .edp file that defines TZ functions if TZ tests
// otherwise the file name that defines initial and boundary functions.
// TZ functions definition file can be generated using twilightzonePreparation.m
// icbc functions definition file can be generated using icbcPreparation.m
\n
macro funcDefFILE()  \"$funcDefFILE_Val\" //EOM  //modify the file name between quotes
\n
// trig parameters
real a=$a_Val;
real fx=$fx_Val;
real fy=$fy_Val;
real ft=$ft_Val;
\n
\n
\n
//*********** DO NOT MODIFY BELOW:***************
include \"setup.edp\"

";











close $OUTFILE; 






