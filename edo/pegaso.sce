
function[result] = f(x)
    //inserir a formula aqui yo
    result= 3*x^2 + sqrt(x+1) * cos(x)^3 -2;
endfunction

function[Raiz, Iter, Erro] = pegaso(a,b,Toler,IterMax)
    x=a; [Fa]= f(x); 
    x=b; [Fb] = f(x);
    printf('iter\ta\tb\tx\tFx\tdelta_x\n');
    k = 0; x=b; Fx=Fb;
    while 1
        k = k+1; DeltaX = -Fx/(Fb-Fa) * (b - a);
        x = x + DeltaX; Fx = f(x);
        printf('%f\t',k);
        printf('%f\t',a);
        printf('%f\t',b);
        printf('%f\t',x);
        printf('%f\t',Fx);
        printf('%f\n',DeltaX);
        if ((abs(DeltaX)< Toler & abs(Fx) < Toler)| k>= IterMax)
            break
        end
        if Fx * Fb < 0 a = b; Fa = Fb; else Fa = Fa * Fb / (Fb + Fx); end
        b = x; Fb = Fx;
    end
    Raiz = x;
    Iter = k;
    Erro = abs(DeltaX) >= Toler | abs(Fx)>= Toler;
    disp(Erro)
endfunction
