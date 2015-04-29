function result=effect_overdrive(x)
global n
N=length(x);
yo=zeros(1,N); % Creamos el vector de salida
lim=1/3; % limites para un soft clipping simetrico

% Aplicamos la formula de Schetzen
for i=1:1:N,
if abs(x(i))< lim, yo(i)=2*x(i);end;
if abs(x(i))>=lim,
if x(i)> 0, yo(i)=(3-(2-x(i)*3).^2)/3; end;
if x(i)< 0, yo(i)=-(3-(2-abs(x(i))*3).^2)/3; end;
end;
if abs(x(i))>2*lim,
if x(i)> 0, yo(i)=1;end;
if x(i)< 0, yo(i)=-1;end;
end;
end;

result=transpose(yo);