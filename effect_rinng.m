function result=effect_rinng(x)
% Fs=8000;
global fs;
index = 1:length(x);
% Modulacion ring con una onda senoidal de frecuencia Fc
Fc = 440;
carrier= sin(2*pi*index*(Fc/fs));
% Se multiplica el seno por la señal
carrie=transpose(carrier);
result = x.*carrie;
