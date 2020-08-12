#!/usr/bin/perl

use strict;
use warnings;
use 5.001;

sub inline_print {
	my $thing = $_[0];
	$thing =~ s/<pwp//;
	$thing =~ s/pwp>$//;
	$thing =~ s/<pwp/";/g;
	$thing =~ s/pwp>/print"/g;
	return $thing;
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

print inline_print($page_string);