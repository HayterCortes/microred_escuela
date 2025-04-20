function [SoC_next, P_grid] = sim_energia(P_d, P_g, SoC, Ts, Q_p)
    global E_batt_max P_batt_max SoC_min SoC_max P_grid_max alpha_C alpha_D

    % Altura equivalente (pozo + estanque)
    h_equiv = 13.6508;      % [m]
    B = 9800;               % rho*g [kg·m/s²]
    P_pump = (B * Q_p * h_equiv) / 1000;  % [kW]

    % Demanda total
    P_total = P_d + P_pump;

    % Potencia neta disponible
    P_net = P_g - P_total;
    P_grid = 0;

    % ===== Límites dinámicos según tesis (4.6 y 4.7) =====
    P_chg_max = alpha_C * P_batt_max * (1 - SoC);  % carga permitida según SoC
    P_dis_max = alpha_D * P_batt_max * SoC;        % descarga permitida según SoC

    if P_net >= 0
        % Exceso de generación → cargar batería
        P_charge = min(P_net, P_chg_max);
        SoC_next = SoC + (P_charge * Ts / 3600) / E_batt_max;
    else
        % Déficit → descargar batería
        P_deficit = abs(P_net);
        P_discharge = min(P_deficit, P_dis_max);
        SoC_temp = SoC - (P_discharge * Ts / 3600) / E_batt_max;

        if SoC_temp < SoC_min
            % No alcanza → usar lo disponible y comprar el resto
            E_disponible = (SoC - SoC_min) * E_batt_max;
            P_batt_eff = E_disponible * 3600 / Ts;
            P_grid = P_deficit - P_batt_eff;
            P_grid = min(max(P_grid, 0), P_grid_max);
            SoC_next = SoC_min;
        else
            SoC_next = SoC_temp;
        end
    end

    % Limitar SoC
    SoC_next = min(max(SoC_next, SoC_min), SoC_max);
end
