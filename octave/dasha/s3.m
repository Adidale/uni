P1 = 14;
M = 12;
q = 2.6;
Q = 4*q;

// edit from here
FP1 = [P1 0 0];
FP2 = [0 -P2 0];
MM = [0 0 -M];
FQ = [Q*sind(30) -Q*cosd(30) 0];

A = [-2 3 0];
B = [4*cosd(30) 4*sind(30) 0];
C = [0 0 0];
D = [-2 1 0];
E = [5*cosd(30) 5*sind(30) 0];
G = [2*cosd(30) 2*sind(30) 0];

syms XA YA MA N XC YC MC;

RA = [XA YA 0];
MRA = [0 0 MA];
RB = [-N*cosd(60) N*sind(60) 0];
RC1 = [XC YC 0];
RC2 = [0 YC 0];
MRC2 = [0 0 MC];


for i = 1:length(P2)
  FP2 = [0 -P2(i) 0]
  EQFL1 = FP1 + RA + RC1 == [0 0 0];
  EQML1 = cross(D,FP1) + MM + cross(A,RA) + MRA + cross(C,RC1) == [0 0 0];
  EQFR1 = FP2 + FQ + RB - RC1 == [0 0 0];
  EQMR1 = cross(E,FP2) + cross(G,FQ) + cross(B,RB) - cross(C,RC1) == [0 0 0];

  Sys1 = [EQFL1(1), EQFL1(2), EQML1(3), EQFR1(1), EQFR1(2), EQMR1(3)];
  solution1 = vpasolve(Sys1, [XA YA MA N XC YC]);

  xa1(i) = eval(solution1(1));
  ya1(i) = eval(solution1(2));
  ma1(i) = eval(solution1(3));
  ra1(i) = sqrt(xa1(i)*xa1(i) + ya1(i)*ya1(i));
  rb1(i) = eval(solution1(4));
  xc1(i) = eval(solution1(5));
  yc1(i) = eval(solution1(6));
  rc1(i) = sqrt(xc1(i)*xc1(i) + yc1(i)*yc1(i));

  EQFL2 = FP1 + RA + RC2 == [0 0 0];
  EQML2 = cross(D,FP1) + MM + cross(A,RA) + MRA + cross(C,RC2) + MRC2 == [0 0 0];
  EQFR2 = FP2 + FQ + RB - RC2 == [0 0 0];
  EQMR2 = cross(E,FP2) + cross(G,FQ) + cross(B,RB) - cross(C,RC2) - MRC2 == [0 0 0];

  Sys2 = [EQFL2(1), EQFL2(2), EQML2(3), EQFR2(1), EQFR2(2), EQMR2(3)];
  solution2 = vpasolve(Sys2, [XA YA MA N YC MC]);

  xa2(i) = eval(solution2(1));
  ya2(i) = eval(solution2(2));
  ma2(i) = eval(solution2(3));
  ra2(i) = sqrt(xa2(i)*xa2(i) + ya2(i)*ya2(i));
  rb2(i) = eval(solution2(4));
  yc2(i) = eval(solution2(5));
  mc2(i) = eval(solution2(6));
endfor

figure

subplot(3,4,1)
plot(P2,xa1)
title('XA1')

subplot(3,4,2)
plot(P2,ya1)
title('YA1')

subplot(3,4,3)
plot(P2,ra1)
title('RA1')

subplot(3,4,4)
plot(P2,ma1)
title('MA')

subplot(3,4,7)
plot(P2,rb1)
title('RB1')

subplot(3,4,9)
plot(P2,xc1)
title('XC1')

subplot(3,4,10)
plot(P2,yc1)
title('YC1')

subplot(3,4,11)
plot(P2,rc1)
title('RC1')

## second part
figure

subplot(3,4,1)
plot(P2,xa2)
title('XA2')

subplot(3,4,2)
plot(P2,ya2)
title('YA2')

subplot(3,4,3)
plot(P2,ra2)
title('RA2')

subplot(3,4,4)
plot(P2,ma2)
title('MA2')

subplot(3,4,7)
plot(P2,rb2)
title('RB2')

subplot(3,4,10)
plot(P2,yc2)
title('YC2')

subplot(3,4,12)
plot(P2,mc2)
title('MC2')

print('baearing:\n');
printf('XA =%f\n',xa1(length(P2)));
printf('YA =%f\n',ya1(length(P2)));
printf('MA =%f\n',ma1(length(P2)));
printf('RA =%f\n',ra1(length(P2)));
printf('RB =%f\n',rb1(length(P2)));
printf('XC =%f\n',xc1(length(P2)));
printf('YC =%f\n',yc1(length(P2)));
printf('RC =%f\n',rc1(length(P2)));

print('idk:\n');
printf('XA =%f\n',xa2(length(P2)));
printf('YA =%f\n',ya2(length(P2)));
printf('MA =%f\n',ma2(length(P2)));
printf('RA =%f\n',ra2(length(P2)));
printf('RB =%f\n',rb2(length(P2)));
printf('YC =%f\n',yc2(length(P2)));

