function resultado=effect_distortion(x)
gain = 11; % Gain de la distorcion
mix = 1; % para hacer mix entre la funcion original y la distorcionada (1 para solo oir la distorcionada)

q=x*gain/max(abs(x)); %aplicamos las ecuaciones del efecto
z=sign(-q).*(1-exp(sign(-q).*q));
yd=mix*z*max(abs(x))/max(abs(z))+(1-mix)*x;
%normalizar la salida
resultado=yd*max(abs(x))/max(abs(yd));
