a = 10;
b = 15;
rF = 2;
N = 2;
theta = atan(2/3);

syms t

S = 2*sin(3*t);
Phi = -(pi/4)*sin(2*t);

XA = a*sin(Phi);
YA = a*cos(Phi);
XB = b*sin(Phi);
YB = b*cos(Phi);

XD = b*sin(Phi) + S.*cos(Phi);
YD = sqrt(b.^2 + (b.*tan(Phi)).^2) - (b.*tan(Phi) + S).*sin(Phi);
vDx = diff(XD, t);
vDy = diff(YD, t);
Vphi = atan2(vDy, vDx);
wDx = diff(vDx, t);
wDy = diff(vDy, t);
Wphi = atan2(wDy, wDx);

XF = rF*sin(Phi + theta);
YF = rF*cos(Phi + theta);

t = 0:0.1:10;
s = eval(S);
phi = eval(Phi);

xA = eval(XA);
yA = eval(YA);
xB = eval(XB);
yB = eval(YB);

xD = eval(XD);
yD = eval(YD);
VX = eval(vDx);
VY = eval(vDy);
VPHI = eval(Vphi);
WX = eval(wDx);
WY = eval(wDy);
WPHI = eval(Wphi);

xF = eval(XF);
yF = eval(YF);

alpha = -phi(1):0.1:2*pi*N + phi(1) + theta;
ralpha = rF * (alpha - phi(1)) / (theta + 2*pi*N - phi(1));
xsp = ralpha.*sin(alpha);
ysp = ralpha.*cos(alpha);

l = 1;
Square = [-l l l -l -l; 0 0 2*l 2*l 0];
c = 10;
Body = [-c -c c c; -12 0 0 -12];
e = 2;
Base = [-c -e 0 e c; 3 3 0 3 3];

Arrow = [-2 0 -2; -0.75 0 0.75];
Kv = 0.6;
Kw = 0.3;

figure

subplot(3,2,1)
plot(t,xD)
title('xD')

subplot(3,2,2)
plot(t,yD)
title('yD')

subplot(3,2,3)
plot(t,VX)
title('vDx')

subplot(3,2,4)
plot(t,VY)
title('vDy')

subplot(3,2,5)
plot(t,WX)
title('wDx')

subplot(3,2,6)
plot(t,WY)
title('wDy')

figure
xlim([-30 20])
ylim([-10 30])
hold on
axis equal

Vline = plot([xD(1) xD(1) + Kv*VX(1)], [yD(1) + l yD(1) + l + Kv*VY(1)],'color',[0.1 0.1 0.5],'linewidth',2);
Rarrow = Rot2D(Arrow, VPHI(1));
Varrow = plot(xD(1) + Kv*VX(1) + Rarrow(1, :), yD(1) + l + Kv*VY(1) + Rarrow(2, :),'color',[0.1 0.1 0.5],'linewidth',2);

Wline = plot([xD(1) xD(1) + Kw*WX(1)], [yD(1) + l yD(1) + l + Kw*WY(1)],'color',[0.5 0.1 0.1],'linewidth',2);
Rarrow = Rot2D(Arrow, WPHI(1));
Warrow = plot(xD(1) + Kw*WX(1) - Rarrow(1, :), yD(1) + l + Kw*WY(1) + Rarrow(2, :),'color',[0.5 0.1 0.1],'linewidth',2);

POINTO = plot(0,0,'o','Markersize',5,'markerfacecolor',[0 0 0]);
Rbase = Rot2D(Base,-phi(1));
BaseO = plot(Rbase(1, :),Rbase(2, :),'color',[0 0 0],'linewidth',2);

POINTA = plot(xA(1),yA(1),'o','Markersize',5,'markerfacecolor',[0 0 0]);
POINTB = plot(xB(1),yB(1),'o','Markersize',5,'markerfacecolor',[0 0 0]);
Rbody = Rot2D(Body,-phi(1));
BodyB = plot(xB(1) + Rbody(1, :),yB(1) + Rbody(2, :),'color',[0 0 0],'linewidth',2);

Rsquare = Rot2D(Square,-phi(1));
SquareD = plot(xD(1) + Rsquare(1, :),yD(1) + Rsquare(2, :),'color',[0.9 0.1 0.1],'linewidth',2);

POINTF = plot(xF(1),yF(1),'o','Markersize',5,'markerfacecolor',[0.1 0.9 0.1]);
Spr = plot(xsp,ysp,'color',[0.1 0.9 0.1],'linewidth', 10);
TRD = plot(xD(1),yD(1) + l,'color',[0.9 0.1 0.1],'linewidth', 1);

for i = 1:length(t)
    Rbase = Rot2D(Base, -phi(i));
    set(BaseO,'Xdata',Rbase(1, :),'Ydata',Rbase(2, :));

    set(POINTA,'Xdata',xA(i),'Ydata',yA(i));
    set(POINTB,'Xdata',xB(i),'Ydata',yB(i));
    Rbody = Rot2D(Body, -phi(i));
    set(BodyB,'Xdata',xB(i) + Rbody(1, :),'Ydata',yB(i) + Rbody(2, :));

    Rsquare = Rot2D(Square, -phi(i));
    set(SquareD,'Xdata',xD(i) + Rsquare(1, :),'Ydata',yD(i) + Rsquare(2, :));
    set(TRD,'Xdata',xD(1:i),'Ydata',yD(1:i) + l);

    set(Vline,'Xdata',[xD(i) xD(i) + Kv*VX(i)],'Ydata',[yD(i) + l yD(i) + l + Kv*VY(i)]);
    Rarrow = Rot2D(Arrow, VPHI(i));
    set(Varrow,'Xdata',xD(i) + Kv*VX(i) + Rarrow(1, :),'Ydata',yD(i) + l + Kv*VY(i) + Rarrow(2, :));

    set(Wline,'Xdata',[xD(i) xD(i) + Kw*WX(i)],'Ydata',[yD(i) + l yD(i) + l + Kw*WY(i)]);
    Rarrow = Rot2D(Arrow, WPHI(i));
    set(Warrow,'Xdata',xD(i) + Kw*WX(i) + Rarrow(1, :),'Ydata',yD(i) + l + Kw*WY(i) + Rarrow(2, :));

    set(POINTF,'Xdata',xF(i),'Ydata',yF(i));

    alpha = -phi(i):0.1:2*pi*N + phi(i) + theta;
    ralpha = rF * (alpha - phi(i)) / (theta + 2*pi*N - phi(i));
    xsp = ralpha.*sin(alpha);
    ysp = ralpha.*cos(alpha);

    set(Spr,'Xdata',xsp,'Ydata',ysp);

    pause(0.05)
endfor