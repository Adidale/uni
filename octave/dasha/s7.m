T = 4;
t = 0:0.1:T/2;
G = 2;
Q = 1;
a = 30;
b = 40;
c = 20;
R = 20;
r = 10;

syms XA ZA XB ZB P;
FA = [XA 0 ZA];
FB = [XB 0 ZB];
FP = [0 0 -P];
FG = [0 0 -G];
FQ = [-Q*cosd(45) 0 Q*sind(45)]
FT = [T*cosd(30) 0 T*sind(30)];
Ft = [-t*cosd(30) 0 0];

A = [0 0 0];
B = [0 a+b 0];
H = [R a 0];
J = [r*cosd(45) a r*sind(45)];
K = [r*sind(30) a+b+c -r*cosd(30)];
N = [0 a+b+c r];

for i = 1:length(t)
  Ft = [-t(i)*cosd(30) 0 0];

  EQF = FA + FB + FP + FG + FQ + FT + Ft == [0 0 0];
  EQM = cross(A,FA) + cross(B,FB) + cross(H,FP) + cross(J,FG) + cross(J,FQ) + cross(K,FT) + cross(N,Ft) == [0 0 0];

  Sys = [EQF(1) EQF(3) EQM];
  solution = vpasolve(Sys,[XA ZA XB ZB P]);

  xa(i) = eval(solution(1));
  za(i) = eval(solution(2));
  ra(i) = sqrt(xa(i)*xa(i) + za(i)*za(i));

  xb(i) = eval(solution(3));
  zb(i) = eval(solution(4));
  rb(i) = sqrt(xb(i)*xb(i) + zb(i)*zb(i));

  p(i) = eval(solution(5));
endfor

figure

subplot(3,4,1)
plot(t,xa)
title('XA')

subplot(3,4,3)
plot(t,za)
title('ZA')

subplot(3,4,4)
plot(t,ra)
title('RA')

subplot(3,4,5)
plot(t,xb)
title('XB')

subplot(3,4,7)
plot(t,zb)
title('ZB')

subplot(3,4,8)
plot(t,rb)
title('RB')

subplot(3,4,9)
plot(t,p)
title('P')

printf('XA =%f\n',xa(length(t)));
printf('ZA =%f\n',za(length(t)));
printf('RA =%f\n',ra(length(t)));

printf('XB =%f\n',xb(length(t)));
printf('ZB =%f\n',zb(length(t)));
printf('RB =%f\n',rb(length(t)));

printf('P =%f\n',p(length(t)));

