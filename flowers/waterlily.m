%% Water Lily
npetals = 60;
vpp = 23; % Vertices in theta per petal
vrpp = 15; % Vertices in R per petal

% Shorteners
lsp=@(n)linspace(0,1,n);
lsv=@(n)linspace(-1,1,n);
vec=@(m)reshape(m',1,[]);
ip1=@(r,v,n)interp1(r*(n-1),v,0:(n-1));

% Shape of one petal
PR = 1-abs(lsv(vpp)); % V shape

% Apply petal shape to each point in a fibonacci spiral
PT_ROWS = lsv(vpp)/2.*ip1([0 .5 1],[.3 .8 .1],npetals)';
PTHETA_VEC = vec(PT_ROWS+((1+sqrt(5))*(1:npetals))');
% Apply petal shape across dome in PHI
PPHI_VEC = vec(ones(npetals,vpp).*rescale(lsp(npetals).^.9,0,.4)');
PPHI_MESH = PPHI_VEC+lsp(vrpp)'.^4*.03; % U shaped petals
DPHI_MESH = vec(PR.*ip1([0 5 1],[0 .05 .1],npetals)');
% R varies across each pt in the spiral
PMR_MESH = vec(PR.*(linspace(1,.5,npetals).^2)').*lsp(vrpp)';
CORE = lsp(vpp*npetals).^2*.6;
W = cospi(PPHI_MESH+DPHI_MESH).*(PMR_MESH+CORE);

% Final Geometry
X = cospi(PTHETA_VEC).*W;
Y = sinpi(PTHETA_VEC).*W;
Z = sinpi(PPHI_MESH+DPHI_MESH).*PMR_MESH*1.7+CORE*.4;

% Colors
yellow = validatecolor(["#c7d49c" "#d5ebbd" "#f8e70c" "#bf5700" ], 'multiple');

% Plot it and setup axes
surf(X,Y,Z,PPHI_MESH);
shading interp
lighting gouraud
material([.9 .9 .4 1.2 .4])
daspect([1 1 1]);
light('position',[1 0 5])
colormap(gca,ip1([0 .4 .8 1],yellow,256));
axis padded
view([-19 60]);


