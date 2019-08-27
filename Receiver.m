% Recieve the  modulated signal
[signal,Fs] = audioread('TransmittedSignal.wav');
y = signal(:,1);
L = length(y);
t = linspace(0, L/Fs, L);
Y = fftshift(fft(y));

f = linspace(-Fs/2,Fs/2,L);

% 6)Demodulated the modulated signal
%-----------------------------------
for i = 1:L
	y(i) = y(i) * cos(2*pi*1e5*(i-1)*(L/Fs));
	%y(i) = y(i) * cos(2*pi*100.1e3*(i-1)*(L/Fs));
	%y(i) = y(i) * cos(2*pi*1e5*(i-1)*(L/Fs) + pi/9);
end

Y = fftshift(fft(y));

subplot(2,1,1),plot(t,y);
plot(t,y)
title('Amplitude Spectrum of modulated signal')
xlabel('f (Hz)')
ylabel('|amplitude| (volt)')
subplot(2,1,2),plot(f,Y);
plot(f,abs(Y))
title('Amplitude Spectrum of demodulated signal')
xlabel('f (Hz)')
ylabel('|amplitude| (volt)')

% 7) SNR = 10 db
%----------------

y_resampled = resample(y,48,500);

sound(y_resampled, 48e3, 16);
audiowrite("recievedToneSNR10.wav",y_resampled,48e3);
%audiowrite("signalWithFrequencyError.wav",y_resampled,Fs);
%audiowrite("signalWithPhaseError.wav",y_resampled,Fs);

y_snr=awgn(y,10,'measured');
Y_snr=fftshift(fft(y,length(y))/length(y));

figure
subplot(2,1,1),plot(t,y_snr);
title('recieved signal with SNR=10 IN TIME DAOMAIN');
xlabel('time (sec)');
ylabel('amplitude');

subplot(2,1,2),plot(f,abs(Y_snr));
title('recieved signal with SNR=10 IN FREQUENCY DOMAIN');
xlabel('frequency(hz)');
ylabel('amplitude');


