function reverb_signal = effect_cathedral_reverb(signal, impulse_response)

out_L = length(signal) + length(impulse_response)-1;
out_L2 = pow2(nextpow2(out_L));
SIGNAL = fft(signal, out_L2); % Fast Fourier transform
IMPULSE_RESPONSE = fft(impulse_response, out_L2);
REVERB_SIGNAL = SIGNAL.*IMPULSE_RESPONSE;
reverb_signal = real(ifft(REVERB_SIGNAL, out_L2)); % Inverse Fast Fourier transform
reverb_signal = reverb_signal(1:1:out_L);
reverb_signal = reverb_signal/max(abs(reverb_signal));