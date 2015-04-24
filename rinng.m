
Fs=8000;
N=8;
x=reco;
index = 1:length(x);
% Ring Modulate with a sine wave frequency Fc
Fc = 440;
carrier= sin(2*pi*index*(Fc/Fs));
% Do Ring Modulation
carrie=transpose(carrier);
yr = x.*carrie;
