num_bits = 10000;                    
sps = 8;                            
alpha_vals = [0, 0.25, 0.75, 1];    
EbN0_dB = 30;                       
span = 6;                          

% bits y NRZ-L
bits = randi([0 1], 1, num_bits);
symbols = 2*bits - 1;               

for i = 1:length(alpha_vals)
    alpha = alpha_vals(i);

    %coseno alzado
    rrc = rcosdesign(alpha, span, sps, 'normal');

    tx = upfirdn(symbols, rrc, sps);

    %ruido
    signal_power = mean(tx.^2);
    snr_linear = 10^(EbN0_dB/10);
    noise_power = signal_power / snr_linear;
    noise = sqrt(noise_power) * randn(size(tx));
    rx = tx + noise;

    % Diagrama de ojo
    Ntrazas = floor(length(rx) / (2 * sps));
    eye_matrix = zeros(Ntrazas, 2 * sps);

    for k = 1:Ntrazas
        idx = (k - 1) * 2 * sps + 1;
        if idx + 2*sps - 1 <= length(rx)
            eye_matrix(k, :) = rx(idx : idx + 2*sps - 1);
        end
    end

    % diagrama de ojo
    figure;
    plot((0:2*sps-1)/sps, eye_matrix', 'b');
    title(['Diagrama de Ojo (\alpha = ', num2str(alpha), ')']);
    xlabel('Tiempo [símbolos]');
    ylabel('Amplitud');
    grid on;
end