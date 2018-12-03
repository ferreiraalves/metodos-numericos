
function[result] = f(x,y)
    //inserir a formula aqui yo
    result= x - 2*y + 1
endfunction


//a = limite inferior
//b = limite superior
//m = numero de subintervalos
//y = valor inicial
function[VetX, VetY] = euler(a,b,m,y0)
    h = (b-a)/m; x = a; y = y0;    
    Fxy = f(x,y);
    VetX(1) = x; VetY(1) = y;
    for (i=1:m)
        x = a + i * h;
        y = y + h * Fxy;
        Fxy = f(x,y);
        printf('i = %f\t',i);
        printf('x = %f\t',x);
        printf('y = %f\t',y);
        printf('Fxy = %f\n',Fxy);
        VetX(i+1) = x; VetY(i+1) = y; 
    end    
endfunction
