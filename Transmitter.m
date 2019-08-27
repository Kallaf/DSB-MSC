% 1.1)Read the attached audio file which has the sampling frequency 48kHz
%------------------------------------------------------------------------

[signal,Fs] = audioread('tone.wav'); %where fs is the sampling frequency

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

% 2)Use an ideal filter to remove all the frequencies greater than 4KHZ
%----------------------------------------------------------------------

h=1./sqrt(1+(f./4000).^(2*5000));
cut_off = 4e3/Fs/2;
order = 32;
h = fir1(order,cut_off);

% 3)Obtain the filtered signal in both frequency and time domain.
%----------------------------------------------------------------

y_filtered = conv(y,h);
Y_filtered = ifftshift(fft(y_filtered));

L = length(y_filtered);
f = linspace(-Fs/2,Fs/2,L);
figure
plot(f,abs(Y_filtered))
title('Amplitude Spectrum of filtered signal')
xlabel('f (Hz)')
ylabel('|amplitude| (volt)')

% 4)Sound the filtered audio signal
%----------------------------------

sound(y_filtered, Fs, 16);

% 5.1)Increase sampling frequency of filtered signal
%---------------------------------------------------

Fs = 5e5;
y_resampled = resample(y_filtered,500,48);

% 5.2)Generate DSB-SC modulated signal using a carrier signal with carrier frequency (Fs = 5*Fc)
%-----------------------------------------------------------------------------------------------

L = length(y_resampled);
for i = 1:L
	y_resampled(i) = y_resampled(i) * cos(2*pi*1e5*(i-1)*(L/Fs));
end
audiowrite("TransmittedSignal.wav",y_resampled,Fs);