function yrv = effect_cathedral_reverb(signal, respuesta_al_impulsostr)
respuesta_al_impulso=wavread(respuesta_al_impulsostr);
%tamaño de las FFT
out_L = length(signal) + length(respuesta_al_impulso)-1;
out_L2 = pow2(nextpow2(out_L)); %para mejoramiento del algoritmo de FFT

signalFFT = fft(signal, out_L2); % Fast Fourier transform
respuestaFFT = fft(respuesta_al_impulso, out_L2);

REVERB_SIGNAL = signalFFT.*respuestaFFT; %multiplicamos las FFt de la respuesta al impulso y la señal
reverb_signalt = real(ifft(REVERB_SIGNAL, out_L2)); %  Fast Fourier transform inversa

reverb_signalt = reverb_signalt(1:1:out_L);
reverb_signalt = reverb_signalt/max(abs(reverb_signalt)); %normalizar
yrv=transpose(reverb_signalt);