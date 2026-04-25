%% Daffodil Colors & Sizes
pc = '#faca00'; % petal color
sc = '#7cbf4a'; % stem color
np = 6; % number of petals.
tr = .23; % Radius of trumpet
nruf = 10; % number of trumpet ruffles
sruf = .03; % size of trumpet ruffles
sr = .05; % radius of the stem
sh = 3.5; % Height of the stem
ln = 6; % number of leaves
lw = .3; % Leaf width
lh = 2.8; % Height of a leaf

%% Unit circle arrays
n = np*50+1; % Theta resolution
theta = linspace(0,2,n);
nr = 20; % Radus resolution
r = linspace(0,1,nr)';

%% Petals
PR = r .* ((1-abs(1-mod(theta*np, 2)))/2+.5);
PX = PR .* cospi(theta);
PY = PR .* sinpi(theta);
PZ = r.^3*.05+hypot(PX,PY)*.2;
% Face our flower sideways by swapping Y&Z
surf(PX,PZ,PY,[],'FaceColor',pc,'EdgeColor','none');

%% Trumpet
flute = flip(1-r*.3);
ruffle = ((cospi(theta*nruf)+2)*sruf).*r.^5;
ruffle2 = ((cospi(theta*nruf*3)+2)*sruf/3).*r.^9;
TR = tr*flute + ruffle + ruffle2;
surface(TR.*cospi(theta),r*tr*3.2,TR.*sinpi(theta),'FaceColor',pc,'EdgeColor','none');

%% Stem
SR = sr .* ones(nr,1);
surface(SR.*cospi(theta),SR.*sinpi(theta)-sr,r*-sh.*ones(1,n),'FaceColor',sc,'EdgeColor','none');

%% Leaves
rn = 100; % # verts in radius
tn = 11; % # verts in theta
R  = linspace(0,.6,rn)';
RR = (R*1.2+sr+.05) - abs(linspace(-1,1,tn)*.04);
T  = linspace(-lw,lw,tn) .* linspace(1,0,rn).^2';
ll = linspace(0,2,ln+1);

for a=ll(1:end-1) % Leaf positions
    surface(RR.*cospi(T+a),RR.*sinpi(T+a)-sr,sinpi(R*.9)*lh.*ones(1,tn)-sh,'FaceColor',sc,'EdgeColor','none');
end

%% Configure Axes & Lighting
set(gca,'YDir','reverse','Projection','perspective','Visible','off','DataAspectRatio',[1 1 1])
light('Position',[1.7 1.7 4],'Color','w');
lighting gouraud
material([.8 .9 .2 2 .4])
view([-44 20]);
