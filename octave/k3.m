clear;

% Given data
OA = 30;
AB = 60;
AC = 15;
omega_OA = 3;
epsilon_OA = 8;
phi = 120;

% Instant configuration from sketch:
% AB is horizontal (+x), and OA makes 60 deg with +x.
theta_OA = 180 - phi; % 60 deg

% Position vectors
rA = [OA*cosd(theta_OA), OA*sind(theta_OA)];
rBA = [AB, 0];
rCA = [AC, 0];

% Velocity and acceleration of point A (rotation about O)
% v_A = omega_OA x r_A
vA = [-omega_OA*rA(2), omega_OA*rA(1)];

% a_A = epsilon_OA x r_A - omega_OA^2 * r_A
aA = [-epsilon_OA*rA(2), epsilon_OA*rA(1)] - (omega_OA^2)*rA;

% For link AB:
% v_B = v_A + omega_AB x r_BA
% a_B = a_A + epsilon_AB x r_BA - omega_AB^2 * r_BA
%
% Slider B moves on a horizontal guide => v_By = 0 and a_By = 0.
omega_AB = -vA(2)/AB;
epsilon_AB = -aA(2)/AB;

vB = vA + [-omega_AB*rBA(2), omega_AB*rBA(1)];
aB = aA + [-epsilon_AB*rBA(2), epsilon_AB*rBA(1)] - (omega_AB^2)*rBA;

% Point C on rigid body AB
vC = vA + [-omega_AB*rCA(2), omega_AB*rCA(1)];
aC = aA + [-epsilon_AB*rCA(2), epsilon_AB*rCA(1)] - (omega_AB^2)*rCA;

% Print equations and results
v_B_mag = sqrt(vB(1)^2 + vB(2)^2);
a_B_mag = sqrt(aB(1)^2 + aB(2)^2);
v_C_mag = sqrt(vC(1)^2 + vC(2)^2);
a_C_mag = sqrt(aC(1)^2 + aC(2)^2);

printf('v_B = %.6f\n', v_B_mag);
printf('a_B = %.6f\n', a_B_mag);
printf('v_C = %.6f\n', v_C_mag);
printf('a_C = %.6f\n', a_C_mag);
printf('omega_AB = %.6f\n', omega_AB);
printf('epsilon_AB = %.6f\n', epsilon_AB);