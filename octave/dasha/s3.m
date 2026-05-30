pkg load symbolic;

P1 = 0:0.5:14;
M = 12;
q = 2.6;

syms XA YA XB YB XC YC MC;

FQ = [q*4 0 0];MM = [0 0 M];
MMCL = [0 0 MC];
MMCR = [0 0 -MC];

FRA = [XA YA 0];
FRB = [XB YB 0];
FRCL = [XC YC 0];
FRCR = [-XC -YC 0];

A = [0 0 0];
B = [5 1 0];
C = [2 4 0];
D = [3.5 2.5 0];
E = [3.5 1.5 0];
G = [0 2 0];

for i = 1:length(P1)  
  FP1= [-P1(i)*cosd(45) -P1(i)*sind(45) 0];
  EQFL1 = FQ + FRA + FRCL == [0 0 0];
  EQML1 = cross(G,FQ) + cross (A, FRA) + cross (C, FRCL) + MM == [0 0 0];
  EQFR1 = FRB + FRCR + FP1 == [0 0 0];
  EQMR1 = cross(D,FP1) + cross(B,FRB) + cross(C,FRCR) == [0 0 0];

  Sys1= [EQFL1(1) EQFL1(2) EQFR1(1) EQFR1(2) EQML1(3) EQMR1(3)];
  solution1 = vpasolve(Sys1, [XA YA XB YB XC YC]);

  xa1(i) = eval(solution1(1));
  ya1(i) = eval(solution1(2));
  xb1(i) = eval(solution1(3));
  yb1(i) = eval(solution1(4));
  xc1(i) = eval(solution1(5));
  yc1(i) = eval(solution1(6));
  ra1(i) = sqrt(xa1(i)^2 + ya1(i)^2);
  rb1(i) = sqrt(xb1(i)^2 + yb1(i)^2);
  rc1(i) = sqrt(xc1(i)^2 + yc1(i)^2);

  EQFL2 = FQ + FRA + FRCL == [0 0 0];
  EQML2 = cross(G,FQ) + cross (A, FRA) + cross (C, FRCL) + MM == [0 0 0];
  EQFR2 = FRB + FRCR + FP1 == [0 0 0];
  EQMR2 = cross(D,FP1) + cross(B,FRB) + cross(C,FRCR) == [0 0 0];

  Sys2= [EQFL2(1) EQFL2(2) EQFR2(1) EQFR2(2) EQML2(3) EQMR2(3)];
  solution2 = vpasolve(Sys2, [XA YA XB YB XC YC]);

  xa2(i) = eval(solution2(1));
  ya2(i) = eval(solution2(2));
  xb2(i) = eval(solution2(3));
  yb2(i) = eval(solution2(4));
  xc2(i) = eval(solution2(5));
  yc2(i) = eval(solution2(6));
  ra2(i) = sqrt(xa2(i)^2 + ya2(i)^2);
  rb2(i) = sqrt(xb2(i)^2 + yb2(i)^2);
  rc2(i) = sqrt(xc2(i)^2 + yc2(i)^2);
endfor


figure

subplot(3,4,1)
plot(P1,xa1)
title('XA1')

subplot(3,4,2)
plot(P1,ya1)
title('YA1')

subplot(3,4,3)
plot(P1,ra1)
title('RA1')


subplot(3,4,7)
plot(P1,rb1)
title('RB1')

subplot(3,4,9)
plot(P1,xc1)
title('XC1')

subplot(3,4,10)
plot(P1,yc1)
title('YC1')

subplot(3,4,11)
plot(P1,rc1)
title('RC1')

## second part
figure

subplot(3,4,1)
plot(P1,xa2)
title('XA2')

subplot(3,4,2)
plot(P1,ya2)
title('YA2')

subplot(3,4,3)
plot(P1,ra2)
title('RA2')


subplot(3,4,7)
plot(P1,rb2)
title('RB2')

subplot(3,4,10)
plot(P1,yc2)
title('YC2')

printf('bearing\n');
printf('XA=%f ', xa1(end));
printf('YA=%f ', ya1(end));
printf('RA=%f\n',ra1(end));
printf('XB=%f ', xb1(end));
printf('YB=%f ', yb1(end));
printf('RB=%f\n',rb1(end));
printf('XC=%f ', xc1(end));
printf('YC=%f ', yc1(end));
printf('RC=%f\n',rc1(end));

printf('sliding seal\n');
printf('XA=%f ', xa2(end));
printf('YA=%f ', ya2(end));
printf('RA=%f\n',ra2(end));
printf('XB=%f ', xb2(end));
printf('YB=%f ', yb2(end));
printf('RB=%f\n',rb2(end));
printf('YC=%f ', yc2(end));