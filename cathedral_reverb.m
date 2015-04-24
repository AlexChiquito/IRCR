function reverb_signal = cathedral_reverb(signal, impulse_response)
% 
% cathedral_reverb.m
%
% This function applies reverb by convolving the input signal with a
% room impulse response
%
%       
%       signal            =  input signal
%       impulse_response  =  reverb impulse response signal
%
%
%
% *** REQUIRES 'impulse_cathedral.wav' ***
%
% Eg.
%
[signal, fs, nbits] = wavread('marvin');
impulse_response = wavread('Rays');
%
reverb_signal = cathedral_reverb(signal, impulse_response);
%
wavwrite(reverb_signal, fs, nbits, 'marvin_in_cathedral.wav');


out_L = length(signal) + length(impulse_response)-1;  % Creating length of output signal

out_L2 = pow2(nextpow2(out_L)); % Length to power 2 for moving to frequency domain. 
% Choosing the first power of 2 above out_L

SIGNAL = fft(signal, out_L2); % Fast Fourier transform
IMPULSE_RESPONSE = fft(impulse_response, out_L2); % Fast Fourier transform

REVERB_SIGNAL = SIGNAL.*IMPULSE_RESPONSE; % Multiplication of signals in frequency domain

reverb_signal = real(ifft(REVERB_SIGNAL, out_L2)); % Inverse Fast Fourier transform
reverb_signal = reverb_signal(1:1:out_L); % Take just the first N elements

reverb_signal = reverb_signal/max(abs(reverb_signal)); % Normalise the output


end