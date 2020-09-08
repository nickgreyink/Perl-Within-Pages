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

use Cwd;
use Cwd 'abs_path';
use File::Basename;

# I have it set to use original perl 5.001.
# if it can run there it should be able to
# run in any perl 5.
use 5.001;

# Function to give pages the ability to
# include like PHP
sub pwp_include{
# Gets the file name and short path set to
# the function
	my $page_file = $_[0];

# Initializes the $page_string variable
# to hold the fincal string that gets
# send to the eval function
	my $page_string = "";

# Splits the file argument sent to the
# function into an array
	my @page_file_array = split('/', $page_file);

# Uses the @page_file_array to find the
# last index which is the file name of
# the argument file
	my $page_final_index = $page_file_array[@page_file_array-1];

# Splits the absolute path into array
# elements to be looped through
	my @directory_path = split('/', dirname(abs_path($page_file)));

# Loops through the absolute path to
# find and replace .. in the path
# (the php way to reach into the
# parent directory) for a . (the perl
# way to go into a parent directory) and
# changes . (the PHP way to find in
# the same directory) with nothing
# to look in the same diectory
	for(my $i = 0; $i <= $#directory_path; $i++){
# Find the .. in the path
		if($directory_path[$i] eq ".."){
# Changes the element form .. to .
			$directory_path[$i] = ".";
# Find the . and replaces with nothing
# to find file in the same folder
		}elsif($directory_path[$i] eq "."){
# Replaces . with nothing
			$directory_path[$i] = undef;
		}
	}
# Joins together the revised 
# absolute path to the file
	my $abs_path = join('/', @directory_path) . "/" . $page_final_index;
	if ($abs_path ne '') {
	# open the file
		open(my $fh, '<', $abs_path)
		or die "Could not open file '$abs_path' $!";

	# read each line of the page
	# and add each row to a variable
		while (my $row = <$fh>) {
			chomp $row;
			$page_string = $page_string . $row . "\n";
		}
	}else{
		print "This file does not exist.";
	}
	eval inline_print($page_string);
}

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
# replaces all the other <pwp's with "; to
# end the perl print statement
	$page_text =~ s/<pwp/";/g;
# replaces all the other pwp>'s with
# print" to start a perl print statement
# to include html and othet text
	$page_text =~ s/pwp>/print "/g;

	if(substr($page_text, 0, 4) ne "<pwp"){
		substr($page_text, 0, 0) = 'print "';
	}
	if(substr($page_text, -4, 4) ne "pwp>"){
		$page_text = $page_text . '";';
	}

	$page_text =~ s/\t//g;
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
	#print $filename . "\n";
	open(my $fh, '<:encoding(UTF-8)', $filename)
	or die "Could not open file '$filename' $!";

# read each line of the page
# and add each row to a variable
	while (my $row = <$fh>) {
		chomp $row;
		$page_string = $page_string . $row . "\n";
	}
}

# eval all the string as perl code
eval inline_print($page_string);