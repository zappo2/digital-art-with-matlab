function v=bblob(C,nx,ny,nz,a,b)
% Blinn's blobs
% V = BBLOB(C) Compute blobs around centers C, which is a nx3 array
%              of vertices.  The returned mesh is 64x64x64
% V = BBLOB(C,NX,NY,NZ) As above, except the computed mesh is
%              NXxNYxNZ in size
% V = BBLOB(C,NX,NY,NZ,A,B) As above, but also specify special
%             inputs Alpha and Beta as 2 scaling factors
%
% Make something vaguely benzene like as follows:
%   newplot
%   theta=linspace(0,300,6);
%   centers=[20+8*cosd(theta);20+8*sind(theta);20+zeros(1,6)]';
%   v=bblob(centers,40,40,40);
%   patch(isosurface(v,.8), 'facecolor', 'yellow','edgecolor','none');
%   view(3)
%   axis equal
%   camlight
%   lighting g

% Originally Written by Mike Garrity
% From ACM Transactions on Graphics, July 1982, Volume 1, Number 3.
% "A Generalization of Algebraic Surface Drawing" James F. Blinn
%
% Compressed code by Eric Ludlam

    arguments
        C
        nx=64, ny=64, nz=64
        a=.05, b=1
    end

    [y,x,z]=ndgrid(1:ny,1:nx,1:nz);    
    v=zeros(ny,nx,nz);
    for i=1:size(C,1)
        v=v+b*exp(-a*((C(i,1)-x).^2 + (C(i,2)-y).^2 + (C(i,3)-z).^2));
    end

end
