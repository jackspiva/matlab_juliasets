clear; clf;

c2 = -2;
cinc2 = (0.07);
filename2 = 'juliachangingc2.gif';
iterations2 = 35;
changing_juliaset(c2, cinc2, filename2, iterations2);

c = -0.1+0.6i;
cinc = (0.005+0.001i);
filename = 'juliachangingc.gif';
iterations = 75;
changing_juliaset(c, cinc, filename, iterations);




function f = changing_juliaset(c, c_inc, filename, num_iterations)

    for kk=1:num_iterations
        
        A = 1.5;                          % Set 
        N = 1000;                         % Set array size
        x_vec = -A + (0:N) / N * 2 * A;   % Create 
        y_vec = x_vec;
        
        for i=1:length(x_vec)
            for j=1:length(y_vec)
                
                x(i,j)=x_vec(i); 
                y(i,j)=y_vec(j);
                
            end;
        end;
        
        z = x+sqrt(-1)*y;
        f = @(z) z.^2 + c;

        % Iterate 25 function calls
        for k=1:25
            
            z = f(z);

        end

        a=abs(z);
        a=min(a,1);
        a=1-a;
        a=(a>0); a=a+1;
        
        subplot(111);
        b = rot90(a);
        image([-A,A],[-A,A],b);
        colormap([1 0 0; 1 1 1]);
        axis([-A,A,-A,A]); axis('square');
        set(gca,'Fontsize',24);
        xlabel('x','Fontsize',24);
        ylabel('y','Fontsize',24);
        c_str=num2str(c);
        
        if c>=0
            
            title(['Julia set for f(z) = z^2+ ',c_str]);
            
        else
            
            title(['Julia set for f(z) = z^2 ',c_str]);
            
        end;
        
        drawnow limitrate
        
        F = getframe();
        im = frame2im(F);
        [Q,map] = rgb2ind(im,256);
        if kk == 1
            imwrite(Q,map,filename,'gif','LoopCount',Inf,'DelayTime',0.12);
        else
            imwrite(Q,map,filename,'gif','WriteMode','append','DelayTime',0.12);
        end

        c = c + c_inc;  
        
    end; 
    
    close all;
end
