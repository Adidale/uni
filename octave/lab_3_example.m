R = 20;
a = 10;
L = 15;
rC = 0.55*a;
rD = 0.12*L;
N = 3;

t = 0:0.1:30;
p = 0:0.1:6.3;

psi = pi/12 - (pi/6)*sin(2*t);
phi = -pi/4 + cos(t);

circlex = R*cos(p);
circley = R*sin(p);

xA = a*cos(phi);
yA = a*sin(phi);
xB = xA - L*cos(psi);
yB = yA + L*sin(psi);

xC = rC*cos(phi);
yC = rC*sin(phi);
xD = xA - rD*cos(psi);
yD = yA + rD*sin(psi);

alpha = -psi(1):0.1:2*pi*N + phi(1);
ralpha = alpha*((-rD + a - rC) / (2*pi*N + psi(1) + phi(1))) + (2*N*pi*rD + psi(1)*a - psi(1)*rC + rD*phi(1)) / (2*pi*N + psi(1) + phi(1));
xsp = xA(1) - ralpha.*cos(alpha);
ysp = yA(1) - ralpha.*sin(alpha);

figure
xlim([-30 30])
ylim([-30 30])
axis equal
hold on

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

  alpha = -psi(i):0.1:2*pi*N + phi(i);
  ralpha = alpha*((-rD + a - rC) / (2*pi*N + psi(i) + phi(i))) + (2*N*pi*rD + psi(i)*a - psi(i)*rC + rD*phi(i)) / (2*pi*N + psi(i) + phi(i));
  xsp = xA(i) - ralpha.*cos(alpha);
  ysp = yA(i) - ralpha.*sin(alpha);
  set(Spr,'Xdata',-ysp,'Ydata',xsp);

  pause(0.01);
endfor

pause(30)