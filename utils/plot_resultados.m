function plot_resultados(SoC, V_tank, P_grid, Q_p, Q_DNO, V_aq, h_p, Ts)
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

    subplot(6,1,3);
    plot(t, P_grid, 'r', 'LineWidth', 1.2);
    title('Compra de energía al DNO');
    ylabel('[kW]'); grid on;

    subplot(6,1,4);
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
end
