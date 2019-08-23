% 1.1)Read the attached audio file which has the sampling frequency 48kHz
%-------------------------------------------------------------------------

[signal,Fs] = audioread('tone.wav'); %where fs is the sampling frequency


% 1.2)Plot the spectrum of the signal
%-------------------------------------

y = signal(:,1);		% Removing the second channel
T = 1/Fs;				% Sampling period 
L = length(y);			% Length of signal

% Compute the Fourier transform of the signal.
Y = fft(y);

% Define the frequency domain f and plot the double-sided amplitude spectrum.
f = Fs*(0:L-1);
plot(f,abs(Y))
title('Double-Sided Amplitude Spectrum of signal')
xlabel('f (Hz)')
ylabel('P (f)')

% 2)Use an ideal filter to remove all the frequencies greater than 4KHZ
%----------------------------------------------------------------------

cut_off = 4e3/Fs/2;
order = 32;
h = fir1(order,cut_off);

% 3)Obtain the filtered signal in both frequency and time domain.
%----------------------------------------------------------------

con = conv(y,h);

% 4)Sound the filtered audio signal
%----------------------------------
sound(con, Fs, 16);

