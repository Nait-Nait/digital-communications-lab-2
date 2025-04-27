% Parámetros
f0 = 1;                            
alpha_vals = [0, 0.25, 0.75, 1];   
t = linspace(0, 10/f0, 1000);      
f = linspace(-2*(f0+f0), 2*(f0+f0), 1000);  

figure(1)
hold on
title('Respuestas al impulso para diferentes \alpha');
xlabel('Tiempo [s]'); ylabel('h_e(t)');
grid on

figure(2)
hold on
title('Respuestas en frecuencia para diferentes \alpha');
xlabel('Frecuencia [Hz]'); ylabel('H_e(f)');
grid on

for i = 1:4
    alpha = alpha_vals(i);
    fDelta = alpha * f0;
    B = f0 + fDelta;
    f1 = f0 - fDelta;
    
    % Figura 10
    He_f = zeros(size(f));
    for k = 1:length(f)
        fk = abs(f(k));
        if fk < f1
            He_f(k) = 1;
        elseif fk < B
            He_f(k) = 0.5 * (1 + cos(pi*(fk - f1)/(2*fDelta)));
        else
            He_f(k) = 0;
        end
    end
    
    %Figura 14
    he_t = 2*f0 * (sin(2*pi*f0*t) ./ (2*pi*f0*t)) ...
           .* (cos(2*pi*fDelta*t) ./ (1 - (4*fDelta*t).^2));
    he_t(t==0) = 2*f0;  

    figure(1)
    plot(t, he_t, 'LineWidth', 1.5, 'DisplayName', ['\alpha = ', num2str(alpha)]);

    figure(2)
    plot(f, He_f, 'LineWidth', 1.5, 'DisplayName', ['\alpha = ', num2str(alpha)]);
end

% leyendas 
figure(1)
legend show

figure(2)
legend show





