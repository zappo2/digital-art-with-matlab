% Plot an algorithmic Dahlia flower
%
% The math for this was found as a rose in Ned's community blog:
%   https://blogs.mathworks.com/community/2021/02/12/happy-valentines-day/
% but Ned found it at Paul Nylander's math art site:
%   http://www.bugman123.com/Math/index.html
% Updated for labeled parameters, rounded petals, new colors, and simplified some expressions. 

ppr=12.6; % # petals per 1 revolution
nr = 30; % radius resolution
pr = 10; % petal resolution
np = 140; % total number of petals
pf = -1.2; % How much the ends of the petals tilt up or down
ol = [ .11 1.1 ]; % How open is it? [ inner outer ]

pt = (1/ppr) * pi * 2;
theta=linspace(0, np*pt,np*pr+1);
[R,THETA]=ndgrid(linspace(0,1,nr),theta);
x = 1-(abs(1-mod(ppr*THETA, 2*pi)/pi).^2)*.7;
phi = (pi/2)*linspace(ol(1),ol(2),np*pr+1).^2;
y = pf*(R.^2).*(1.27689*R-1).^2.*sin(phi);
R2 = x.*(R.*sin(phi) + y.*cos(phi));

X=R2.*sin(THETA);
Y=R2.*cos(THETA);
Z=x.*(R.*cos(phi)-y.*sin(phi));
C=hypot(hypot(X,Y), Z);

% Draw the flower with nice colors
surf(X,Y,Z,C,FaceColor='interp', EdgeColor='none');
colormap(gca,[ linspace(.6,1,256); linspace(.1,.8,256); linspace(.7,1,256); ]');
daspect([1 1 1])
