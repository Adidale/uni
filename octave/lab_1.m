syms t
r = 1 - cos(6 * t);
phi = t + 0.2 * cos(3 * t);

x = r .* cos(phi);
y = r .* sin(phi);


vx = diff(x);
vy = diff(y);


wx = diff(vx);
wy = diff(vy);


t = 0:0.01:15;


X = eval(x);
Y = eval(y);


VX = eval(vx);
VY = eval(vy);

VALPHA = atan2(VY, VX);


WX = eval(wx);
WY = eval(wy);

WALPHA = atan2(WY, WX);


figure

xlim([-8, 8]);
ylim([-10 4]);

axis equal;
hold on;

kv = 0.4;
kw = 0.2;


b = 0.15;
a = 5 * b;

ARROW = [-a, 0, -a; -b 0 b];


plot(X, Y, 'color', [0 0 0]);

POINT = plot(X(1), Y(1), 'o', 'markersize', 10, 'markerfacecolor', [0.3 0.7 0.3]);


VLINE = plot([X(1) X(1) + kv * VX(1)], [Y(1) Y(1) + kv * VY(1)], 'color', [0.1 0.2 0.8], 'linewidth', 2);

RARROW = Rot2D(ARROW, VALPHA(1));

VARROW = plot(RARROW(1, :), RARROW(2, :), 'color', [0.1 0.2 0.8], 'linewidth', 2);


WLINE = plot([X(1) X(1) + kw * WX(1)], [Y(1) Y(1) + kw * WY(1)], 'color', [0.8 0.2 0.1], 'linewidth', 2);

RARROW = Rot2D(ARROW, WALPHA(1));

WARROW = plot(RARROW(1, :), RARROW(2, :), 'color', [0.8 0.2 0.1], 'linewidth', 2);

for i = 1:length(t)

  set(POINT, 'xdata', X(i), 'ydata', Y(i));


  set(VLINE, 'xdata', [X(i) X(i) + kv * VX(i)], 'ydata', [Y(i) Y(i) + kv * VY(i)]);
  RARROW = Rot2D(ARROW, VALPHA(i));

  set(VARROW, 'xdata', X(i) + kv * VX(i) + RARROW(1, :), 'ydata', Y(i) + kv * VY(i) + RARROW(2, :));
  

  set(WLINE, 'xdata', [X(i) X(i) + kw * WX(i)], 'ydata', [Y(i) Y(i) + kw * WY(i)]);
  RARROW = Rot2D(ARROW, WALPHA(i));

  set(WARROW, 'xdata', X(i) + kw * WX(i) + RARROW(1, :), 'ydata', Y(i) + kw * WY(i) + RARROW(2, :));

  pause(0.01);
endfor

pause(30);