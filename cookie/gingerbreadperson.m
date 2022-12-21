% Create a gingerbread person cookie
K=['    xxx    '
   '   xxxxx   '
   '   xxxxx   '
   '    xxx    '
   'xx       xx'
   ' xx xxx xx '
   '  xxxxxxx  '
   '   xxxxx   '
   '   xxxxx   '
   '   xxxxx   '
   '   xxxxx   '
   '  xx   xx  '
   'xxx     xxx'
   ' x       x '];
% Convert K into array of blob centers
[y,x]=find(~isspace(K));
% Scale and offset centers into 3D cookie space
C=[x*5,y*5]+5;  C(:,3)=10;

% Compute a volume using a short implementation of Blinn's blobs
nx=size(K,2)*5+10;  ny=size(K,1)*5+10;  nz=20; % Size of volume
[y,x,z]=ndgrid(1:ny,1:nx,1:nz);
vol=zeros(ny,nx,nz);
for i=1:size(C,1)
    vol=vol+exp(-.05*((C(i,1)-x).^2 + (C(i,2)-y).^2 + (C(i,3)-z).^2));
end

% Compute isosurface from the blobs
S=isosurface(vol,.3);
% Draw the isosurface using patch
newplot
patch(S,'FaceColor','#a56c3c','EdgeColor','none'); % cookie
axis equal ij off
lighting gouraud
camlight
material([.6 .9 .3 ])
