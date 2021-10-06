clear all
fs_s = 44100;   % sampling frequency [Hz]
T_s = 5;        % total time[s]
f0 = 1000;      % fundamental frequency [Hz]
a_k = 1;        % amplitude
t_s = 0:1/fs_s:T_s-1/fs_s;

N = 10;         % number of components
%%
phase = zeros(1,N); %zero phase
ttl="0 phase";

%%
%Uncomment for pi/2 phase
%
%for i=1:N
%    phase(i)= pi/2;
%end
%ttl='pi/2 phase';
%%
%Uncomment for random phase

% for i=1:N
%     phase(i)= rand*2*pi;
% end
% ttl='random phase';

%%
% initialize the signal with a vector of zeros
s = zeros(1,fs_s*T_s);  % Where does the fs*T come from? -- > number of samples 

% now the loop
for kk = 1:N
    s = s + a_k*sin(2*pi*kk*f0*t_s+phase(kk));
end

%Uncomment for sound (RIP ears)
%sound(s,fs_s)
    
% plotting
figure('Name','A cool tone complex!')

plot(t_s,s)
xlabel('t')
ylabel('y')
xlim([0 .01])
title(sprintf('Tone-complex with %s', ttl))
