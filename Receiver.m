% 1.1)Read the attached audio file which has the sampling frequency 48kHz
%------------------------------------------------------------------------

[signal,Fs] = audioread('TransmittedSignal.wav'); %where fs is the sampling frequency

% 1.2)Plot the spectrum of the signal
%-------------------------------------

y = signal(:,1);		% Removing the second channel
L = length(y);			% Length of signal

% Compute the Fourier transform of the signal.
Y = fftshift(fft(y));

% Define the frequency domain f and plot the double-sided amplitude spectrum.
f = linspace(-Fs/2,Fs/2,L);
plot(f,abs(Y))
title('Amplitude Spectrum of signal')
xlabel('f (Hz)')
ylabel('|amplitude| (volt)')
