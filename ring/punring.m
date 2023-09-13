%% A gold ring with an inscription
clf
% Create an image with our text
str = {'When \phi and \theta collude' 'a truncated torus extrude' };
axes('Position',[0 0 1 1]);
pbaspect([3 1 1]);
text(0,.25,str,'FontSize',10,'FontName','Lucida Calligraphy',...
     'BackgroundColor','#da4','Margin',350);
g=getframe;

% Create the ring geometry
[theta, phi] = meshgrid(linspace(.6,-1.4,100),linspace(.5,2.5,40));
X = (1-(min(cospi(phi),0)*.2)).*cospi(theta);
Y = (1-(min(cospi(phi),0)*.2)).*sinpi(theta);
Z = -sinpi(phi)*.3;

% Draw
surf(X,Y,Z,g.cdata,'FaceColor','texture','EdgeColor','none');
axis off equal
lighting gouraud
material([.6 .9 .9 5 .3])
camlight
