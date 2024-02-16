# GenerateStimuli_MasterPC_CSF

Codes for the generation of visual stimuli, and for initiation of CSF experiment of Rosie Craddock 2024 from the Master PC, as described in Rosie Craddock 2024 thesis. 

PC setup/requirements: 

Install MATLAB 2022a

Get code from this repos, save to C:\\Code 

Change the UDPPartners.mat file such that ps.ip points to the IP address of the VS_PC (see setup file for details)

Change the file Code\+data\remote.m such that all instances of '\\ar-lab-nas4\SHARE\DATA\Remote_Repository' point to your data save location

Add C:\\Code and all subdirectories to MATLAB path

Running the experiment: 

Run "rosieProtocol1(animalID, 1, bRosieTesting2023_1)" in MATLAB cmd line where animalID must be in format AAAA123. 


To change the visual stimulus involved in the experiment:

Change Pstate.stims{18} to change the drifttime (in seconds)

Change Pstate.stims{13} to change gratings orientation (in degrees)

Change Pstate.stims{12} to change contrast (1=100%)

Check the Pstate.params to and use approp columns specified there to change position and size of stimulus in pixels, or temporal frequency, where tf= temporal frequency in Hz, duty can be changed, shape and square waveform can be set, all other parameters are currently fixed. 

Shape=1 means sinewave grating with no gaussian window 

Shape=2 means sinewave grating with gaussian window 

Shape=3 can be ignored. 

Shape=4 means full screen window with gaussian window

All other shape values give full screen gratings stimulus with no gaussian window.

If square waveform=1 then the waveform is square, not a sine-wave, if =0, then is sine-wave.

Changing Pstate.globalParamsVals in column 4 and 5 will change the intertrial intervals (in seconds). Column 4 sets the minimum inter trial interval, column 5 sets the maximal interval. In 2023 experiment of RC, both were set to =3, to give a constant iti of 3 seconds.

Pstate.globalParamsVals Column 6 can be ignored, as this refers to the threshold value to record steering wheel movement for the behavioural + 2p experiment. This is the rotary encoder threshold movement value. This was set to 420 ticks in RC pilot experiment. Only of import when using a rotary encoder.

Pstate.globalParamsVals Column 24 sets the number of times the experiment is repeated within a single experiment recording session. 

TODO: 

Create a GUI for creating minimised pFiles, containing only necessary parameters to be read into RosieNewlisten.m and rosie1daq.m and associated matlab files and functions. The GUI should describe each parameter completely. 


Authorship and Contributions: 

All codes have contribution and authorship indicated within the first few lines 

Notably, many of the codes are taken directly from Chris Burgess Rigbox (2013). 


Many codes are either written by, or based on those written by Adam Ranson (2014). 

Hlp_serialize and hlp_deserialize functions were written by Christian Kothe, Swartz Center for Computational Neuroscience, UCSD (2010), and were based on those of Tim Hutt (2010). 

The core experimental code was written by Rosie Craddock, 2024.


Please cite as required on use of the codes in this repository: 

Rigbox: an Open-Source Toolbox for Probing Neurons and Behavior
Jai Bhagat, Miles J. Wells, Andrew Peters, Kenneth D Harris, Matteo Carandini, Christopher P Burgess
bioRxiv 672204; doi: https://doi.org/10.1101/672204

Christian Kothe (2024). Fast serialize/deserialize (https://www.mathworks.com/matlabcentral/fileexchange/34564-fast-serialize-deserialize), MATLAB Central File Exchange. Retrieved February 14, 2024.



