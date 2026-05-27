clear;

Q = 0.1:0.1:2;
a = 40;
b = 60;
c = 30;

syms XA ZA XB ZB RC;
FA = [XA 0 ZA];
FB = [XB 0 ZB];
FC = [0 0 -RC];
FQ = [Q*cosd(30) 0 -Q*sind(30)];

A = [0 0 0];
B = [0 2.5*a 0];
C = [-a 1.5*a b];
E = [-0.5*a 1.5*a c];

for i = 1:length(Q)
  FQ = [Q(i)*cosd(30) 0 -Q(i)*sind(30)]

  EQF = FA + FB + FC + FQ == [0 0 0]
  EQM = cross(B,FB) + cross(C,FC) + cross(A,FA) + cross(E,FQ) == [0 0 0]

  Sys = [EQF(1) EQF(3) EQM]
  solution = vpasolve(Sys,[XA ZA XB ZB RC]);
  solution

  xa(i) = eval(solution(1));
  za(i) = eval(solution(2));
  ra(i) = sqrt(xa(i)*xa(i) + za(i)*za(i));

  xb(i) = eval(solution(3));
  zb(i) = eval(solution(4));
  rb(i) = sqrt(xb(i)*xb(i) + zb(i)*zb(i));

  rc(i) = eval(solution(5));
endfor

figure

subplot(3,4,1)
plot(Q,xa)
title('XA')

subplot(3,4,3)
plot(Q,za)
title('ZA')

subplot(3,4,4)
plot(Q,ra)
title('RA')

subplot(3,4,5)
plot(Q,xb)
title('XB')

subplot(3,4,8)
plot(Q,rb)
title('RB')

subplot(3,4,9)
plot(Q,rc)
title('RC')

printf('XA =%f\n',xa(length(Q)));
printf('ZA =%f\n',za(length(Q)));
printf('RA =%f\n',ra(length(Q)));

printf('XB =%f\n',xb(length(Q)));
printf('ZB =%f\n',zb(length(Q)));
printf('RB =%f\n',rb(length(Q)));

printf('RC =%f\n',rc(length(Q)));
