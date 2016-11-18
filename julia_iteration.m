clear; clf;
    
c = -0.778-.116i;
jiteration(c, 'jit1.gif');

c = .274-0.008i;
jiteration(c, 'jit2.gif');

function f = jiteration(c, filename)
    % Initialize c, z, r, and the function

    A=1.5;
    N=1000;
    x_vec=-A+[0:N]/N*2*A; y_vec=x_vec;

    for i=1:length(x_vec)
        for j=1:length(y_vec)
            x(i,j)=x_vec(i); y(i,j)=y_vec(j);
        end;
    end;

    z = x+sqrt(-1)*y;
    f = @(z) z.^2 + c;

    % Iterate 25 function calls
    for kk=1:25

        a=abs(z);
        a=min(a,1);
        a=1-a;
        a=(a>0); 
        a=a+1;
        b = rot90(a);
        subplot(111);
        image([-A,A],[-A,A],b);
        colormap([1 0 0; 1 1 1]);
        axis([-A,A,-A,A]); 
        axis('square');
        set(gca,'Fontsize',24);
        xlabel('x','Fontsize',20);
        ylabel('y','Fontsize',20);

        c_str=num2str(c);
        if c>=0
            title({['Julia set for f(z) = z^2+ ',c_str];['n = ', num2str(kk)]});
        else
            title({['Julia set for f(z) = z^2 ',c_str];['n = ', num2str(kk)]});
        end;

        drawnow 

        % Create .gif file
        F = getframe(gcf);
        im = frame2im(F);
        [Q,map] = rgb2ind(im,256);
        if kk == 1
            imwrite(Q,map,filename,'gif','LoopCount',Inf,'DelayTime',0.35);
        else
            imwrite(Q,map,filename,'gif','WriteMode','append','DelayTime',0.35);
        end

        z = f(z);
    end
end
