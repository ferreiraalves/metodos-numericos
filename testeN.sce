function[Y] = f(x)
    Y=x^4 + 2x3 13x2 14x + 24
endfunction

function[Y] = Df(X)
    
endfunction

function[Raiz, Iter, CondErro] = newton(x0, Toler, IterMax)
    Iter=0;
    [Fx] = f(x0); 
    [DFx] = Df(x0);
    
    printf("Iter\tx\tDFx\tFx\n");
    printf("%f\t%f\t%f\t",Iter, x0, DFx, Fx);
    for i = 1:1:IterMax
        DeltaX = -Fx/DFx;
        x=x+DeltaX;
        [Fx] = f(x); 
        [DFx] = Df(x);
        Iter=Iter+1;
        printf("%f\t%f\t%f\t%f",Iter, x, DFx, Fx, DeltaX);
        if (abs(DeltaX) <= Toler & abs(Fx) <= Toler) | DFx == 0 then
            break
        end
    end
    Raiz=x;
    if abs(DeltaX) <= Toler & abs(Fx) <= Toler then
        CondErro = 0;
    else
        CondErro = 1;
    end 
endfunction