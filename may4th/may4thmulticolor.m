function may4thmulticolor(fname)
% may4thmulticolor - Make the may4th doodle expand and retract
%    with different colors.
% may4thmulticolor(fname) - Record to the .gif file FNAME.

    arguments
        fname string = ""
    end
    
    run may4th % Create it.
    
    GL=findobj('Color','#00f','type','light');
    
    axis manual
    doSet(B,BZ,GL,0);

    write(fname, 1/22, true);
 
    s = linspace(0,1,40);

    for c=["#00f" "#f00" "#0f0"]

        set(B,'FaceColor',c);
        set(GL,'Color',c);
        
        for i=s
            doSet(B,BZ,GL,i);
            write(fname);
        end

        write(fname,1);
        
        for i=flip(s)
            doSet(B,BZ,GL,i);
            write(fname);
        end

        write(fname,2);

    end
end

function write(fname, delay, first)
% Write a frame into a .gif file.
    arguments
        fname
        delay=1/32
        first=false
    end
    
    if fname==""
        pause(delay)
    else
        frame = getframe(gcf);
        
        im = frame2im(frame);
        [imind,cm] = rgb2ind(im,256);

        if first
            imwrite(imind,cm,fname,'gif', ...
                    'LoopCount',inf,...
                    'Delaytime',delay);
        else
            imwrite(imind,cm,fname,'gif',...
                    'WriteMode','append',...
                    'Delaytime',delay);
        end
    end
end

function doSet(B,BZ,GL,factor)
% Adjust Blade length
    set(B,'ZData',BZ*factor);

    % Blade Halo
    set(B(2),'ZData',BZ*1.005*factor);
    set(B(3),'ZData',BZ*1.01*factor);

    if factor<.01
        set(GL,'Visible','off');
    else
        set(GL,'Visible','on');
    end
end
