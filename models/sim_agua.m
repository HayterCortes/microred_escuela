function [V_next, Q_p, Q_DNO] = sim_agua(Q_d, V_current, V_aquifero_k, Ts) 
    global V_max Q_pump_max Q_DNO_max

    % Demanda convertida a litros por paso
    Q_req = Q_d * Ts;        % [L]

    % Inicializar caudales
    Q_p   = 0;               % caudal desde pozo [L/s]
    Q_DNO = 0;               % caudal desde red [L/s]

    % === 1) Usar el estanque primero ===
    if V_current >= Q_req
        % El estanque cubre toda la demanda
        V_next = V_current - Q_req;
    else
        % No alcanza → comprar déficit al DNO
        Q_deficit = (Q_req - V_current) / Ts;       % [L/s]
        Q_DNO     = min(Q_deficit, Q_DNO_max);      % límite red de agua

        % Actualizar volumen del estanque
        V_next = V_current - Q_req + Q_DNO * Ts;
    end

    % === 2) Bombear si el estanque queda bajo cierto umbral y hay acuífero ===
    % (esto representa reabastecimiento automático)
    if V_next < 0.1 * V_max && V_aquifero_k > 0
        % Agua máxima que puede extraer la bomba considerando disponibilidad
        available_rate = V_aquifero_k / Ts;           % [L/s] disponible
        Q_p = min(Q_pump_max, available_rate);        % limita al acuífero

        % Llenar el estanque con lo bombeado
        V_next = V_next + Q_p * Ts;
    end

    % === 3) Saturar el estanque dentro de sus límites físicos ===
    V_next = min(max(V_next, 0), V_max);
end
