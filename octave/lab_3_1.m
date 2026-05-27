r = 25;
l = 100;
b = 12.5;

p = 0:0.1:6.3;

syms t
Theta = -pi/6 + (pi/9)*sin(3*t);
Phi = -pi/3 + (pi/2)*sin(t);

X = l*cos(Phi);
YA = l*sin(Phi);
YB = l + YA;

YO = l/2 + YA;
XC = X + b*cos(Theta);
YC = YO + b*sin(Theta);
vCx = diff(XC, t);
vCy = diff(YC, t);
wCx = diff(vCx, t);
wCy = diff(vCy, t);
Vphi = atan2(vCy, vCx);
Wphi = atan2(wCy, wCx);

t = 0:0.1:10;
theta = eval(Theta);
phi = eval(Phi);
x = eval(X);
yA = eval(YA);
yB = eval(YB);

yO = eval(YO);
xC = eval(XC);
yC = eval(YC);

VX = eval(vCx);
VY = eval(vCy);
VPHI = eval(Vphi);
WX = eval(wCx);
WY = eval(wCy);
WPHI = eval(Wphi);

circlex = r*cos(p);
circley = r*sin(p);

Arrow = [-10 0 -10; -4 0 4];
Kv = 0.6;
Kw = 0.3;

figure

subplot(3,2,1)
plot(t,xC)
title('xC')

subplot(3,2,2)
plot(t,yC)
title('yC')

subplot(3,2,3)
plot(t,VX)
title('vCx')

subplot(3,2,4)
plot(t,VY)
title('vCy')

subplot(3,2,5)
plot(t,WX)
title('wCx')

subplot(3,2,6)
plot(t,WY)
title('wCy')

figure
xlim([-120 150])
ylim([-160 120])
hold on
axis equal

Vline = plot([yC(1) yC(1) + Kv*VY(1)], -[xC(1) xC(1) + Kv*VX(1)], 'color', [0.1 0.1 0.5]);
Rarrow = Rot2D(Arrow, VPHI(1));
Varrow = plot(yC(1)+Kv*VY(1)+Rarrow(2, :), -xC(1)-Kv*VX(1)-Rarrow(1, :), 'color', [0.1 0.1 0.5]);

Wline = plot([yC(1) yC(1) + Kw*WY(1)], -[xC(1) xC(1) + Kw*WX(1)], 'color', [0.5 0.1 0.1]);
Rarrow = Rot2D(Arrow, WPHI(1));
Warrow = plot(yC(1)+Kw*WY(1)+Rarrow(2, :), -xC(1)-Kw*WX(1)-Rarrow(1, :), 'color', [0.5 0.1 0.1]);

POINTA1 = plot(0,0,'o','Markersize',5,'markerfacecolor',[0 0 0]);
POINTA = plot(yA(1), -x(1), 'o', 'Markersize', 5, 'markerfacecolor', [0 0 0]);
A1A = plot([0 yA(1)], [0 -x(1)], 'color', [0 0 0]);

POINTB1 = plot(l, 0, 'o', 'Markersize', 5, 'markerfacecolor', [0 0 0]);
POINTB = plot(yB(1), -x(1), 'o', 'Markersize', 5, 'markerfacecolor', [0 0 0]);
B1B = plot([l yB(1)], [0 -x(1)], 'color', [0 0 0]);

AB = plot([yA(1) yB(1)], [-x(1) -x(1)], 'color', [0 0 0]);
POINTO = plot(yO(1), -x(1), 'o', 'Markersize', 5, 'markerfacecolor', [0 0 0]);

OC = plot([yO(1) yC(1)], [-x(1) -xC(1)], 'color', [0 0 0]);
POINTC = plot(yC(1), -xC(1), 'o', 'Markersize', 5, 'markerfacecolor', [0.9 0.1 0.1]);
TRC = plot(yC(1), -xC(1), 'color', [0.9 0.1 0.1]);
CIRCLE = plot(yC(1) + circley, -xC(1) + circlex, 'color', [0 0 0]);

for i = 1:length(t)
    set(POINTA, 'Xdata', yA(i), 'Ydata', -x(i));
    set(POINTB, 'Xdata', yB(i), 'Ydata', -x(i));

    set(A1A, 'Xdata', [0 yA(i)], 'Ydata', [0 -x(i)]);
    set(B1B, 'Xdata', [l yB(i)], 'Ydata', [0 -x(i)]);
    set(AB, 'Xdata', [yA(i) yB(i)], 'Ydata', [-x(i) -x(i)]);

    set(POINTO, 'Xdata', yO(i), 'Ydata', -x(i));
    set(POINTC, 'Xdata', yC(i), 'Ydata', -xC(i));
    
    set(OC, 'Xdata', [yO(i) yC(i)], 'Ydata', [-x(i) -xC(i)]);
    set(CIRCLE, 'Xdata', yC(i) + circley, 'Ydata', -xC(i) + circlex);

    set(TRC, 'Xdata', yC(1:i), 'Ydata', -xC(1:i));

    set(Vline, 'Xdata', [yC(i) yC(i)+Kv*VY(i)], 'Ydata', -[xC(i) xC(i)+Kv*VX(i)]);
    Rarrow = Rot2D(Arrow, VPHI(i));
    set(Varrow, 'Xdata', yC(i)+Kv*VY(i)+Rarrow(2, :), 'Ydata', -xC(i)-Kv*VX(i)-Rarrow(1, :));

    set(Wline, 'Xdata', [yC(i) yC(i)+Kw*WY(i)], 'Ydata', -[xC(i) xC(i)+Kw*WX(i)]);
    Rarrow = Rot2D(Arrow, WPHI(i));
    set(Warrow, 'Xdata', yC(i)+Kw*WY(i)+Rarrow(2, :), 'Ydata', -xC(i)-Kw*WX(i)-Rarrow(1, :));

    pause(0.05)
endfor