r = 25;
l = 100;
b = 12.5;

t = 0:0.01:10;
p = 0:0.1:6.3;

theta = -pi/6 + (pi/9)*sin(3*t);
phi = -pi/3 + (pi/2)*sin(t);

circlex = r*cos(p);
circley = r*sin(p);

x = l*cos(phi);
yA = l*sin(phi);
yB = l + yA;

yO = l/2 + yA;
xC = x + b*cos(theta);
yC = yO + b*sin(theta);

figure
xlim([-120 150])
ylim([-120 120])
hold on
axis equal

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

    pause(0.01)
endfor