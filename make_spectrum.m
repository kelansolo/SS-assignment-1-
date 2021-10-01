function [Y, freq] = make_spectrum(signal, fs)
% Here goes the help message
% ...
% compute spectrum (note: it will be complex-valued).
Y = fft(signal);
% The FFT needs to be scaled in order to give a physically plausible scaling.
Y = Y/(length(Y));
% NOTE: If you do an IFFT, this scaling must NOT be done.
% We’ll get to this in the lecture. If you are only interested
% in the positive frequencies, you need to scale by <length(Y)/2>.
% frequency vector
delta_f = fs/length(signal); 
freq = 0:delta_f: fs-delta_f;
% NOTE: The first element that comes out of the FFT is the DC offset
% (i.e., frequency 0). Each subsequent
% bin is spaced by the frequency resolution <delta_f> which you can
% calculate from the properties of the inut signal. Remember the highest
% frequency you can get in a digitized signal....
% ...
% convert into column vector (if required)
Y = Y(:);
freq = freq(:);
% eof
end