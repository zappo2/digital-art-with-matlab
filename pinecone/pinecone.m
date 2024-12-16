%% Pinecone
nscales = 140; % Number of scales
height = 2.5; % Height of inner part of pinecone
nn = 18; % Number of needles
vps = 17; % verts per scale : An odd number so 1 vert is in center
vpr = 20; % verts per radius

% Scale locations
FIB = (1+sqrt(5))*(1:nscales); % Fibonacci golden ratio as factor of pi
H = linspace(0,1,nscales).^2.8*height; % Height of the root of each scale
R = 1-linspace(-1,1,nscales).^2; % Radius of pinecone over height
U = 1-abs(linspace(-1,1,nscales).^3); % Thickness of scale U shape by height

% Geometry of the scales at the locations
ST = reshape((linspace(-.5,.5,vps)*.3+FIB')', 1,[]);
SR = reshape(((1-abs(linspace(-1,1,vps).^3)).*R')',1,[]);
SH = reshape((ones(1,vps).*H'+abs(linspace(-1,1,vps).^3.*U')*.2)',1,[]);
MR = linspace(0,1,vpr)'.*SR;

% Compute final geometry of the pinecone
X = cospi(ST).*MR;
Y = sinpi(ST).*MR;
Z = SH.*ones(vpr,1)+MR.*linspace(0,1,vps*nscales).^2.1*1.2;
C = linspace(0,1,vpr).^2'.*ones(1,vps*nscales);

% Plot pinecone
set(gcf,'Color','#fffafa');
plot3(X(end,:),Y(end,:),-Z(end,:),'-','Color','#cccccc');
surface(X,Y,-Z,C,'EdgeColor','none');
shading interp

% Brown colormap
br = validatecolor(["#000" "#783D03"], 'multiple');
colormap(interp1([1 256],br,1:256));

% Branch & Needles
line('XData',0:.5:2,'YData',zeros(1,5),'ZData',[ 0 .05 .2 .25 .2 ],...
     'Color',br(1,:), 'LineWidth',5);
NT = linspace(0,5,nn)';
NR = linspace(.1,.8,nn)';
NV = [ 0 0 0; -ones(nn,1)*2 cospi(NT).*NR sinpi(NT).*NR+.9 ];
NF = [ ones(nn,1) (1:nn)'+1 ];
patch('Vertices',NV,'Faces',NF,'EdgeColor','#0F9666','FaceColor','none',...
      'LineWidth',1.5);

% Setup Axes
set(gca,'Position',[0 0 1 1],'Clipping','off','DataAspectRatio',[1 1 1]);
axis([-1.3 1.3 -1.3 1.3 -height+.2 .5],'off')
material([.6 1 .3])
lighting g
light('Position',[13.2 7.2 16.5]);
