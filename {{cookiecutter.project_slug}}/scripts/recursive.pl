#! /usr/bin/env perl
#
# Short description for recursive.pl
#
# Author Clemens Ager <clemens.ager@gmail.com>
# Version 0.1
# Copyright (C) 2020 Clemens Ager <clemens.ager@gmail.com>
# Modified On 2020-02-08 17:23
# Created  2020-02-08 17:23
#
use strict;
use warnings;

my $rfile = qr/.*\.R(md|nw)?$/;

sub rname{
  my ($fname) = @_;
  $fname =~ s/^doc\/(.*)\.Rmd$/render\/$1.md/;
  $fname =~ s/^doc\/(.*)\.Rnw$/render\/$1.tex/;
  $fname =~ s/^scripts\/create_(.*)\.R$/data\/$1.RDS/;
  return $fname;
}

my @files = @ARGV;
foreach my $file (@files) {
  if ($file =~ $rfile) {
    my $name = rname($file);
    print "$name: ";
    open(DATA, '<', $file) or die "Unable to open file $file!";
    while (<DATA>) {
      if (/readRDS\("([^"]+)"\)/){
	print $1;
      }
    }
    print "\n";
  }
  #print $file . "\n";
}
