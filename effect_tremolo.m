function yt=effect_tremolo(x)

% creamos una onda triangular 
delta=5e-4;
minf=-0.5;
maxf=0.5;
trem=minf:delta:maxf;
while(length(trem) < length(x) )
    trem=[trem (maxf:-delta:minf)];
    trem=[trem (minf:delta:maxf)];
end
%cortamos el triangulo del tama�o de la se�al
trem = trem(1:length(x));
%Modulamos la amplitud de la se�al con la onda triangular
yt = x.*transpose(trem);
