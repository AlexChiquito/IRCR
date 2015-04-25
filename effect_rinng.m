function result=effect_rinng(x)
% Fs=8000;
global fs;
index = 1:length(x);
% Ring Modulate with a sine wave frequency Fc
Fc = 440;
carrier= sin(2*pi*index*(Fc/fs));
% Do Ring Modulation
carrie=transpose(carrier);
result = x.*carrie;
