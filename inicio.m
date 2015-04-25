% globals fs;
global fs n;
fs=44100;
n=4;

audio=lib_audio(); % No input is live
audio2=lib_audio('Nice Drum Room'); % From file
% audio=effect_tremolo(audio);
% audio=effect_rinng(audio);
% audio=effect_distortion(audio);

% TODO audio=effect_cathedral_reverb(audio, audio2);
audio=effect_wahwah(audio);

wavplay(audio, fs);
