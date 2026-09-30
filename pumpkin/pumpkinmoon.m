%% Pumpkin Moon - moon phases on a pumpkin

% Download the moon texture once
if ~exist('moonrgb','var')
    url="https://svs.gsfc.nasa.gov/vis/a000000/a004700/a004720/lroc_color_poles_2k.tif";
    moonrgb=webread(url);
end

% Setup figure
fig = figure('Name','Pumpkin Moon');
fig.Position(3:4) = [640 640];
set(fig,'Color','black');

%% Pumpkin
bumps=10; bdepth=.03; bdepth2=.007; dimple=.1; width_r=1; height_r=.95;
[Xs,Ys,Zs]=sphere(199);
Rxy=(0-(1-mod(linspace(0,bumps*2,200),2)).^2)*bdepth + (0-(1-mod(linspace(0,bumps*4,200),2)).^2)*bdepth2;
Rz=(0-linspace(1,-1,200)'.^4)*dimple;
Xp=(width_r+Rxy).*Xs;
Yp=(width_r+Rxy).*Ys;
Zp=(height_r+Rz).*Zs.*(Rxy+1);

tint=reshape([1 .75 .45],1,1,3); % orange tint
moontex=uint8(double(flipud(moonrgb(:,:,1:3))).*tint);
surf(Xp,Yp,Zp,moontex,'FaceColor','texture','EdgeColor','none',...
     'FaceLighting','gouraud','BackFaceLighting','unlit','Clipping','off');

% Stem - small sphere offset to the top
surface(Xs/12,Ys/12,Zs/6+height_r-dimple,moontex,'FaceColor','texture','EdgeColor','none',...
        'FaceLighting','gouraud','BackFaceLighting','unlit','Clipping','off');

%% Setup scene
material([.15 1 0 1 0]);
daspect([1 1 1])
axis off tight vis3d
axtoolbar('visible','off');
view([90 0]);
camzoom(1.5)

% Phases of the pumpkin moon
sun=light('Style','infinite');
nframes=100;
phases=linspace(2,0,nframes+1);
phases(end)=[];

f=0;
while isgraphics(fig)
    f=mod(f,nframes)+1;
    set(sun,'Position',[cospi(phases(f)) sinpi(phases(f)) 0]*10);
    pause(.05)
end
