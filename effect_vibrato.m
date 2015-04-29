function yv=effect_vibrato(x)
% Vibrato 
frecmod=10;
ancho=0.0008;
ya_alt=0;
Delay=ancho; % delay de la entrada en un segundo
DELAY=round(Delay*fs); % delay basico en un numero de muestras
ANCHO=round(ancho*fs); % ancho de modulacion en un numero de muestras

FRECMOD=frecmod/fs; % Frecuencia de modulacion en un numero de muestras
largo=length(x);        % numero de muestras de la señal
L=2+DELAY+ANCHO*2;    % largo del delay entero
vectordelay=zeros(L,1); % vector del delay
yv=zeros(size(x));     % vector de la salida

%aplicamos algoritmo
for n=1:(largo-1)
   M=FRECMOD;
   MOD=sin(M*2*pi*n);
   ZEIGER=1+DELAY+ANCHO*MOD;
   i=floor(ZEIGER);
   frac=ZEIGER-i;
   vectordelay=[x(n);vectordelay(1:L-1)]; 
   %---Interpolacion lineal de la salida
   yv(n,1)=vectordelay(i+1)*frac+vectordelay(i)*(1-frac); 
   

end 