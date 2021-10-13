classdef ToolBox
    properties
%       Value {mustBeNumeric}
    end
    methods(Static)
        function [time_vector, signal] = sinusoid(a, f, phi, fs, T_s)
        % Function call:
        %
        % >> [time_vector signal] = generate_sinusoid(a, f, phi, fs, T_s)
        %
        % INPUT:
        % a : amplitude
        % f : frequency of sinusoid (in Hz)
        % phi_k : phase (in multiples of 2pi)
        % fs : sampling frequency (in Hz)
        % T_s : duration (in seconds)
        %
        % OUTPUT:
        % time_vector : time vector with sampling points
        % signal : the output signal
        %
        % This function generates a sinusoid at amplitde <a>, frequency <f>, phase <phi>
        % sampled at a sampling frequency <fs> and a duration of <T> seconds.
        %
        % Example:
        %
        % >> [t sig] = generate_sinusoid(0.1, 1000, 0, 44100, 1)
        %
        % generates a sinusoid with amplitude 0.1, frequency of 1000 Hz, phase zero
        % sampled at a sampling frequency of 44100 Hz and a duration of 1 second.
            time_vector = 0 : 1/fs : T_s-1/fs;
            signal = a*cos(f*2*pi*time_vector+2*pi*phi);
        end
        
        function [time_vector, signal] = rect(fs, T_s, T_square)
            time_vector = 0 : 1/fs : T_s-1/fs;
            
            sq = ones(1, T_square*fs);
            signal = obj.zero_pad(sq, T_s*fs)
            %signal = [sq zeros(1, round((T_s-T_square)*fs))];
        end
        
        function [time_vector, signal] = ramp(fs, T_s, T_ramp)
            time_vector = 0 : 1/fs : T_s-1/fs;
            
            %N_ramp = 1/T_ramp;
            %ramp_vector = 0 : 1/N_ramp : T_ramp;
            
            ramp = 0 : 1/(fs*T_ramp) : 1;
            signal = obj.zero_pad(ramp, T_s*fs)
            
            %ramp = 0 :  ones(1, T_ramp*fs);
            %signal = [sq zeros(1, round((T_s-T_square)*fs))];
        end
           
        
        function [signal] = zero_pad(vector, desired_length)
            signal = [vector zeros(1, desired_length-length(vector))];
        end
        
        function [time_vector, signal] = convolution( A, B, fs)
            signal = conv(A, B);
            
            % N=fs*T <=> T=N/fs
            T = length(signal)/fs;
            time_vector = 0 : 1/fs : T-1/fs;
        end
        
        function [Y, freq] = spectrum(signal, fs)

            % Here goes the help message
            % ...

            % compute spectrum (note: it will be complex-valued).
            Y = fft(signal);

            % The FFT needs to be scaled in order to give a physically plausible scaling.
            Y = Y/(length(Y));
            % NOTE: If you do an IFFT, this scaling must NOT be done.
            % We'll get to this in the lecture. If you are only interested
            % in the positive frequencies, you need to scale by <length(Y)/2>.

            % frequency vector
            delta_f = (fs/1)/length(signal);
            freq = 0:delta_f:(fs/1)-delta_f;
            % NOTE: The first element that comes out of the FFT is the DC offset
            % (i.e., frequency 0). Each subsequent
            % bin is spaced by the frequency resolution <delta_f> which you can
            % calculate from the properties of the inut signal. Remember the highest
            % frequency you can get in a digitized signal....
            % ...

            % convert into column vector (if required)
            Y = Y(:);
            freq = freq(:);
        end
        
        % NOT WORKING
        function [num, denum] = ZTransform( h)
            order = length(h);
            num = zeros(1, order+1); %Pre-alloc
            
            for n = 1:order+1
                num(n+1) = 1;
            end
            denum = [1, zeros(1, order)]; 
        end
        
        function [time_vec, signal] = impulse(fs, T_s)
            % Input argument(s)
            %    fs  - sampling frequency
            %    T_s - time duration in seconds
            %
            % Output arguments(s) 
            %    time - time vec
            %    signal - impulse signal 
            %
            % Example call: 
            %[time,signal] = impulse(44100,2)
            %
            % In this example an impulse is generated with a sampling frequency of
            % 44100 Hz and a time duration of 2 sec. Therefore the signal is 88200
            % samples long.
            %
            
            %fprintf("%d %d\n", fs, T_s);

            sample_period = 1/fs;
            time_vec = 0:sample_period:T_s-sample_period;
            signal=zeros(1,length(time_vec));
            signal(1) = 1;
        end
    end
end

