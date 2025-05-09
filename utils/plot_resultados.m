function plot_resultados(SoC, V_tank, P_grid, Q_p, Q_DNO, P_pump, V_aq, h_p, Ts)
    t = (0:length(SoC)-1) * Ts / 3600;

    figure;

    subplot(6,1,1);
    plot(t, SoC * 100, 'LineWidth', 1.5);
    title('Estado de carga batería');
    ylabel('[%]'); ylim([0 100]); grid on;

    subplot(6,1,2);
    plot(t, V_tank, 'LineWidth', 1.5);
    title('Volumen del estanque');
    ylabel('[L]'); grid on;

    subplot(6,1,4);
    plot(t, P_grid, 'r', 'LineWidth', 1.2);
    title('Compra de energía al DNO');
    ylabel('[kW]'); grid on;

    subplot(6,1,3);
    plot(t, Q_p, 'b', 'LineWidth', 1.2);
    title('Caudal bombeado desde pozo');
    ylabel('[L/s]'); grid on;

    subplot(6,1,5);
    plot(t, Q_DNO, 'm', 'LineWidth', 1.2);
    title('Compra de agua al DNO');
    ylabel('[L/s]'); grid on;

    subplot(6,1,6);
    plot(t, V_aq, 'k', 'LineWidth', 1.2);
    title('Volumen del acuífero');
    ylabel('[L]'); grid on;

    saveas(gcf, 'results/resumen.png');
    
    % --- Gráfico 1: Estado de Carga Batería ---
    figure;
    plot(t, SoC * 100, 'LineWidth', 1.5);
    title('Estado de carga batería');
    xlabel('Tiempo [horas]');
    ylabel('[%]');
    ylim([0 100]); % Asegura que el eje Y vaya de 0 a 100
    grid on;
    saveas(gcf, 'results/SoC_bateria.png'); % Opcional: guardar figura

    % --- Gráfico 2: Volumen del Estanque ---
    figure;
    plot(t, V_tank, 'LineWidth', 1.5);
    title('Volumen del estanque');
    xlabel('Tiempo [horas]');
    ylabel('[L]');
    grid on;
    saveas(gcf, 'results/Volumen_estanque.png'); % Opcional: guardar figura

    % --- Gráfico 3: Compra de Energía al DNO ---
    figure;
    plot(t, P_grid, 'r', 'LineWidth', 1.2);
    title('Compra de energía al DNO (Red)');
    xlabel('Tiempo [horas]');
    ylabel('[kW]');
    grid on;
    saveas(gcf, 'results/Compra_energia.png'); % Opcional: guardar figura

    % --- Gráfico 4: Caudal Bombeado desde Pozo ---
    figure;
    plot(t, Q_p, 'b', 'LineWidth', 1.2);
    title('Caudal bombeado desde pozo');
    xlabel('Tiempo [horas]');
    ylabel('[L/s]');
    grid on;
    saveas(gcf, 'results/Caudal_bombeado.png'); % Opcional: guardar figura

    % --- Gráfico 5: Compra de Agua al DNO ---
    figure;
    plot(t, Q_DNO, 'm', 'LineWidth', 1.2);
    title('Compra de agua al DNO');
    xlabel('Tiempo [horas]');
    ylabel('[L/s]');
    grid on;
    saveas(gcf, 'results/Compra_agua.png'); % Opcional: guardar figura

    % --- Gráfico 6: Potencia Consumida por Bombas ---
    figure;
    plot(t, P_pump, 'g', 'LineWidth', 1.2);
    title('Potencia consumida por bombas');
    xlabel('Tiempo [horas]');
    ylabel('[kW]');
    grid on;
    saveas(gcf, 'results/Potencia_bombas.png'); % Opcional: guardar figura

    % --- Gráfico 7: Volumen del Acuífero ---
    figure;
    plot(t, V_aq, 'k', 'LineWidth', 1.2);
    title('Volumen del acuífero');
    xlabel('Tiempo [horas]');
    ylabel('[L]');
    grid on;
    saveas(gcf, 'results/Volumen_acuifero.png'); % Opcional: guardar figura

end
