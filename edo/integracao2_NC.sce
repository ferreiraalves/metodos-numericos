function[R] = f(x,y)
    R=sin((x^2)+(y^2));
endfunction

//function [y1, ..., yn]=foo(x1, ...,xm)
function[Integral, CondErro] = NewtonCotes2(ax, bx, nx, mx, ay, by, ny, my)
    d(1) = 2; d(2) = 6; d(3) = 8; d(4) = 90; d(5) = 288; d(6) = 840
    d(7) = 17280; d(8) = 28350
    c(1) = 1; c(2) = 1; c(3) = 4; c(4) = 1; c(5) = 3; c(6) = 7; c(7) = 32;
    c(8) = 12; c(9) = 19; c(10) = 75; c(11) = 50; c(12) = 41; c(13) = 216;
    c(14) = 27; c(15) = 272; c(16) = 751; c(17) = 3577; c(18) = 1323;
    c(19) = 2989; c(20) = 989; c(21) = 5888; c(22) = -928; c(23) = 10496;
    c(24) = -4540;
    CondErro = 0; Integral = 0;
    if nx < 1||nx > 8 then
        CondErro=CondErro+1;
    elseif modulo(mx,nx)<>0||modulo(my,ny)<>0
        CondErro=CondErro+2;
    end
    if CondErro<>0 then
        abort
//        disp("ERRO");
    else
        px = floor(0.25 * (nx * (nx + 2) + modulo(nx, 2)));
        py = floor(0.25 * (ny * (ny + 2) + modulo(ny, 2)));
        hx = (bx - ax)/mx; 
        hy = (by - ay)/my;
        mprintf("i\t\tx(i)\t\tc(i)\t\tj\t\ty(j)\t\tc(j)\t\tf(x(i),y(j))\n\n");
        for i=0:mx
            x = ax + i * hx; jx = px + floor(0.5 * nx - abs(modulo(i, nx) - 0.5 * nx));
            kx = 1 + floor((nx - modulo(i, nx))/nx) - floor((mx - modulo(i, mx))/mx);
            for j=0:my
                y = ay + j * hy; jy = py + floor(0.5 * ny - abs(modulo(j, ny) - 0.5 * ny));
                ky = 1 + floor((ny - modulo(j, ny))/ny) - floor((my - modulo(j, my))/my);
                fxy = f(x, y);
                Integral = Integral + fxy * c(jx) * kx * c(jy) * ky;
                if j==0 then
                    mprintf("%f\t%f\t%f\t%f\t%f\t%f\t%f\n",i, x, c(jx) * kx, j, y, c(jy) * ky, fxy);
                    //disp(i, x, c(jx) * kx, j, y, c(jy) * ky, fxy);
                else
                    mprintf("\t\t\t\t\t\t%f\t%f\t%f\t%f\n",j, y, c(jy) * ky, fxy);
                    //disp(j, y, c(jy) * ky, fxy);
                end
            end
        end
        Integral = nx * ny * hx * hy/(d(nx) * d(ny)) * Integral;
        //disp(Integral);
        mprintf("\nIntegral=%f",Integral);
        //disp(CondErro);
        mprintf("\nCondErro=%d\n\n\n",CondErro);
    end
endfunction
