% 1.1) Read the attached audio file which has the sampling frequency 48kHz
%-------------------------------------------------------------------------

[signal,Fs] = audioread('tone.wav'); %where fs is the sampling frequency


% 1.2) plot the spectrum of the signal
%-------------------------------------

X = signal(:,1);		% Removing the second channel
T = 1/Fs;				% Sampling period 
L = length(X);			% Length of signal
t = (0:L-1)*T; 			% Time vector


% Compute the Fourier transform of the signal.
Y = fft(X);

% Compute the two-sided spectrum P2. Then compute the single-sided spectrum P1 based on P2 and the even-valued signal length L.
P2 = abs(Y/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);

% Define the frequency domain f and plot the single-sided amplitude spectrum P1.
f = Fs*(0:(L/2))/L;
plot(f,P1) 
title('Single-Sided Amplitude Spectrum of X(t)')
xlabel('f (Hz)')
ylabel('|P1(f)|')