clear; clc;

% Cargar parámetros y datos
run('data/params_energia.m');
run('data/params_agua.m');
load('data/P_dem_escuela.mat');
load('data/P_gen_escuela.mat');
load('data/Q_dem_escuela.mat');

% Configuración de tiempo
Ts = 60;                       % paso de simulación [s]
Tsim = 24 * 3600 * 7;          % 7 días

% Simulación principal (con acuífero)
[SoC, V_tank, P_grid_vec, Q_p_vec, Q_DNO_vec, P_pump_vec, V_aq_vec, h_p_vec] = sim_microrred(P_dem, P_gen, Q_dem, Ts, Tsim);
% Guardar resultados
save('results/resumen_variables.mat', ...
     'SoC', 'V_tank', 'P_grid_vec', 'Q_p_vec', 'Q_DNO_vec', 'P_pump_vec' ,'V_aq_vec', 'h_p_vec');

% Graficar resultados de la simulación
plot_resultados(SoC, V_tank, P_grid_vec, Q_p_vec, Q_DNO_vec, P_pump_vec, V_aq_vec, h_p_vec, Ts);

% Gráfico adicional: perfiles de entrada
plot_gen_dem_perfiles(P_dem, P_gen, Q_dem, Ts);
