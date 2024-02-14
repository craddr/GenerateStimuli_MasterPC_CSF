# GenerateStimuli_MasterPC_CSF

Codes for the generation of visual stimuli, and for initiation of CSF experiment of Rosie Craddock 2024 from the Master PC, as described in Rosie Craddock 2024 thesis. 

PC setup/requirements: 
Install MATLAB 2022a
Get code from this repos, save to C:\\Code 
Change the UDPPartners.mat file such that ps.ip points to the IP address of the VS_PC (see setup file for details)
Change the file Code\+data\remote.m such that all instances of '\\ar-lab-nas4\SHARE\DATA\Remote_Repository' point to your data save location
Add C:\\Code and all subdirectories to MATLAB path

Running the experiment: 
Run "rosieProtocol1(animalID, 1, bRosieTesting2023_1)" in MATLAB cmd line
where animalID must be in format AAAA123. 

Some codes here are written by others. All codes have contribution and authorship indicated within the first few lines 
Notably, many of the codes are taken from Chris Burgess Rigbox (2013). Many codes are either written by, or based on those written by Adam Ranson (2014). 
Hlp_serialize and hlp_deserialize functions were written by Christian Kothe, Swartz Center for Computational Neuroscience, UCSD (2010), and were based on those of Tim Hutt (2010). 

The core experimental code was written by Rosie Craddock, 2024.

