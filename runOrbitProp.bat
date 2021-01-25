@echo off
title Batch script to execute orbit propagator
matlab -nosplash -nodesktop -r "try; cd('C:\Users\rgsim\Documents\MATLAB\OrbitProp'); err = main; if ~isempty(err); rethrow(err); end; catch err; rethrow(err); end"