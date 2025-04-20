function plot_gen_dem_perfiles(P_dem, P_gen, Q_dem, Ts)
    % Tiempo en horas
    t = (0:length(P_dem)-1) * Ts / 3600;

    figure;

    % Demanda y generación eléctrica
    subplot(2,1,1);
    plot(t, P_dem, 'b', 'LineWidth', 1); hold on;
    plot(t, P_gen, 'r', 'LineWidth', 1);
    title('Perfiles de Demanda y Generación Eléctrica');
    ylabel('Potencia [kW]');
    legend('Demanda', 'Generación');
    grid on;

    % Demanda hídrica
    subplot(2,1,2);
    plot(t, Q_dem, 'c', 'LineWidth', 1);
    title('Perfil de Demanda Hídrica');
    ylabel('Caudal [L/s]');
    xlabel('Tiempo [h]');
    grid on;

    % Guardar imagen
    saveas(gcf, 'results/perfiles_gen_dem.png');
end
