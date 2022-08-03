% Plot an algorithmic Rose
%
% The math for this was found as a rose in Ned's community blog:
%   https://blogs.mathworks.com/community/2021/02/12/happy-valentines-day/
% but Ned found it at Paul Nylander's math art site:
%   http://www.bugman123.com/Math/index.html
% Updated for labeled parameters, new colors and simplified some expressions. 

ppr= 3.6; % # petals per 1 revolution
nr = 30; % radius resolution
pr = 30; % petal resolution
np = 40; % total number of petals
pf = 1.995653; % How much the ends of the petals tilt up or down
ps = 5/4; % Separation between petals
ol = [ .2 1.02 ]; % How open is it? [ inner outer ]

pt = (1/ppr) * pi * 2;
theta=linspace(0, np*pt,np*pr+1);
[R,THETA]=ndgrid(linspace(0,1,nr),theta);
x = 1-(ps*(1-mod(ppr*THETA, 2*pi)/pi).^2-1/4).^2 / 2;
phi = (pi/2)*linspace(ol(1),ol(2),np*pr+1).^2;
y = pf*(R.^2).*(1.27689*R-1).^2.*sin(phi);
R2 = x.*(R.*sin(phi) + y.*cos(phi));

X=R2.*sin(THETA);
Y=R2.*cos(THETA);
Z=x.*(R.*cos(phi)-y.*sin(phi));
C=hypot(hypot(X,Y), Z);

% Draw the flower with nice colors
surf(X,Y,Z,C,FaceColor='interp', EdgeColor='none');
colormap(gca,[ linspace(0,1,256); zeros(1,256); zeros(1,256)]');
daspect([1 1 1])
