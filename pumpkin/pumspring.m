% Pumspring
%
% Draw a pumpkin with a ribbon, and then stretch it like a spring.

% Setup figure so we can animate on screen
fig = figure('Name','Pumpspring');
fig.Position(3:4) = [640 480];

n=300;  % Resolution of the sphere
S=10;   % Number of spirals
nb=12;  % Number of bumps
nframes=64;
colors=validatecolor(["#b50" "#f72"],'multiple');

% Theta goes around S times, with n verts per round.
T_=linspace(0,S*2,n*S);
T=[T_;T_]; % top and bottom of ribbon

% Phi goes from -.5 to .5 (top to bottom of sphere)
w=.1/3; % Ribbon thickness at rest (spring=3 when f=nframes/2)
P_=linspace(-.5+w,.5,n*S);
P=[P_;P_-w];

% Pumpkin on a unit sphere
X=cospi(P).*cospi(T);
Y=cospi(P).*sinpi(T);
Z=(.8+(0-(P*2).^4)*.2).*sinpi(P);
Zx=max(Z,[],'all');

% Radius modulated with bumps
R=1-(1-mod(T*nb,2)).^2/15;

% Draw
Srf=surf(R.*X,R.*Y,Z,R,'FaceColor','flat','EdgeColor','none');
surface(X/12,Y/12,Z/2+.9,[],'FaceColor','#080','EdgeColor','none');
camlight
lighting gouraud
material([.6 .9 .3 2 .5])
daspect([1 1 1]);
axis([-1 1 -1 1 -3 .5],'off');
colormap(interp1([1 256],colors,1:256));
set(gca,'Position',[0 0 1 1],'Clipping','off');
set(fig,'Color','w');

% Animate until figure is closed.
f = 0;
while isgraphics(fig)
    f = mod(f,nframes)+1;
    spring=sinpi(f/(nframes/2))+2;

    % Recompute ribbon thickness and Z for this spring amount
    w=.1/spring;
    P_=linspace(-.5+w,.5,n*S);
    P=[P_;P_-w];

    Z2=(.8+(0-(P*2).^4)*.2).*sinpi(P)*spring;
    Z2x=max(Z2,[],'all');
    Srf.ZData = Z2-diff([Zx Z2x]);

    pause(1/24);
end
