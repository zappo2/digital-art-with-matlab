function may4thanimation(fname)
% may4thanimation - Make the may4th doodle expand and retract.
% may4thanimation(fname) - Record to the file FNAME.

    arguments
        fname string = ""
    end
    
    run may4th % Create it.

    GL=findobj('Color','#00f','type','light');
    
    axis manual
    doSet(B,BZ,GL,0);

    write(fname, 1/22, true);

    s = linspace(0,1,40);

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

function write(fname, delay, first)
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
% Blade
    set(B,'ZData',BZ*factor);

    % Blade Halo
    set(B(2),'ZData',BZ*1.005*factor);
    set(B(3),'ZData',BZ*1.01*factor);

    if factor<.2
        set(GL,'Visible','off');
    else
        set(GL,'Visible','on');
    end
end
