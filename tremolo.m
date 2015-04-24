% read the sample wavefor
% create triangular wave LFO
x=reco;
delta=5e-4;
minf=-0.5;
maxf=0.5;
trem=minf:delta:maxf;
while(length(trem) < length(x) )
trem=[trem (maxf:-delta:minf)];
trem=[trem (minf:delta:maxf)];
end
%trim trem
trem = trem(1:length(x));
%Ring mod with triangular, trem
tremo=transpose(trem);
yt= x.*tremo;
