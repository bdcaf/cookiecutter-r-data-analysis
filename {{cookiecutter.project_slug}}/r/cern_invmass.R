#! /usr/local/bin/R
#
# cern_magnitude.R
# Taken from the CERN R tutorial at
# http://opendata.cern.ch/record/545

invmass = function(px1, px2, py1, py2, pz1, pz2, E1, E2){
  px = px1+px2
  py = py1+py2
  pz = pz1+pz2
  E = E1+E2
  ptotal = magnitude(px, py, pz)
  mass = sqrt(E^2 - ptotal^2)
  return(mass)
}
