AR = dsp.AudioRecorder('OutputNumOverrunSamples',true);
AFW = dsp.AudioFileWriter('myspeech.wav','FileFormat', 'WAV');
disp('Speak into microphone now');
tic;
while toc < 10,
  [audioIn,nOverrun] = step(AR);
  step(AFW,audioIn);
  if nOverrun > 0
    fprintf('Audio recorder queue was overrun by %d samples\n'...
        ,nOverrun);
  end
end
release(AR);
release(AFW);
disp('Recording complete'); 