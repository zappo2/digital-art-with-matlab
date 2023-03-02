% Pi Pie
PR = 8;  % radius of pie
PH = 2;  % height of pie tin

%%
% Get a bitmask for pi and convert to polyshape
set(clf,'Color','w');
t = text(.1,.1,'\pi','FontUnits','normal','FontSize',1,...
         'VerticalAlignment','baseline');
axis off
F = getframe(gca);

% Use contourc to find a continuous loop that is the pi symbol
% then convert to a polyshape centered around 0
cm = contourc(double(flipud(F.cdata(:,:,1))));
verts = cm(:,2:cm(2,1))';
verts = verts-min(verts);
ps = polyshape((verts/max(verts,[],'all')-.5)*PR);

%%
% Setup the pie pan, but make sure the # of verts we use matches
% what we need for pie scallops on the edge of the crust.

nb = 40; % number of scallops on edge of pie
nv = nb*10+1; % total number of verts around pie
theta = linspace(0,2,nv);

R = [ 0 0.8 1.0 1.1 1.1 1.03 0.95 ]'*PR; % pie pan radii
H = [ 0 0.0 0.9 0.9 1.0 0.95 1.00 ]'*PH; % pie pan Z

X = cospi(theta).*R;
Y = sinpi(theta).*R;
Z = ones(1,nv).*H;

surf(X,Y,Z,[],'FaceColor','#aaa','EdgeColor','#333','MeshStyle','row');

%%
% Pie Crust is a separate bit of geometry computed as
% a disk, and then add scalloped ridges and the symbol inset.

nr = 100; % num pts along radius
CR = linspace(0,PR,nr)';

% Disk, with Z raised slightly in the middle
CX = cospi(theta).*CR;
CY = sinpi(theta).*CR;
CZ = ones(1,nv).*cospi(linspace(0,.5,nr)')*(PH*.6)+PH;

% Add scalloped pie crust
SE = ((1-mod(linspace(0,2*nb,nv),2)).^2)*.1+1; % Scalloped Edge
CX((nr-4):nr,:) = CX((nr-4):nr,:).*SE;
CY((nr-4):nr,:) = CY((nr-4):nr,:).*SE;
CZ((nr-4):nr-1,:) = CZ((nr-4):nr-1,:)+PH*.2;

% Convert XYZ to Face/Vertices so we can vectorize our polyshape isinterior call.
% All verts within the pie symbol drop down slightly so you can see the filling.
CP = surf2patch(CX,CY,CZ);
mask = isinterior(ps,CP.vertices(:,1:2));
CP.vertices(mask,3)=CP.vertices(mask,3)-.2;

% Create CData that matches the mask we computed earlier.
FVC = ones(size(CP.vertices,1),1);
FVC(mask) = 0;

patch('Faces',CP.faces, 'Vertices',CP.vertices,...
      'FaceVertexCData', FVC, ...
      'FaceColor','interp','EdgeColor','none',...
      'BackFaceLighting','lit');

%%
% Blueberry pie colormap
colormap(validatecolor({'#460792' '#e7b985'},'multiple'));

% Fix aspect ratio, and overall look of the scene.
daspect([1 1 1]);
axis padded off
view([-45 20])
light('Position',[-10 -30 20],'Style','local');
material([.8 .5 .2 1 .2])
camzoom(2)
