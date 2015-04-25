function lib_audio= lib_audio(file)
nargin
global fs n;

if nargin > 0
    lib_audio=wavread(file);
else
    lib_audio=wavrecord(n*fs,fs);
end