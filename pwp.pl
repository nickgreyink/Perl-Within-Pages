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
	$page_text =~ s/<pwp//;
	$page_text =~ s/pwp>$//;
	$page_text =~ s/<pwp/";/g;
	$page_text =~ s/pwp>/print"/g;
	return $page_text;
}


my $page_string = "";

my $filename = "";

if(-e "index.pl"){
	$filename = "index.pl";
}elsif(-e "default.pl"){
	$filename = "default.pl";
}elsif ($ARGV[0]){
	$filename = $ARGV[0];
}else{
	print "Index file not found.";
	exit;
}

if ($filename ne '') {
	open(my $fh, '<:encoding(UTF-8)', $filename)
	or die "Could not open file '$filename' $!";
		
	while (my $row = <$fh>) {
		chomp $row;
		$page_string .= $row;
	}
}

eval inline_print($page_string);