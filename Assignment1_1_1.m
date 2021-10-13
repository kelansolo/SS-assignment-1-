%% Assignment
clc; close all; clear;

% 1. Poles and zeros in running sum filter order 3 and 5


% We are making a z-transform (lec. 5, slides 2)

H1=ztran_runsum(3);

pole1=pole(H1);
zero1=zero(H1);

H2 = ztran_runsum(5);

pole2=pole(H2);
zero2=zero(H2);



%% 2. plot poles and zeros


%figure; %PLOT DER SKAL MED

figure("Name", "Frequency domain of piano", "Position", [400 300 400 400]);
set(gcf,"paperunits","centimeters","Paperposition",[0 0 10 4])
pl=zplane(zero1, pole1)
set(pl, "linewidth",1)
set(gca,"Fontsize",10)
title("Frequency of piano")
xlabel('Frequency [F]')
ylabel('Amplitude')
saveas(gcf,"test1.eps","psc2")

%%
sgtitle('Poles and zeros') 
subplot(2,1,1);
zplane(zero1,pole1)
title("Running sum order 3")
grid on

subplot(2,1,2)
zplane(zero2,pole2)
title("Running sum order 5")
grid on


B1=[1 1 1 1];
A1 = [1 0 0 0];

figure; %PLOT DER SKAL MED
freqz(B1,A1,'whole')
title("Running sum order 3")
grid on

B2=[1 1 1 1 1 1];
A2 = [1 0 0 0 0 0];

figure; %PLOT DER SKAL MED
freqz(B2,A2,'whole')
title("Running sum order 5")
grid on

%% 3. frequency response for moving average rather than running sum

B3=[1 1 1 1];
A3 = [4 0 0 0];

B4=[1 1 1 1 1 1];
A4 = [6 0 0 0 0 0];

figure;
freqz(B3,A3,'whole')
%title("Running sum order 3")
grid on

figure;
freqz(B4,A4,'whole')
%title("Running sum order 3")
grid on

% The moving average frequncy response is just the same as the running sum,
% but the amplitude plot is shifted down, so it starts at 0 db.

% 4. Amplify frequencies

% You could inverse the transfer function. Then we would get a positive
% gain instead of a negaive gain. The zeros becomes poles.

%% 5. Filter that blocks 0.1


poles = [0;0;0;0];
zeros = [cos(0.1*pi)+i*sin(0.1*pi);cos(0.1*pi)-i*sin(0.1*pi);cos(0.1*pi)+i*sin(0.1*pi);cos(0.1*pi)-i*sin(0.1*pi)];

B=poly(zeros);
A=poly(poles);

% figure;
% zplane(zeros,poles)

figure(1);
freqz(B,A,'whole') % PLOT DER SKAL MED

% 6. Poles 
poles1 = [(9/10)*(cos(0.1*pi)+i*sin(0.1*pi));(9/10)*(cos(0.1*pi)-i*sin(0.1*pi));(9/10)*(cos(0.1*pi)+i*sin(0.1*pi));(9/10)*(cos(0.1*pi)-i*sin(0.1*pi))];
zeros1 = [cos(0.1*pi)+i*sin(0.1*pi);cos(0.1*pi)-i*sin(0.1*pi);cos(0.1*pi)+i*sin(0.1*pi);cos(0.1*pi)-i*sin(0.1*pi)];


B1=poly(zeros1);
A1=poly(poles1);

% figure;
% zplane(zeros1,poles1)

figure(2);
freqz(B1,A1,'whole') % PLOT DER SKAL MED


poles2 = [(99/100)*(cos(0.1*pi)+i*sin(0.1*pi));(99/100)*(cos(0.1*pi)-i*sin(0.1*pi));(99/100)*(cos(0.1*pi)+i*sin(0.1*pi));(99/100)*(cos(0.1*pi)-i*sin(0.1*pi))];

B2=poly(zeros1);
A2=poly(poles2);

% figure;
% zplane(zeros1,poles1)

figure(3);
freqz(B2,A2)

% It can be seen from the plots, that the frequency response becomes more
% "sharp" when R increases and approches R=1; so it is only the normalized
% frequency 0.1 that is blocked.
