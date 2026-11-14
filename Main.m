%% STICK-LENGTH STABILISATION OF A DIWALI ROCKET
% Question: why does the half-stick rocket curve while the normal one flies straight?
% Idea: the stick is a weathervane. It moves the Centre of Pressure (CP) far
% behind the Centre of Gravity (CG), so any wobble gets pushed back.
clear; clc; close all
 % if ~exist('figures','dir'), mkdir figures; end
cN = [0 0.45 0.74];  cH = [0.85 0.33 0.10];      % blue = normal, orange = half

%% 1. INPUTS (SI units)
% ---- measured from your photos ----
P.d = 0.015;  P.Ln = 0.025;  P.Lbody = 0.060;    % diameter, nose cone, body tube
P.w = 0.005;                                      % stick width (check with a ruler)
P.Lext_full = 0.285;                              % stick below the body, normal rocket
P.m_total = 0.010;                                % whole normal rocket (kg)
P.tb = 0.5;                                       % burn time (s)  <- flame time from video
t_flight = 2.0;                                   % launch to burst (s)
% ---- ASSUMED: replace with measurements if you can ----
P.m_stick_full = 0.0015;                          % stick alone (kg): weigh it
P.mp = 0.003;                                     % powder (kg): launch mass - burnt mass
P.xh = 0.045;  P.xp = 0.065;  P.Lp = 0.04;        % head CG, powder CG, powder length (m from nose)
ang_default = deg2rad(0.3);                       % thrust misalignment (fitted below if video)
% ---- constants ----
P.rho = 1.2;  P.Cd = 0.8;  P.Cna = 2.0;  P.g = 9.81;
tgt = 1.0;                                        % stability target (calibres)
normalFile = 'normal_frames.jpg';  halfFile = 'half_frames.jpg';

%% 2. BUILD BOTH ROCKETS AND APPLY STABILITY THEORY
Lext = [P.Lext_full, P.Lext_full/2];
name = {'Normal stick','50% stick'};
for k = 1:2
  r = makeRocket(Lext(k), P);
  [r.marg, r.CP, r.CG1, r.CG2, r.K] = stability(r);   % add results BEFORE storing
  R(k) = r;                                           % every R(k) now has identical fields
end

%% 3. FIT THRUST: normal rocket must burst at t_flight (straight flight, no disturbance)
T = fzero(@(T) apoTime(R(1), T) - t_flight, [0.11 5]);
[t0, y0] = fly(R(1), T, 0);
fprintf('Fitted thrust T = %.2f N  ->  predicted apogee %.1f m\n', T, max(y0(:,1)));

%% 4. DISTURBANCE: fit from video if frames exist, else use default
useVideo = isfile(normalFile) && isfile(halfFile);
ang_use = ang_default;
if useVideo
  if isfile('obs_data.mat')
    load obs_data obs
  else
    obs(1) = digitize(normalFile);  obs(2) = digitize(halfFile);
    save obs_data obs
  end
  s0 = -sign(obs(2).X(end));  if s0 == 0, s0 = 1; end
  a  = fminbnd(@(a) pathErr(s0*a, R(2), T, obs(2)), 0, deg2rad(2));
  ang_use = s0*a;
  fprintf('Misalignment fitted to the 50%% video: %.2f deg\n', rad2deg(ang_use));
end

%% 5. SIMULATE BOTH ROCKETS WITH THE SAME DISTURBANCE
for k = 1:2
  [S(k).t, S(k).y] = fly(R(k), T, ang_use);
  S(k).maxth = min(max(abs(S(k).y(:,5)))*180/pi, 90);
  S(k).drift = S(k).y(end,3);
  S(k).h     = max(S(k).y(:,1));
  S(k).tum   = abs(S(k).y(end,5)) > 1.19;
end
Summary = table(name', 100*Lext', [R.marg]', 100*[R.CP]', 100*[R.CG1]', ...
  [S.maxth]', [S.drift]', [S.h]', ...
  'VariableNames', {'Rocket','StickBelowBody_cm','Margin_cal','CP_cm','CG_cm', ...
                    'MaxPitch_deg','Drift_m','Height_m'});
disp(Summary)
fprintf('Weathervane strength of the half stick = %.0f%% of the normal stick\n', ...
        100*R(2).K/R(1).K);

%% 6. SWEEP STICK LENGTH (the optimisation)
Lx = 0.02:0.01:0.45;  n = numel(Lx);
mg = zeros(1,n); mL = mg; mB = mg; cpv = mg; cgv = mg; Kv = mg;
mxth = mg; drf = mg; hgt = mg;
for j = 1:n
  r = makeRocket(Lx(j), P);
  [mg(j), cpv(j), cgv(j), cg2, Kv(j)] = stability(r);
  mL(j) = (cpv(j)-cgv(j))/P.d;  mB(j) = (cpv(j)-cg2)/P.d;
  [~, yy] = fly(r, T, ang_use);
  mxth(j) = min(max(abs(yy(:,5)))*180/pi, 90);
  drf(j)  = abs(yy(end,3));  hgt(j) = max(yy(:,1));
end
iM = find(mg >= tgt, 1);                         % shortest stick by static rule
iS = find(mxth < 5, 1);                          % shortest stick that flies straight (<5 deg)
fprintf('Static rule (margin >= %.1f cal): stick >= %.0f cm below body\n', tgt, 100*Lx(iM));
if ~isempty(iS)
  fprintf('Flight rule (pitch < 5 deg)     : stick >= %.0f cm below body (%.0f%% of normal)\n', ...
          100*Lx(iS), 100*Lx(iS)/P.Lext_full);
end

%% ================= FIGURES =================
% Fig 1: rockets drawn to scale with CP and CG
f1 = figure(1); set(f1,'Position',[50 50 1000 450]);
for k = 1:2
  r = R(k);  subplot(2,1,k); hold on
  patch(100*[0 r.Ln r.Ln], 100*[0 r.d/2 -r.d/2], [0.85 0.2 0.2]);
  rectangle('Position', 100*[r.Ln -r.d/2 r.Lbody r.d], 'FaceColor', [0.95 0.8 0.3]);
  rectangle('Position', 100*[r.Ln -r.w/2 r.Ls r.w], 'FaceColor', [0.8 0.8 0.9]);
  h1 = plot(100*r.CG1, 0, 'ro', 'MarkerFaceColor', 'r', 'MarkerSize', 9);
  h2 = plot(100*r.CP,  0, 'b^', 'MarkerFaceColor', 'b', 'MarkerSize', 9);
  xlim([-2 40]); ylim([-3 3]); grid on; ylabel('cm')
  title(sprintf('%s: CP is %.1f cm behind CG = %.2f calibres', name{k}, ...
        100*(r.CP-r.CG1), r.marg));
  if k == 1, legend([h1 h2], {'CG (launch)','CP'}, 'Location','northeast'); end
end
xlabel('Distance from nose tip (cm)')
saveFig(f1, 'fig1_geometry');

% Fig 2: stability theory vs stick length
f2 = figure(2); set(f2,'Position',[60 60 1000 800]);
subplot(3,1,1); hold on
plot(100*Lx, mL, 'b', 'LineWidth', 2);  plot(100*Lx, mB, 'r--', 'LineWidth', 2);
yline(tgt, 'k--', 'target'); yline(0, 'k:');
plot(100*Lext(1), R(1).marg, 'o', 'Color', cN, 'MarkerFaceColor', cN, 'MarkerSize', 9);
plot(100*Lext(2), R(2).marg, 's', 'Color', cH, 'MarkerFaceColor', cH, 'MarkerSize', 9);
ylabel('Margin (cal)'); grid on; title('(a) Stability margin = (CP - CG)/d')
legend('Launch','Burnout','','','Normal','Half','Location','northwest')
subplot(3,1,2); hold on
plot(100*Lx, 100*cpv, 'b', 'LineWidth', 2);  plot(100*Lx, 100*cgv, 'r', 'LineWidth', 2);
ylabel('Position from nose (cm)'); grid on; title('(b) CP moves back faster than CG')
legend('CP','CG (launch)','Location','northwest')
subplot(3,1,3); hold on
plot(100*Lx, 1e6*Kv, 'k', 'LineWidth', 2);
plot(100*Lext(1), 1e6*R(1).K, 'o', 'Color', cN, 'MarkerFaceColor', cN, 'MarkerSize', 9);
plot(100*Lext(2), 1e6*R(2).K, 's', 'Color', cH, 'MarkerFaceColor', cH, 'MarkerSize', 9);
xlabel('Stick length below body (cm)'); ylabel('K (cm^3)'); grid on
title('(c) Weathervane strength K = (total side area) x (CP - CG)')
saveFig(f2, 'fig2_stability_theory');

% Fig 3: flight of the normal rocket and thrust fit
f3 = figure(3); set(f3,'Position',[70 70 900 600]);
subplot(2,1,1); plot(t0, y0(:,1), 'Color', cN, 'LineWidth', 2); hold on
xline(P.tb, 'k--', 'burn-out'); xline(t_flight, 'g', 'burst (video)');
ylabel('Height (m)'); grid on
title(sprintf('Normal rocket: fitted thrust %.2f N, apogee %.1f m', T, max(y0(:,1))))
subplot(2,1,2); plot(t0, y0(:,2), 'r', 'LineWidth', 2); hold on
xline(P.tb, 'k--'); xlabel('Time (s)'); ylabel('Speed (m/s)'); grid on
saveFig(f3, 'fig3_flight_fit');

% Fig 4: same disturbance, two sticks
f4 = figure(4); set(f4,'Position',[80 80 1000 500]);
subplot(1,2,1); hold on
plot(S(1).y(:,3), S(1).y(:,1), 'Color', cN, 'LineWidth', 2);
plot(S(2).y(:,3), S(2).y(:,1), 'Color', cH, 'LineWidth', 2);
xlabel('Sideways position (m)'); ylabel('Height (m)'); grid on; axis equal
legend(name{1}, name{2}, 'Location', 'best'); title('(a) Simulated flight paths')
subplot(1,2,2); hold on
plot(S(1).t, S(1).y(:,5)*180/pi, 'Color', cN, 'LineWidth', 2);
plot(S(2).t, S(2).y(:,5)*180/pi, 'Color', cH, 'LineWidth', 2);
xlabel('Time (s)'); ylabel('Pitch angle (deg)'); grid on; title('(b) Pitch angle')
saveFig(f4, 'fig4_simulated_paths');

% Fig 5: stick length sweep
f5 = figure(5); set(f5,'Position',[90 90 1000 700]);
subplot(2,1,1)
yyaxis left;  plot(100*Lx, mxth, 'LineWidth', 2); ylabel('Max pitch angle (deg)')
yyaxis right; plot(100*Lx, drf, 'LineWidth', 2);  ylabel('Sideways drift at burst (m)')
hold on; xline(100*Lx(iM), 'k--', 'margin = 1 cal');
if ~isempty(iS), xline(100*Lx(iS), 'g', 'flies straight'); end
xline(100*Lext(1), ':', 'normal'); xline(100*Lext(2), ':', 'half');
grid on; title('(a) How straight the rocket flies vs stick length')
subplot(2,1,2)
plot(100*Lx, hgt, 'k', 'LineWidth', 2); hold on
xline(100*Lext(1), ':'); xline(100*Lext(2), ':');
xlabel('Stick length below body (cm)'); ylabel('Apogee (m)'); grid on
title('(b) Cost of a longer stick: lower height')
saveFig(f5, 'fig5_stick_sweep');

% Fig 6: model vs video (only if frames exist)
if useVideo
  f6 = figure(6); set(f6,'Position',[100 100 1000 500]);
  cc = {cN, cH};
  for k = 1:2
    subplot(1,2,k); hold on
    plot(obs(k).X, obs(k).Y, 'ko', 'MarkerFaceColor', 'k');
    plot(S(k).y(:,3), S(k).y(:,1), 'Color', cc{k}, 'LineWidth', 2);
    xlabel('Sideways position (m)'); ylabel('Height (m)'); grid on; axis equal
    legend('Video','Model','Location','best');
    title(sprintf('(%c) %s: straightness index video %.1f%%, model %.1f%%', 'a'+k-1, ...
          name{k}, straight(obs(k).X, obs(k).Y), straight(S(k).y(:,3), S(k).y(:,1))));
  end
  saveFig(f6, 'fig6_model_vs_video');
end

%% ================= LOCAL FUNCTIONS =================
function r = makeRocket(Lext, P)
  r = P;
  r.Lext = Lext;
  r.Ls = P.Lbody + Lext;                          % stick runs along the body, then hangs out
  r.rs = P.m_stick_full/(P.Lbody + P.Lext_full);  % stick mass per metre
  r.ms = r.rs*r.Ls;
  r.md = P.m_total - P.m_stick_full - P.mp;       % dry head (nose + tube)
  r.Lh = P.Ln + P.Lbody;
  r.xs = P.Ln + r.Ls/2;                           % stick centroid from nose
  r.xn = r.Lh;                                    % nozzle position
  r.A  = [0.5*P.d*P.Ln, P.d*P.Lbody, P.w*r.Ls];   % side areas: nose, body, stick
  r.X  = [2/3*P.Ln, P.Ln + P.Lbody/2, r.xs];      % their centroids
  r.Lc = [P.Ln, P.Lbody, r.Ls];                   % their lengths
end

function [marg, CP, CG1, CG2, K] = stability(r)
  CP  = sum(r.A.*r.X)/sum(r.A);                                   % area-weighted
  CG1 = (r.md*r.xh + r.mp*r.xp + r.ms*r.xs)/(r.md + r.mp + r.ms); % launch
  CG2 = (r.md*r.xh + r.ms*r.xs)/(r.md + r.ms);                    % burnout
  marg = min(CP-CG1, CP-CG2)/r.d;                                 % calibres, worst case
  K = sum(r.A)*(CP - CG1);                                        % weathervane strength
end

function dy = rhs(t, y, r, T, ang)
  v = y(2);  u = y(4);  th = y(5);  q = y(6);
  if t < r.tb, F = T;  mp = r.mp*(1 - t/r.tb); else, F = 0;  mp = 0; end
  m  = r.md + mp + r.ms;
  xg = (r.md*r.xh + mp*r.xp + r.ms*r.xs)/m;                       % CG now
  Iy = r.md*((r.xh-xg)^2 + r.Lh^2/12) + mp*((r.xp-xg)^2 + r.Lp^2/12) ...
       + r.ms*((r.xs-xg)^2 + r.Ls^2/12);                          % pitch inertia
  rr = r.X - xg;                                                  % arms behind CG
  S0 = sum(r.A);  S1 = sum(r.A.*rr);  S2 = sum(r.A.*(rr.^2 + r.Lc.^2/12));
  vp = max(v, 0);
  c  = 0.5*r.rho*r.Cna*vp;
  flow = vp*th - u;                                               % sideways air speed at CG
  N  = c*(S0*flow + S1*q);                                        % side force
  Ma = -c*(S1*flow + S2*q);                                       % restoring + damping moment
  D  = 0.5*r.rho*r.Cd*(pi*r.d^2/4)*v*abs(v);
  rn = r.xn - xg;
  dy = [ v;                                                       % h'
        (F - D)/m - r.g;                                          % v'
         u;                                                       % X'
        (N + (F - D)*th + F*ang)/m;                               % u'
         q;                                                       % theta'
        (Ma - F*ang*rn)/Iy ];                                     % q'
end

function [val, term, dir] = stopEvents(~, y)
  val = [y(2); 1.2 - abs(y(5))];     % apogee (v = 0), or tumble (|theta| > 69 deg)
  term = [1; 1];  dir = [-1; -1];
end

function [t, y] = fly(r, T, ang)
  opts = odeset('Events', @stopEvents, 'RelTol', 1e-6, 'AbsTol', 1e-9, 'MaxStep', 0.01);
  [t, y] = ode45(@(t,y) rhs(t, y, r, T, ang), [0 30], zeros(6,1), opts);
end

function tA = apoTime(r, T)
  t = fly(r, T, 0);  tA = t(end);
end

function s = straight(X, Y)
  p = polyfit(Y(:), X(:), 1);  res = X(:) - polyval(p, Y(:));
  s = 100*sqrt(mean(res.^2))/max(Y);
end

function e = pathErr(a, r, T, o)
  [~, y] = fly(r, T, a);
  [hs, iu] = unique(y(:,1));  xs = y(iu,3);
  ok = o.Y >= min(hs) & o.Y <= max(hs);
  if nnz(ok) < 3, e = 1e3; return; end
  e = sqrt(mean((interp1(hs, xs, o.Y(ok)) - o.X(ok)).^2));
end

function o = digitize(file)
  img = imread(file);  figure; imshow(img); hold on
  title('Click 2 points a KNOWN distance apart, then press Enter');
  [xc, yc] = ginput(2);
  dist = input(sprintf('Real distance between the 2 points in %s (m): ', file));
  scale = dist/hypot(diff(xc), diff(yc));
  title('Click the LAUNCH point, then points along the trail (bottom to top). Enter to finish.');
  [px, py] = ginput;
  o.X = (px - px(1))*scale;  o.Y = (py(1) - py)*scale;   % image y points down
  close(gcf);
end

function saveFig(f, name)
  folder = fullfile(pwd, 'figures');
  if ~isfolder(folder), mkdir(folder);end
  file = fullfile(folder, [name '.png']);
  try
    exportgraphics(f, file, 'Resolution', 300);
  catch
    saveas(f, file);
  end
end
