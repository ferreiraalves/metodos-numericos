function[A, T, CondErro] = PesAbsGL(n)
    CondErro=0;
    pi=3.14159265358979323846;
    m=floor(0.5*(n+1));
    if n<1 then
        CondErro=1;
    else
        for i=1:m
            z=cos(pi*(i-0.25)/(n+0.5));
            while 1==1
                p1=1;
                p2=0;
                for j=1:n
                    p3=p2;
                    p2=p1;
                    p1=((2 * j - 1) * z * p2 - (j - 1) * p3)/j;
                end
                pp = n * (z * p1 - p2)/((z^2) - 1);
                z1 = z;
                z=z1-(p1/pp);
                if abs(z-z1)<(10^(-15)) then
                    break;
                end
            end
            T(m + 1 - i) = z;
            A(m + 1 - i) = 2/((1 - z^2) * pp^2);
        end
    end
//    disp(A);
//    disp(T);
endfunction


function[R] = f(x,y)
    R=sqrt(x^2+y)*cos(x*y);
endfunction


function[Integral, CondErro] = GaussLegendre2( ax, bx, nx, ay, by, ny)
    CondErro = 0; Integral = 0;
    [Avet, Tvet, CondErro] = PesAbsGL(nx);
    if CondErro <> 0 then
        abort
    end
    if nx==ny then
        for j=1:floor(0.5*(n+1))
            Bvet(j) = Avet(j); 
            Uvet(j) = Tvet(j);
        end
    else
        [Bvet, Uvet, CondErro] = PesAbsGL(ny);
    end
    ex1 = (bx - ax)/2;
    ex2 = (ax + bx)/2;
    ey1 = (by - ay)/2;
    ey2 = (ay + by)/2;
    if modulo(nx,2)==0 then
        cx1=1;
        cx2=0.5;
    else
        cx1=0;
        cx2=1;
    end
    if modulo(ny,2)==0 then
        cy1=1;
        cy2=0.5;
    else
        cy1=0;
        cy2=1;
    end
    mprintf("i\t\tt(i)\t\tx(i)\t\tA(i)\t\tj\t\tu(j)\t\ty(j)\t\tB(j)\t\tf(x(i),y(j))\n");
    for i=1:nx
        kx = floor(i - 0.5 * (nx + 1) + sign(i - 0.5 * (nx + cx1)) * cx2);
        tx = sign(kx) * Tvet(abs(kx)); 
        Axx = Avet(abs(kx));
        x = ex1 * tx + ex2;
        Soma = 0;
        for j=1:ny
            ky = floor(j - 0.5 * (ny + 1) + sign(j - 0.5 * (ny + cy1)) * cy2);
            ty = sign(ky) * Uvet(abs(ky));
            Ayy = Bvet(abs(ky));
            y = ey1 * ty + ey2;
            fxy = f(x, y);
            Soma = Soma + Ayy * fxy;
            if j==1 then
                mprintf("%f\t%f\t%f\t%f\t%f\t%f\t%f\t%f\t%f\n",i,tx, x, Axx, j,ty, y, Ayy, fxy);
            else
                mprintf("\t\t\t\t\t\t\t\t%f\t%f\t%f\t%f\t%f\n",j,ty, y, Ayy, fxy);
            end
        end
        Integral = Integral + Axx * Soma;
    end
    Integral = ex1 * ey1 * Integral;
endfunction
