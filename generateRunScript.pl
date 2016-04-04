eval 'exec perl -S $0 ${1+"$@"}'
if 0;
#!/usr/bin/perl
# perl program to generate runScript for ff++_INSFEM
#  usage: 
#         generateRunScript -outputDir=<> -runName=<> -mu=<> -rho=<> ....
#
#  by Longfei Li 12/18/2015

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
$useExDt_Val = "false";
$dd_Val = "true";
$NS_Val = "true";
$WABE_Val="true"; 
$quadOrder_Val=10;
$vSOLVER_Val="UMFPACK";
$pSOLVER_Val="UMFPACK";
$pn_Val=1;
$meshName_Val = "square";
$splitNumber_Val = 1;
$tplot_Val=0.05;
$isPlot_Val="true";
$vwait_Val ="false";
$vfill_Val = "true";   
$vvalue_Val = "true";  
$saveDataForMATLAB_Val="true";
$isTwilightzone_Val = "true";
$funcDefFILE_Val ="tzTrig1Functions";
$a_Val=.5;
$fx_Val=2.;
$fy_Val=2.;
$ft_Val=2.;
$periodic_Val = "false";  

$run_Val="false"; # run ff++ or not.

GetOptions('outputDir=s'=>\$outputDir_Val,'runName=s'=>\$runName_Val,'mu=f'=>\$mu_Val,'rho=f'=>\$rho_Val,
'tf=f'=>\$tf_Val,'t0=f'=>\$t0_Val,'cfl=f'=>\$clf_Val,'ts=s'=>\$ts_Val,'useExDt=s'=>\$useExDt_Val,'dd=s'=>\$dd_Val,
'NS=s'=>\$NS_Val,'WABE=s'=>\$WABE_Val,'quadOder=i'=>\$quadOder_Val,'vSOLVER=s'=>\$vSOLVER_Val,
'pSOLVER=s'=>\$pSOLVER_Val,'pn=i'=>\$pn_Val,'meshName=s'=>\$meshName_Val,'splitNumber=i'=>\$splitNumber_Val,
'tplot=f'=>\$tplot_Val,'isPlot=s'=>\$isPlot_Val,'vwait=s'=>\$vwait_Val,'vfill=s'=>\$vfill_Val,'vvalue=s'=>\$vvalue_Val,
'saveDataForMATLAB=s'=>\$saveDataForMATLAB_Val,'isTwilightzone=s'=>\$isTwilightzone_Val,
'funcDefFILE=s'=>\$funcDefFILE_Val,'a=f'=>\$a_Val,'fx=f'=>\$fx_Val,'fy=f'=>\$fy_Val,'ft=f'=>\$ft_Val, 'run=s'=>\$run_Val,'periodic=s'=>\$periodic_Val);

# update some other variables
$VH_Val = "Vh(Th,Pn)";
if($periodic_Val eq "true")
{
    $VH_Val = "Vh(Th,Pn,periodic=[[2,y],[4,y]])";
    print "INFO:\n";
    print "use periodic bc for the left and right side of the square\n";
    print "I'm not checking if the problem makes sense. \n";
    print "Make sure the exact solution is periodic in [0,1] in x direction if run  TZtests\n";
}
#check validity for the input values
# here smartmatch is used. This feature is in perl experiment. Not supported for older version perl or could be
# unsuppoted for future versions of perl. 
# @tsAcceptable = ('FE','AB2','PC2','IMEX','IMEXPC');
# @boolAcceptable = ('true','false');
# no warnings 'experimental::smartmatch';
# if(!($ts_Val~~@tsAcceptable))
# {
#     print "Perl Error: ts=$ts_Val is unacceptable. Supported values are:\n";
#     print "@tsAcceptable\n";
#     exit;
# }
# if(!($dd_Val~~@boolAcceptable))
# {
#     print "Perl Error: dd=$dd_Val is unacceptable. Supported values are:\n";
#     print "@boolAcceptable\n";
#     exit;
# }
# if(!($NS_Val~~@boolAcceptable))
# {
#     print "Perl Error: NS=$NS_Val is unacceptable. Supported values are:\n";
#     print "@boolAcceptable\n";
#     exit;
# }
# if(!($WABE_Val~~@boolAcceptable))
# {
#     print "Perl Error: WABE=$WABE_Val is unacceptable. Supported values are:\n";
#     print "@boolAcceptable\n";
#     exit;
# }
# if(!($isPlot_Val~~@boolAcceptable))
# {
#     print "Perl Error: isPlot=$isPlot_Val is unacceptable. Supported values are:\n";
#     print "@boolAcceptable\n";
#     exit;
# }
# if(!($vwait_Val~~@boolAcceptable))
# {
#     print "Perl Error: vwait=$vwait_Val is unacceptable. Supported values are:\n";
#     print "@boolAcceptable\n";
#     exit;
# }
# if(!($vfill_Val~~@boolAcceptable))
# {
#     print "Perl Error: vfill=$vfill_Val is unacceptable. Supported values are:\n";
#     print "@boolAcceptable\n";
#     exit;
# }
# if(!($vvalue_Val~~@boolAcceptable))
# {
#     print "Perl Error: vvalue=$vvalue_Val is unacceptable. Supported values are:\n";
#     print "@boolAcceptable\n";
#     exit;
# }
# if(!($saveDataForMATLAB_Val~~@boolAcceptable))
# {
#     print "Perl Error: saveDataForMATLAB=$saveDataForMATLAB_Val is unacceptable. Supported values are:\n";
#     print "@boolAcceptable\n";
#     exit;
# }
# if(!($isTwilightzone_Val~~@boolAcceptable))
# {
#     print "Perl Error: isTwilightzone=$isTwilightzone_Val is unacceptable. Supported values are:\n";
#     print "@boolAcceptable\n";
#     exit;
# }
# if(!($run_Val~~@boolAcceptable))
# {
#     print "Perl Error: run=$run_Val is unacceptable. Supported values are:\n";
#     print "@boolAcceptable\n";
#     exit;
# }



$suffix = ".edp";
if (index($funcDefFILE_Val, $suffix) == -1) {
    # print "perl: adding $suffix to $funcDefFILE_Val\n";
    $funcDefFILE_Val =$funcDefFILE_Val.$suffix;
} 





$fileName = $runName_Val."_runScript.edp";
$timeString = localtime();
open($OUTFILE,'>',$fileName) || die "cannot open file $fileName!" ;     #> overwrite, >> append
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
bool useExDt = $useExDt_Val;  // use the same dt as Explicit methods for IMEX methods				     
bool dd=$dd_Val; // divergence damping option
bool NS =$NS_Val; // Navier-Stokes or Stokes
bool WABE=$WABE_Val; // WABE or TN pressure boundary conditions
int  quadOrder=$quadOrder_Val; // order of quadrature formula for integration
macro vSOLVER $vSOLVER_Val //EOM //solver for velocity
macro pSOLVER $pSOLVER_Val //EOM //solver for pressure
macro Pn P$pn_Val //EOM //use Pn finite-element space. P1,...,P4
int pn = $pn_Val; //need to specify pn in int as well due to FF++ syntax
bool periodic = $periodic_Val; // use periodic bc on left and right sides of unit square
macro VH $VH_Val  //EOM //define fespace
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

print "runScript generated: $fileName \n";


if($run_Val eq "true")
{
    print "run: FreeFEM++ $fileName\n";
    system("FreeFEM++",$fileName) ;
}



