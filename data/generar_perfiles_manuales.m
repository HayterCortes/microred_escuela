% =======================
% Script para generar perfiles manuales de control
% =======================

clear; clc;

% -----------------------
% Parámetros de simulación
% -----------------------
dias = 7;             % duración en días
Ts = 60;              % paso de simulación [s]
Nt = dias * 24 * 3600 / Ts;

% Vector de tiempo en horas (opcional para visualizar)
t_h = (0:Nt-1) * Ts / 3600;

% -----------------------
% Perfil de compra de energía al DNO
% -----------------------
% Comprar 100 kW entre las 19:00 y 23:00 cada día
P_grid_manual = zeros(Nt, 1);
valor_P = 100;                  % [kW]
horas_on_P = [8, 16];        % horario diario de compra

for d = 0:dias-1
    h_ini = d * 24 + horas_on_P(1);
    h_fin = d * 24 + horas_on_P(2);
    idx = t_h >= h_ini & t_h < h_fin;
    P_grid_manual(idx) = valor_P;
end

% -----------------------
% Perfil de bombeo de pozo
% -----------------------
% Bombear 10 L/s entre 12:00 y 18:00 cada día
Q_p_manual = zeros(Nt, 1);
valor_Qp = 10;                % [L/s]
horas_on_Qp = [8, 16];       % horario diario de bombeo

for d = 0:dias-1
    h_ini = d * 24 + horas_on_Qp(1);
    h_fin = d * 24 + horas_on_Qp(2);
    idx = t_h >= h_ini & t_h < h_fin;
    Q_p_manual(idx) = valor_Qp;
end

% -----------------------
% Perfil de compra de agua al DNO
% -----------------------
% Comprar 10 L/s entre 8:00 y 10:00 cada día
Q_DNO_manual = zeros(Nt, 1);
valor_Qdno = 10;              % [L/s]
horas_on_Qdno = [8, 16];      % horario diario de compra

for d = 0:dias-1
    h_ini = d * 24 + horas_on_Qdno(1);
    h_fin = d * 24 + horas_on_Qdno(2);
    idx = t_h >= h_ini & t_h < h_fin;
    Q_DNO_manual(idx) = valor_Qdno;
end

% -----------------------
% Guardar vectores .mat
% -----------------------
save('data/P_grid_manual.mat', 'P_grid_manual');
save('data/Q_p_manual.mat', 'Q_p_manual');
save('data/Q_DNO_manual.mat', 'Q_DNO_manual');

disp('Perfiles manuales generados y guardados en carpeta data/');
