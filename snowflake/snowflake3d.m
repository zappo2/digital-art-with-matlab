function snowflake3d(steps, thickness)
% Draw a 3d snowflake from a vector of step lengths
% The 3d render will draw the snowflake with the specified thickness
%
% Example: Random Snowflake
%    snowflake3d rand
%
% Example: Big Center Flake
%    snowflake3d([10 2 8 7 6 5]);
%
% Example: Double Star flake
%    snowflake3d([1 5 5 8 8 8 8]);
%
% Example: Flake with thick edges
%    snowflake3d([5 2 1 1 5 1 1 5 8]);
    
    arguments
        steps=[5 2 5 5 5 5]
        thickness=1
    end

    % Get the snowflake geometry as a polyshape
    ps = snowflake(steps);

    % Convert into a 3D triangulation with specified depth
    tri = ps.triangulation();

    % Face and edge connectivity for one layer.
    points= tri.Points;
    faces = tri.ConnectivityList();
    edges = tri.freeBoundary;

    % Constants for this shape when computing connecting edges
    range = 1:size(edges,1);      % All the boundary edges.
    layer2 = size(points, 1); % Layer 2 starts here.

    % Generate the final polygon as a triangulation.
    TRI = triangulation([faces; fliplr(faces)+layer2; % top and bottom
                         edges(range,[2 1 2])+[0 0 layer2]; % edges connecting top/bottom
                         edges(range,[1 1 2])+[0 layer2 layer2];
                        ],...
                        [ points repelem( thickness/2,layer2,1) ;  % points is 2d, add 3rd dim
                          points repelem(-thickness/2,layer2,1) ]);

    % Draw the 3d triangulation
    pts3 = TRI.Points;
    trisurf(TRI, 'FaceVertexCData', hypot(pts3(:,1),pts3(:,2)));
    shading interp
    alpha(.5)
    daspect([1 1 1]);
    colormap(gca,winter);
    box on
    zlim([-5 thickness+5]);
    camlight

end
