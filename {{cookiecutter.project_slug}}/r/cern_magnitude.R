#! /usr/local/bin/R
#
# cern_magnitude.R
# Taken from the CERN R tutorial at
# http://opendata.cern.ch/record/545

magnitude = function(x, y, z) {
  m = sqrt(x^2 + y^2 + z^2)
  return(m)
}
