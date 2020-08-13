#!/usr/bin/perl

# This is the file you came for.
# Trying to keep it as one file for
# portability.

# Use strict to make sure pwp follows perl
# syntax.
use strict;
# Use warnings to maximum warnings for pwp
# in case it does not work.
use warnings;
# I have it set to use original perl 5.
# if it can run there it should be able to
# run in any perl 5.
use 5.001;

# replaces
# <pwp with ";
# pwp> with print"
# to allow html tp be used

# also removes the first and last pwp's
# to allow page text to be placed in
# variable $page_text
sub inline_print{
# place the text of the page in variable
# $page_text
	my $page_text = $_[0];
# replaces the first instance for <pwp with nothing
# othereise you would not be able to have text
# before you made the first <pwp
	$page_text =~ s/<pwp//;
# replaces the last pwp> with nothing
# or you couldn't have text after your last
# pwp>
	$page_text =~ s/pwp>$//;
# replaces all the other <pwp's with "; to
# end the perl print statement
	$page_text =~ s/<pwp/";/g;
# replaces all the other pwp>'s with
# print" to start a perl print statement
# to include html and othet text
	$page_text =~ s/pwp>/print"/g;
	return $page_text;
}

# just initializes a variable to hold
# the string from the loaded page
my $page_string = "";

# initializes a varaible to hold the
# name of the file being loaded
my $filename = "";

# checks if there is a file called
# imdex.pl in the folder being accessed
# by pwp
if(-e "index.pl"){
	$filename = "index.pl";
}
# checks for default.pl page
elsif(-e "default.pl"){
	$filename = "default.pl";
}
# this will pull the file given to
# pwp.pl through the command line
elsif ($ARGV[0]){
	$filename = $ARGV[0];
}
# if there is no file for the index
# then this will be displayed
else{
	print "Index file not found.";
	exit;
}

# checking if the file to be displayed
# acctually exists
if ($filename ne '') {
	# open the file
	open(my $fh, '<:encoding(UTF-8)', $filename)
	or die "Could not open file '$filename' $!";

# read each line of the page
# and add each row to a variable
	while (my $row = <$fh>) {
		chomp $row;
		$page_string .= $row;
	}
}

# eval all the string as perl code
eval inline_print($page_string);