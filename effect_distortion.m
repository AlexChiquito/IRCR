function resultado=effect_distortion(x)
gain = 20; % Spinal Tap it
mix = 1; % Hear only fuzz
% y=fuzzexp(x, gain, mix)
% Distortion based on an exponential function
% x - input
% gain - amount of distortion, >0->
% mix - mix of original and distorted sound, 1=only distorted
q=x*gain/max(abs(x));
z=sign(-q).*(1-exp(sign(-q).*q));
yd=mix*z*max(abs(x))/max(abs(z))+(1-mix)*x;
resultado=yd*max(abs(x))/max(abs(yd));
