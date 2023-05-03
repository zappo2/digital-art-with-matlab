SR=1; % Sword Handle Radius
BL=4; % Blade length as ratio to handle length

nv = 100+1;
theta = linspace(0,2,nv);

SLV = [ 0 0 4 5 5   6   6 10 10 9  9  10 10]'*SR*1.5;
SRV = [ 0 1 1 1 1.1 1.1 1 1  .9 .9 .7 .7 .6]'*SR;

% Create the silver handle
HX = cospi(theta).*SRV;
HY = sinpi(theta).*SRV;
HZ = ones(1,nv).*SLV;
HZ(8:9,:)=repmat(HZ(7,:)+6+sinpi(theta),2,1);
surf(HX,HY,HZ,[],'FaceColor','#aaa','EdgeColor','#333','MeshStyle','row');
material([.6 .6 .8 2 .8])

% Black grip
SE = ((1-mod(theta*10,2)).^2-.3).^3+1.01;
FX = cospi(theta).*SE.*SRV(2:3);
FY = sinpi(theta).*SE.*SRV(2:3);
FZ = ones(1,nv).*SLV(2:3);
surface(FX,FY,FZ,[],'FaceColor', '#444', 'EdgeColor', 'none');

% Blade
BL = [ 10 9.5+BL*10 10+BL*10 ]'*SR*1.5;
BR = [ .5 .4      .1]'*SR;
BX = cospi(theta).*BR;
BY = sinpi(theta).*BR;
BZ = ones(1,nv).*BL;

B=[surface(BX,BY,BZ,[],'FaceColor', '#66f', 'EdgeColor', 'none'); % Blade
   surface(BX*1.6,BY*1.6,BZ*1.005,[],'FaceColor', '#66f', 'EdgeColor', 'none', 'FaceAlpha', .3); %Halo
   surface(BX*1.9,BY*1.9,BZ*1.01,[],'FaceColor', '#66f', 'EdgeColor', 'none', 'FaceAlpha', .2)];
material(B,[.6 .6 1 1 1]) % simulate inner glow via more reflectance

% Light and blade glow effects
light('Position', [-2 -2 12*SR*1.5], 'Style', 'local', 'Color', '#00f');
light('Position',[-10 -30 30],'Style','local', 'Color', '#ddd');

% Improve overall look of the scene.
axis tight off
view([-45 20])
set(gca,'CameraUpVector',[0 1 .3],'DataAspectRatio',[1 1 1]);

