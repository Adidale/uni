T = 4;
t = 0:0.1:T/2;
G = 3;
a = 15;
b = 20;
c = 15;
R = 15;
r = 10;

syms XA YA ZA XB YB P h;
FA = [XA YA ZA];
FB = [XB YB 0];
FC = [P 0 0];
FG = [0 0 -G];
FT = [-T 0 0];
Ft = [-t*cosd(30) -t*sind(30) 0];

A = [0 0 0];
B = [0 0 a+b];
C = [0 -R a+b+c];
E = [0 r a];
H = [0 -r a];
K = [0 0 h];

for i = 1:length(t)
  Ft = [-t(i)*cosd(30) -t(i)*sind(30) 0];

  EQF = FA + FB + FC + FG + FT + Ft == [0 0 0];
  EQM = cross(A,FA) + cross(B,FB) + cross(C,FC) + cross(K, FG) + cross(H,FT) + cross(E,Ft) == [0 0 0];

  Sys = [EQF, EQM];
  solution = vpasolve(Sys,[XA YA ZA XB YB P]);

  xa(i) = eval(solution(1));
  ya(i) = eval(solution(2));
  za(i) = eval(solution(3));
  ra(i) = sqrt(xa(i)*xa(i) + ya(i)*ya(i) + za(i)*za(i));

  xb(i) = eval(solution(4));
  yb(i) = eval(solution(5));
  rb(i) = sqrt(xb(i)*xb(i) + yb(i)*yb(i));

  p(i) = eval(solution(6));
endfor

figure

subplot(3,4,1)
plot(t,xa)
title('XA')

subplot(3,4,2)
plot(t,ya)
title('YA')

subplot(3,4,3)
plot(t,za)
title('ZA')

subplot(3,4,4)
plot(t,ra)
title('RA')

subplot(3,4,5)
plot(t,xb)
title('XB')

subplot(3,4,6)
plot(t,yb)
title('YB')

subplot(3,4,8)
plot(t,rb)
title('RB')

subplot(3,4,9)
plot(t,p)
title('P')

printf('XA =%f\n',xa(length(t)));
printf('YA =%f\n',ya(length(t)));
printf('ZA =%f\n',za(length(t)));
printf('RA =%f\n',ra(length(t)));

printf('XB =%f\n',xb(length(t)));
printf('YB =%f\n',yb(length(t)));
printf('RB =%f\n',rb(length(t)));

printf('P =%f\n',p(length(t)));

