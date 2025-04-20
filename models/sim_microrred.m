function [SoC, V_tank, P_grid_vec, Q_p_vec, Q_DNO_vec, V_aq_vec, h_p_vec] = sim_microrred(P_dem, P_gen, Q_dem, Ts, Tsim)
    global V_max E_batt_max V_aq_0 S_aq T_aq rp h_p0 W_u

    Nt = Tsim / Ts;
    SoC = zeros(Nt,1);
    V_tank = zeros(Nt,1);
    P_grid_vec = zeros(Nt,1);
    Q_p_vec = zeros(Nt,1);
    Q_DNO_vec = zeros(Nt,1);
    V_aq_vec = zeros(Nt,1);
    h_p_vec = zeros(Nt,1);

    % Inicialización
    SoC(1) = 0.5;
    V_tank(1) = 20000;
    V_aq_vec(1) = V_aq_0;
    h_p_vec(1) = h_p0;

    % === Modo administrador ===
    modo_manual = false;

    if modo_manual
        load('data/Q_p_manual.mat');       % variable: Q_p_manual
        load('data/Q_DNO_manual.mat');     % variable: Q_DNO_manual
        load('data/P_grid_manual.mat');    % variable: P_grid_manual
    end

    for k = 1:Nt-1
        if modo_manual
            % === Modo administrador: tú defines las acciones ===
            Q_p = Q_p_manual(k);
            Q_DNO = Q_DNO_manual(k);
            P_grid_vec(k) = P_grid_manual(k);

            % Verificar si el acuífero permite bombear lo solicitado
            if V_aq_vec(k) < Q_p * Ts
                Q_p = 0;  % No se puede bombear si no hay agua suficiente
            end

            % Actualizar volumen del estanque
            Q_req = Q_dem(k) * Ts;
            V_tank(k+1) = V_tank(k) - Q_req + Q_DNO * Ts + Q_p * Ts;
            V_tank(k+1) = min(max(V_tank(k+1), 0), V_max);

            % Actualizar estado de carga con función manual
            SoC(k+1) = sim_energia_manual(P_dem(k), P_gen(k), SoC(k), Ts, Q_p, P_grid_vec(k));
        else
            % === Simulación automática ===
            [V_tank(k+1), Q_p, Q_DNO] = sim_agua(Q_dem(k), V_tank(k), V_aq_vec(k), Ts);
            [SoC(k+1), P_grid_vec(k)] = sim_energia(P_dem(k), P_gen(k), SoC(k), Ts, Q_p);
        end

        Q_p_vec(k) = Q_p;
        Q_DNO_vec(k) = Q_DNO;

        % === Acuífero ===
        s_k = (Q_p / (4 * pi * T_aq)) * W_u;
        h_p_vec(k+1) = h_p0 + s_k;
        V_aq_vec(k+1) = max(V_aq_vec(k) - Q_p * Ts, 0);
    end
end
