
function[result] = f(x,y)
    //inserir a formula aqui yo
    result= x - 2*y + 1
endfunction


//a = limite inferior
//b = limite superior
//m = numero de subintervalos
//y = valor inicial
function[VetX, VetY, Erro] = adam(a,b,m,y0)
    h = (b-a)/m; xt = a; yt = y0;    
    VetX(1) = xt; VetY(1) = yt;
    printf('i\tx\t\t\y\n');
    printf('%d\t',0);
    printf('%f\t',xt);
    printf('%f\n',yt);
    for i=1:m
        x = xt; y = yt; k1 = f(x,y);
        x = xt + h/2; y = yt + h/2*k1; k2 = f(x,y);
        y = yt + h/2 * k2; k3 = f(x,y);
        x = xt + h; y = yt + h * k3; k4 = f(x,y);
        xt = a + i * h; yt = yt + h/6 * (k1+2*(k2+k3) + k4);
        printf('%d\t',i);
        printf('%f\t',xt);
        printf('%f\n',yt);
        VetX(i+1) = xt; VetY(i+1) = yt;
    end
endfunction
