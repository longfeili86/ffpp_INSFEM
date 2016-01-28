#!/usr/bin/perl
# perl program to conduct convergence test for twilightzone tests
#  usage: 
#         convRate 
#
#  by Longfei Li 12212015

@ARGV;





for($i=0;$i<5;$i++)
{
    $sn = 2**$i;
    $cmd = "generateRunScript.pl @ARGV -splitNumber=$sn -run=true";
    print "run: $cmd\n";
    system($cmd);
    
}
