clear all;
%% Low pass
polesLP=[0.9*(cos(0.1*pi)+i*sin(0.1*pi));0.9*(cos(0.1*pi)-i*sin(0.1*pi));0.9*(cos(0.05*pi)+i*sin(0.05*pi));0.9*(cos(0.05*pi)-i*sin(0.05*pi))];
zerosLP=[0.5*(cos(0.3*pi)+i*sin(0.3*pi));0.5*(cos(0.3*pi)-i*sin(0.3*pi))];

BLP=poly(zerosLP);
ALP=poly(polesLP);
figure('Name','Frequency LP');
freqz(BLP,ALP);
figure('Name','Pole Zero LP');
zplane(zerosLP,polesLP);
%% High pass inverse of LP
zerosHP=[0.9*(cos(0.1*pi)+i*sin(0.1*pi));0.9*(cos(0.1*pi)-i*sin(0.1*pi));0.9*(cos(0.05*pi)+i*sin(0.05*pi));0.9*(cos(0.05*pi)-i*sin(0.05*pi))];
polesHP=[0.5*(cos(0.3*pi)+i*sin(0.3*pi));0.5*(cos(0.3*pi)-i*sin(0.3*pi))];
BHP=poly(zerosHP);
AHP=poly(polesHP);

figure('Name','Frequency HP');
freqz(BHP,AHP)
figure('Name','Pole Zero HP');
zplane(zerosHP,polesHP);

%% ALl pass = poles and zeros in same spot

zerosAP=[0.3*(1+i);0.3*(1-i);0.1*(-1+i);0.1*(-1-i),;0.5];
polesAP=[0.3*(1+i);0.3*(1-i);0.1*(-1+i);0.1*(-1-i);0.5];

BAP=poly(zerosAP);
AAP=poly(polesAP);
figure('Name','Frequency AP');
freqz(BAP,AAP)
figure('Name','Pole Zero AP');
zplane(zerosAP,polesAP);

%% sin test
fs=44100;
Ttot=2;
T=0:1/fs:Ttot-1/fs;
f=100;
sin=sin(2*pi*f*T);
outLP=filter(BLP,ALP,sin);
outHP=filter(BHP,AHP,sin);
outAP=filter(BAP,AAP,sin);
%% Uncomment for fig 7
%figure(7);
%plot(T,outLP);
%plot(T,outHP);
%plot(T,outAP);


%% sound Test
[y, fs_y] = audioread(['mini_me.wav']);
yLP=filter(BLP,ALP,y);
yHP=filter(BHP,AHP,y);
yAP=filter(BAP,AAP,y);
%soundsc(yAP,fs_y)
%soundsc(yHP,fs_y)
%soundsc(yLP,fs_y)



