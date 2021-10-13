clearvars;
TB = ToolBox;

Fs = 44100;
alpha = 0.6;


%Load speach
[speach_signal, fs] = audioread('mini_me.wav');
%soundsc(speach_signal, fs);


%%


%Difference equation: y(n) = x(n) + a*x(n-delay)
delay = Fs * 0.030; 
[time_vec, h] = TB.impulse(delay, 1);
h(end) = alpha;
%Filter - FIR
speach_signal_filtered = filter(h, 1, speach_signal);
speach_signal_filtered = speach_signal_filtered/max(speach_signal_filtered)*.5;
%Listen
%soundsc(speach_signal_filtered, fs);





%Plots
fft_impulse = fft(h);
fft_abs = abs(fft_impulse);
fft_abs = fft_abs(1:1+length(h)/2);
magnitude = 20*log10(fft_abs);
fft_phase = (angle(fft_impulse))*180/pi;
phase = fft_phase(1:1+length(h)/2);
frequency_bins = (0:length(h)/2) * fs / length(h);  

figure
subplot(311)
plot(time_vec, h)
title('Impulse response h(t)')
xlabel('Time')
ylabel('Amplitude')
subplot(312)
semilogx(frequency_bins, magnitude), grid;
title('Amplitude Spectrum of X(t)')
xlabel('w (rad/s)')
ylabel('|Mag| (dB)')
subplot(313)
semilogx(frequency_bins, phase), grid;
xlabel('w (rad/s)')
ylabel('Phase (degree)')


%%


delay = Fs * 0.030; 
[time_vec, h] = TB.impulse(delay, 1);
h(end) = alpha;
%Filter - IIR
speach_signal_filtered = filter(1, h, speach_signal);
speach_signal_filtered = speach_signal_filtered/max(speach_signal_filtered)*.5;
%Listen
%soundsc(speach_signal_filtered, fs);


%Plots
fft_impulse = fft(h);
fft_abs = abs(fft_impulse);
fft_abs = fft_abs(1:1+length(h)/2);
magnitude = 20*log10(fft_abs);
fft_phase = (angle(fft_impulse))*180/pi;
phase = fft_phase(1:1+length(h)/2);
frequency_bins = (0:length(h)/2) * fs / length(h);  

figure
subplot(311)
plot(time_vec, h)
title('Impulse response h(t)')
xlabel('Time')
ylabel('Amplitude')
subplot(312)
semilogx(frequency_bins, magnitude), grid;
title('Amplitude Spectrum of X(t)')
xlabel('w (rad/s)')
ylabel('|Mag| (dB)')
subplot(313)
semilogx(frequency_bins, phase), grid;
xlabel('w (rad/s)')
ylabel('Phase (degree)')



%%

%FIR - 0.2s
delay = Fs * 0.2; 
[time_vec, h] = TB.impulse(delay, 1);
h(end) = alpha;
%Filter
speach_signal_filtered = filter(h, 1, speach_signal);
speach_signal_filtered = speach_signal_filtered/max(speach_signal_filtered)*.5;
%Listen
%soundsc(speach_signal_filtered, fs);


%IIR - 0.2s
delay = Fs * 0.2; 
[time_vec, h] = TB.impulse(delay, 1);
h(end) = alpha;
%Filter
speach_signal_filtered = filter(1, h, speach_signal);
speach_signal_filtered = speach_signal_filtered/max(speach_signal_filtered)*.5;
%Listen
%soundsc(speach_signal_filtered, fs);

