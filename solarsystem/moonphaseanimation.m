%% Draw the moon and animate phases
if ~exist('moonrgb','var')
    % Download the moon texture once
    url="https://svs.gsfc.nasa.gov/vis/a000000/a004700/a004720/lroc_color_poles_2k.tif";
    moonrgb=webread(url);
end
% Create the Graphic
clf; set(gcf,'color','black');
[x,y,z]=sphere(100);
surf(x,y,z,flipud(moonrgb(:,:,1:3)),'FaceColor','texture','EdgeColor','none',...
     'FaceLighting','gouraud','BackfaceLighting','unlit');
daspect([1 1 1])
axis off tight vis3d
view([90 0]);
camzoom(1.5) % Fill more of the figure
material([.15 1 0 1 0]); % No atmosphere
% Create phases of the moon
sun=light('style','infinite'); % the sun is far away
for phi=linspace(2,0,100)
    set(sun,'Position',[cospi(phi) sinpi(phi) 0]*10);
    pause(.05)
end
