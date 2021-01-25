@echo off
title Batch script to execute orbit propagator
matlab -nosplash -nodesktop -log -r "try; cd('C:\Users\rgsim\Documents\MATLAB\OrbitProp'); main; catch; end"