% Copyright (C) 2010 Michael S. X. Ng and Robert G. Maunder

% This program is free software: you can redistribute it and/or modify it 
% under the terms of the GNU General Public License as published by the
% Free Software Foundation, either version 3 of the License, or (at your 
% option) any later version.
%
% This program is distributed in the hope that it will be useful, but 
% WITHOUT ANY WARRANTY; without even the implied warranty of 
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General 
% Public License for more details.
%
% The GNU General Public License can be seen at http://www.gnu.org/licenses/.


%%%%%%%%%%%%%%%%%%%%%%%%%%% Input parameters   %%%%%%%%%%%%%%%%%%%%%%%%
    SNR_start=0;
    SNR_step =2;
    SNR_end  =14; 

%%%%%%%%%%%%%%%%%%%%%%%%%%% simulations: begin %%%%%%%%%%%%%%%%%%%%%%%%
    BER_stop =1e-4;
    max_error_count = 100;
    frame_length = 10000;

    % Initialisation
    SNR_count = 1;
    SNR = SNR_start;
    BER = 1;

    % Loop until the job is killed or until the SNR or BER target is reached.
    while SNR <= SNR_end && BER >= BER_stop

        % Convert from SNR (in dB) to noise power spectral density.
        N0 = 1/(10^(SNR/10));
        
        % Counters to store the number of errors and bits simulated so far.
        error_count=0;
        bit_count=0;
       
        % Keep going until enough errors have been observed. This runs the simulation only as long as is required to keep the BER vs SNR curve smooth.
        while error_count < max_error_count
            
            % Generate some random bits.
            bits = round(rand(1,frame_length));
            
            % BPSK mapper
            symbols = -2*(bits-0.5);
            
            % Additive White Gaussian noise.
            %noise = sqrt(N0/2)*(randn(1,frame_length)+i*randn(1,frame_length)); % method 1: for any PSK or QAM (including BPSK)
            noise = sqrt(N0)*(randn(1,frame_length));                            % method 2: for BPSK only
            
            % Add some complex Gaussian distributed noise.
            received_symbols = symbols + noise;
            
            % Perform BPSK demapper
            recovered_bits = received_symbols<0;
            
            % Accumulate the number of errors and bits that have been simulated so far.
            error_count = error_count + sum(recovered_bits ~= bits);
            bit_count = bit_count + frame_length;
        end
        
        % Calculate the BER.
        BER = error_count/bit_count;
        BER_all(SNR_count) = BER;
        SNR_dB(SNR_count) = SNR;
        
        BER_all
        bit_count        
        
        % Setup the SNR for the next iteration of the loop.
        SNR = SNR + SNR_step;
        SNR_count = SNR_count + 1;
    end 
%%%%%%%%%%%%%%%%%%%%%%%%%%% simulations: end %%%%%%%%%%%%%%%%%%%%%%%%%%

   
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%  Theoretical calculation: begin %%%%%%%%%%%
    SNR = (SNR_start: SNR_step/10 :SNR_end);    % in decibel
    snr = 10.^(SNR/10);                         % non decibel
    BER_theory = 0.5*erfc(sqrt(snr/2));         % see ELEC2021 lecture notes
						% assume `method 2' in the noise generation
%%%%%%%%%%%%%%%%%%%%%%%%%%%  Theoretical calculation: end %%%%%%%%%%%%%

    clf;
    % BER from simulation
    semilogy(SNR_dB(1:length(BER_all)), BER_all(1:end), 'o');   
    hold on; 
    
    % BER from theoretical calculation
    semilogy(SNR, BER_theory, 'k-');
    hold off;
    grid;        
        
    % labeling
    title('BPSK modulation in an AWGN channel');
    ylabel('BER');
    xlabel('SNR (in dB)');
    legend('Simulation','Theory');


