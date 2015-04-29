function result=effect_wahwah(x)
global fs
% factor de amortiguamiento
% entre mas bajo el factor, mas pequeño el pasa bandas
damp = 0.05;
% frecuencias minimas y maximas del filtro
minf=500;
maxf=3000;
% Frecuencia del wahwah
Fw = 2000;
% Lo que se movera el centro del pasa bandas en un sample
delta = Fw/fs;
% funcion triangular en el centro de las frecuencias max y min
Fc=minf:delta:maxf;
N = 8;
%x=record;
while(length(Fc) < length(x) )
    Fc= [ Fc (maxf:-delta:minf) ];
    Fc= [ Fc (minf:delta:maxf) ];
end

% cortar el triangulo del tamaño de la onda
Fc = Fc(1:length(x));

% coeficientes de la ecuacion diferencial, se calculan cada que cambia Fc
F1 = 2*sin((pi*Fc(1))/fs);

% tamaño del pasabandas
Q1 = 2*damp;
yh=zeros(size(x)); % creamos vectores vacios
yb=zeros(size(x));
yl=zeros(size(x));

% tomamos el primer sample
yh(1) = x(1);
yb(1) = F1*yh(1);
yl(1) = F1*yb(1);

% aplicamos la ecuacion diferencial al resto de la señal
for n=2:length(x),
    yh(n) = x(n) - yl(n-1) - Q1*yb(n-1);
    yb(n) = F1*yh(n) + yb(n-1);
    yl(n) = F1*yb(n) + yl(n-1);
    F1 = 2*sin((pi*Fc(n))/fs);
end

%normalizamos y damos la salida
maxyb = max(abs(yb));
result = yb/maxyb;