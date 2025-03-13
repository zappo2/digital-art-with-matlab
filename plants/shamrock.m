% Shamrock
nleaf = 3; % Number of leaves
T=linspace(0,2,nleaf*30+1); % Theta vector
nvr=50; % # Vertices along the radius
R=linspace(0,1,nvr); % Radius vector
% Draw a stem
ST=linspace(-.36,-.48,nvr);
plot(cospi(ST).*R*1.1,sinpi(ST).*R*1.1,'Color','#2b2','LineWidth',5);
% Leaf shaped wave applied across the radius.
S=R'.*rescale(1-(abs((1-mod(T*nleaf,2)))-1/3).^2,.2,1);
% Draw shamrock
surface(S.*cospi(T-.4),S.*sinpi(T-.4),S*0,repmat(R',1,numel(T)),...
        'FaceColor','interp','EdgeColor','none');
m=zeros(nvr,3); m(:,2)=R;
colormap(gca,m);
% Decorate the Axes
axis equal off
