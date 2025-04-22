function [SoC_next, P_pump] = sim_energia_manual(P_d, P_g, SoC, Ts, Q_p, P_grid)
    global E_batt_max P_batt_max SoC_min SoC_max alpha_C alpha_D

    % Altura equivalente del sistema hidráulico
    h_equiv = 13.6508;      % [m]
    B = 9800;               % rho * g [kg·m/s²]
    P_pump = (45 * B * Q_p * h_equiv) / 1000;  % [kW]

    % Potencia neta con compra externa incluida
    P_total = P_d + P_pump;
    P_net = P_g + P_grid - P_total;

    % Límites dinámicos de carga/descarga
    P_chg_max = alpha_C * P_batt_max * (1 - SoC);  % carga máxima [kW]
    P_dis_max = alpha_D * P_batt_max * SoC;        % descarga máxima [kW]

    if P_net >= 0
        % Exceso → carga batería
        P_charge = min(P_net, P_chg_max);
        SoC_next = SoC + (P_charge * Ts / 3600) / E_batt_max;
    else
        % Déficit → descarga batería
        P_deficit = abs(P_net);
        P_discharge = min(P_deficit, P_dis_max);
        SoC_next = SoC - (P_discharge * Ts / 3600) / E_batt_max;
    end

    % Restringir el SoC entre los límites de operación
    SoC_next = min(max(SoC_next, SoC_min), SoC_max);
end
