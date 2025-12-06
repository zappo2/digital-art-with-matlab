% Gift Bow
clf
N = 21; % # of loops and vertices

% Create geometry for each loop as a line in spherical coordinates
% and then convert to cartesian.
[X,Y,Z] = sph2cart(...
    repmat((1+sqrt(5))*(1:N),N,1)*pi,...
    (linspace(.5,1,N).^.8+linspace(-.2,.2,N)'.*linspace(.8,1,N))*pi,...
    repmat(1-abs(linspace(-1,1,N)'.^2),1,N));

% Use streamribbon to create the bow's ribbon.
% Streamribbon takes cell arrays, where each element represents the
% vertices (arg1) and twist angles (arg2) for each loop.
srf=streamribbon(...
    mat2cell([reshape(X,[],1),reshape(Y,[],1),reshape(Z,[],1)],repelem(N,N))',...
    mat2cell(repmat([pi/2;zeros(N-1,1)],N,1),repelem(N,N))',.3);

view([0 60]);
set(srf,'FaceColor','r','EdgeColor','none','FaceLighting','g');
axis off tight equal 
camlight

