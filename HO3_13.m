clear all;
close all;
clc;
%% Read file
[y, fs_y] = audioread(['piano.wav']);
sound(y,fs_y)

y = y(:);       % we fist make it column vectors
y = y(:,1);     % and then we only use the first column
y = y/max(y)*.5;

%% Plotting original file
%Plot the signal in time window 0s to 1s 
subplot(3,3,1);
tn = 0: 1/fs_y: 1-1/fs_y;
plot(tn(1:fs_y),(y(1:fs_y))); %fs[Hz]--> fs samples/s
title('Real piano signal (time)')
xlabel('time [s]')
ylabel('Amplitude')
%Plot frequency spectrum
subplot(3,3,2);
[Y,freq]= make_spectrum(y,fs_y);
scatter(freq,20*log10(abs(Y)),'.')
title('Real piano signal (freq)')
xlabel('freq [Hz]')
ylabel('Amplitude');

%% sythensize signal
f0=130; %[Hz]
T=2; %Total time
n=10; %Number of harmonics
tn=0:1/fs_y:T-1/fs_y; 
N=length(tn); %number of samples

deltaf=fs_y/N; %frequency resolution
freq=0:deltaf:fs_y-deltaf; %frequency vector

sintest=0;
Y_syn=zeros(1,N); %sythesised signal in freqeuncy domain
for k=1:n %adding freqencies to Y_syn
    Y_syn(1,k*f0/deltaf+1)=-0.5*1i;
    Y_syn(1,N-k*f0/deltaf+1)=0.5*1i;
    sintest=sintest+sin(2*pi*k*f0*tn);
end
%% Plot sythesized signal
%Plot signal in frequency domain (IMAG)
subplot(3,3,4); 
stem(freq,imag(Y_syn)); %plot freqency plot
title('Imaginary synthesized signal (freq)')
xlabel('freq [Hz]')
ylabel('Amplitude')

%Plot signal in frequency domain (REAL)
subplot(3,3,5); 
stem(freq,real(Y_syn)); %plot freqency plot
title('Real synthesized signal (freq)')
xlabel('freq [Hz]')
ylabel('Amplitude')

%Plot signal in time domain
subplot(3,3,6)
plot(tn,ifft(Y_syn));
title('Synthesized signal (time)')
xlabel('time [s]')
ylabel('Amplitude')

%% synthesized signal with phase
%theta=ones(1,N).*pi/2;
theta=angle(Y);
Y_syn_theta=zeros(1,N);
for k=1:n %adding freqencies to Y_syn_theta
    Y_syn_theta(1,k*f0/deltaf+1)=-(exp(1i*theta(k*f0/deltaf+1))/2)*1i;
    Y_syn_theta(1,N-k*f0/deltaf+1)=(exp(1i*theta(k*f0/deltaf+1))/2)*1i;
end
%% Plot synthesised signal with phase 

%Plot signal in frequency domain (IMAG) with phase
subplot(3,3,7); 
stem(freq,imag(Y_syn_theta)); %plot freqency plot
title('Imaginary synthesized signal with phase (freq)')
xlabel('freq [Hz]')
ylabel('Amplitude')
    
%%
%Plot signal in frequency domain (REAL)
subplot(3,3,8); 
stem(freq,real(Y_syn_theta)); %plot freqency plot
title('Real synthesized signal with phase (freq)')
xlabel('freq [Hz]')
ylabel('Amplitude')

%Plot signal in time domain
y_w_phase=real(ifft(Y_syn_theta));% real because the imaginary part is e-5
subplot(3,3,9)
plot(tn,y_w_phase);
title('Synthesized signal with phase (time)')
xlabel('time [s]')
ylabel('Amplitude')
%%
soundsc(ifft(Y_syn),fs_y)
%soundsc(y_w_phase,fs_y)


%%
% %plot correct signal in frequency domain (with sinus)
% subplot(3,2,5)
% [Y,freq]= make_spectrum(sintest,fs_y);
% stem(freq,imag(Y))
% title('Real Imag signal (freq)')
% xlabel('freq[Hz]')
% ylabel('Amplitude')
% 
% %plot correct signal in time domain (with sinus)
% subplot(3,2,6)
% plot(tn,ifft(Y))
% title('Real signal (time)')
% xlabel('time [s]')
% ylabel('Amplitude')
% %sound(ifft(Y),fs_y)
%%
