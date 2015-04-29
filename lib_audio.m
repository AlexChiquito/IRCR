function lib_audio= lib_audio(file)
nargin
global fs n;

if nargin > 0
    % lib_audio=wavread(file);
    %lib_audio=audioread(file);
    %lib_audio=lib_audio(1,:);
else
    lib_audio=wavrecord(n*fs,fs);
end