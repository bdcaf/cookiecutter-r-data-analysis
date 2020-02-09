#! /usr/bin/env perl
#
# Script that analyses R scripts for loaded data files and linked subreports.
#
use strict;
use warnings;

my $reportdir = $ENV{'REPORTDIR'}; 
my $rfile = qr/.*\.R(md|nw)?$/;
my $copyfile = qr/.*\.(tex|md)$/;

sub rname {
  my ($fname) = @_;
  $fname =~ s#^doc/(.*)\.Rnw$#$reportdir/$1.tex#;
  $fname =~ s#^doc/(.*)\.Rmd$#$reportdir/$1.md#;
  $fname =~ s#^scripts/create_(.*)\.R$#data/$1.RDS#;
  return $fname;
}

sub processr {
  my ($file) = @_;
	if ($file =~ $rfile ) {
		my $name = rname($file);
		my @deps = ();
		open(DATA, '<', $file) or die "Unable to open file $file!";
		while (<DATA>) {
			if (/readRDS\("([^"]+)"\)/){
				push @deps, $1;
			}
		}
		if ((scalar @deps) > 0 ){
			print "$name: ";
			print join " ", @deps;
			print "\n\n";
		}
	}
}

sub copyname {
  my ($fname) = @_;
  $fname =~ s#^doc/(.*)\.R?(tex|md|nw)$#$reportdir/$1.$2#;
  return $fname;
}
sub processcopy {
  my ($file) = @_;
	if ($file =~ $copyfile ) {
		my $name = copyname($file);
		my @deps = ();
		open(DATA, '<', $file) or die "Unable to open file $file!";
		while (<DATA>) {
			if (/\\input\{([^}]+)\}/){
				push @deps, "$1.tex";
			}
			if (/\\include\{([^}]+)\}/){
				push @deps, $1;
			}
		}
		if ((scalar @deps) > 0 ){
			print "$name: ";
			print join " ", @deps;
			print "\n";
		}
	}
}

my @files = @ARGV;
foreach my $file (@files) {
	processr($file);
	processcopy($file);
	if ($file =~ $copyfile){
		# TODO - need to figure how to forward tex dependencies
	}

}
