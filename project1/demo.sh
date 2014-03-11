#!/bin/bash
cp ./initPts2.mat.circle initPts2.mat
octave ./activeContour.m
cp ./initPts2.mat.cloud initPts2.mat
octave ./activeContour.m
cp ./initPts2.mat.star_typical initPts2.mat
octave ./activeContour.m
cp ./initPts2.mat.star_okay initPts2.mat
octave ./activeContour.m
cp ./initPts2.mat.star_circlish initPts2.mat
octave ./activeContour.m
