function [V_next, Q_p, Q_DNO] = sim_agua(Q_d, V_current, V_aquifero_k, Ts)
    global V_max Q_pump_max Q_DNO_max

    Q_req = Q_d * Ts;  % demanda en litros
    Q_p = 0;           % caudal desde pozo [L/s]
    Q_DNO = 0;         % caudal desde red [L/s]

    % === Satisfacer la demanda desde el estanque ===
    if V_current >= Q_req
        V_next = V_current - Q_req;
    else
        % No alcanza → comprar agua
        Q_deficit = (Q_req - V_current) / Ts;
        Q_DNO = min(Q_deficit, Q_DNO_max);

        % Aplicar versión simple: el agua comprada se suma directamente
        V_next = V_current - Q_req + Q_DNO * Ts;
    end

    % === Activar bomba si volumen bajo y acuífero disponible ===
    if V_next < 0.1 * V_max && V_aquifero_k >= Q_pump_max * Ts
        Q_p = Q_pump_max;
        V_next = V_next + Q_p * Ts;
    end

    % === Limitar volumen del estanque ===
    V_next = min(max(V_next, 0), V_max);
end
