R = 20;
a = 10;
L = 15;
rC = 0.55*a;
rD = 0.12*L;
N = 3;

p = 0:0.1:6.3;

syms t
Psi = pi/12 - (pi/6)*sin(2*t);
Phi = -pi/4 + cos(t);

XA = a*cos(Phi);
YA = a*sin(Phi);
XB = XA - L*cos(Psi);
YB = YA + L*sin(Psi);
vBx = diff(XB, t);
vBy = diff(YB, t);
wBx = diff(vBx, t);
wBy = diff(vBy, t);
Vphi = atan2(vBy, vBx);
Wphi = atan2(wBy, wBx);


t = 0:0.1:30;
psi = eval(Psi);
phi = eval(Phi);
xA = eval(XA);
yA = eval(YA);
xB = eval(XB);
yB = eval(YB);

VX = eval(vBx);
VY = eval(vBy);
VPHI = eval(Vphi);
WX = eval(wBx);
WY = eval(wBy);
WPHI = eval(Wphi);

circlex = R*cos(p);
circley = R*sin(p);

xC = rC*cos(phi);
yC = rC*sin(phi);
xD = xA - rD*cos(psi);
yD = yA + rD*sin(psi);

alpha = -psi(1):0.1:2*pi*N + phi(1);
ralpha = alpha*((-rD + a - rC) / (2*pi*N + psi(1) + phi(1))) + (2*N*pi*rD + psi(1)*a - psi(1)*rC + rD*phi(1)) / (2*pi*N + psi(1) + phi(1));
xsp = xA(1) - ralpha.*cos(alpha);
ysp = yA(1) - ralpha.*sin(alpha);

Arrow = [-2 0 -2; -0.75 0 0.75];
Kv = 0.6;
Kw = 0.3;

figure

subplot(3,2,1)
plot(t,xB)
title('xB')

subplot(3,2,2)
plot(t,yB)
title('yB')

subplot(3,2,3)
plot(t,VX)
title('vBx')

subplot(3,2,4)
plot(t,VY)
title('vBy')

subplot(3,2,5)
plot(t,WX)
title('wBx')

subplot(3,2,6)
plot(t,WY)
title('wBy')

figure
xlim([-25 25])
ylim([-25 25])
axis equal
hold on

Vline = plot(-[yB(1) yB(1) + Kv*VY(1)], [xB(1) xB(1) + Kv*VX(1)], 'color', [0.1 0.1 0.5]);
Rarrow = Rot2D(Arrow, VPHI(1));
Varrow = plot(-yB(1)-Kv*VY(1)-Rarrow(2, :), xB(1) + Kv*VX(1) + Rarrow(1, :), 'color', [0.1 0.1 0.5]);

Wline = plot(-[yB(1) yB(1) + Kw*WY(1)], [xB(1) xB(1) + Kw*WX(1)], 'color', [0.5 0.1 0.1]);
Rarrow = Rot2D(Arrow, WPHI(1));
Warrow = plot(-yB(1)-Kw*WY(1)-Rarrow(2, :), xB(1) + Kw*WX(1) + Rarrow(1, :), 'color', [0.5 0.1 0.1]);

POINTO = plot(0,0,'o','Markersize',5,'markerfacecolor',[0 0 0]);
CIRCLE = plot(-circley, circlex, 'color', [0 0 0]);
POINTA = plot(-yA(1), xA(1), 'o', 'Markersize', 5, 'markerfacecolor', [0 0 0]);
POINTB = plot(-yB(1), xB(1), 'o', 'Markersize', 5, 'markerfacecolor', [0 0 0]);
POINTC = plot(-yC(1), xC(1), 'o', 'Markersize', 2, 'markerfacecolor', [0.1 0.9 0.1]);
POINTD = plot(-yD(1), xD(1), 'o', 'Markersize', 2, 'markerfacecolor', [0.1 0.9 0.1]);
OA = plot([0 -yA(1)], [0 xA(1)], 'color', [0 0 0]);
AB = plot([-yA(1) -yB(1)], [xA(1) xB(1)], 'color', [0 0 0]);
TRB = plot(-yB(1), xB(1), 'color', [0.9 0.1 0.1]);
Spr = plot(-ysp, xsp, 'color', [0.1 0.9 0.1]);

for i = 1:length(t)
  set(POINTA,'Xdata',-yA(i),'Ydata',xA(i));
  set(POINTB,'Xdata',-yB(i),'Ydata',xB(i));

  set(OA,'Xdata',[0 -yA(i)],'Ydata',[0 xA(i)]);
  set(AB,'Xdata',[-yA(i) -yB(i)],'Ydata',[xA(i) xB(i)]);
  
  set(POINTC,'Xdata',-yC(i),'Ydata',xC(i));
  set(POINTD,'Xdata',-yD(i),'Ydata',xD(i));

  set(TRB,'Xdata',-yB(1:i),'Ydata',xB(1:i));

  set(Vline, 'Xdata', -[yB(i) yB(i) + Kv*VY(i)], 'Ydata', [xB(i) xB(i) + Kv*VX(i)]);
  Rarrow = Rot2D(Arrow, VPHI(i));
  set(Varrow, 'Xdata', -yB(i)-Kv*VY(i)-Rarrow(2, :), 'Ydata', xB(i) + Kv*VX(i) + Rarrow(1, :));

  set(Wline, 'Xdata', -[yB(i) yB(i) + Kw*WY(i)], 'Ydata', [xB(i) xB(i) + Kw*WX(i)]);
  Rarrow = Rot2D(Arrow, WPHI(i));
  set(Warrow, 'Xdata', -yB(i)-Kw*WY(i)-Rarrow(2, :), 'Ydata', xB(i) + Kw*WX(i) + Rarrow(1, :));

  alpha = -psi(i):0.1:2*pi*N + phi(i);
  ralpha = alpha*((-rD + a - rC) / (2*pi*N + psi(i) + phi(i))) + (2*N*pi*rD + psi(i)*a - psi(i)*rC + rD*phi(i)) / (2*pi*N + psi(i) + phi(i));
  xsp = xA(i) - ralpha.*cos(alpha);
  ysp = yA(i) - ralpha.*sin(alpha);
  set(Spr,'Xdata',-ysp,'Ydata',xsp);

  pause(0.1);
endfor

pause(30)

