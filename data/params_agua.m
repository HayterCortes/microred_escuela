global V_max Q_pump_max Q_DNO_max
V_max = 40000;        % litros
Q_pump_max = 30;      % L/s
Q_DNO_max = 1e6;      % L/s

% === Parámetros del acuífero (desde la tesis) ===
global V_aq_0 S_aq T_aq rp h_p0 W_u
V_aq_0 = 1e6*0.1;           % Volumen inicial del acuífero [L]
S_aq = 0.1906;          % Coef. almacenamiento
T_aq = 35.1062 / 86400; % Transmisividad [m²/s]
rp = 0.2;               % Radio del pozo [m]
h_p0 = 2;              % Profundidad inicial del pozo [m]
W_u = 1;                % Aproximación inicial a función de pozo
