function[VetX, VetY , Erro] = ABM4(a, b, m, y0)
    h=(b-a)/m;
    [VetX, VetY , Erro] = DOPRI(a, a + 3 * h, 3, y0);
    for i=1:4
        printf("%d\t%f\t%f\t%f", i-1, VetX(i), VetY (i), Erro(i));
    end
    for i=4:m;
        x = VetX(i - 3); y = VetY (i - 3); f0 = f(x, y);
        x = VetX(i - 2); y = VetY (i - 2); f1 = f(x, y);
        x = VetX(i - 1); y = VetY (i - 1); f2 = f(x, y);
        x = VetX(i); y = VetY (i); f3 = f(x, y) ;
        Ypre = h * (55 * f3 - 59 * f2 + 37 * f1 - 9 * f0)/24 + VetY (i);
        VetY (i + 1) = Ypre; VetX(i + 1) = a + i * h; x = VetX(i + 1);
        for j=1:2
            y = VetY (i + 1); f4 = f(x, y);
            Ycor = h * (9 * f4 + 19 * f3 − 5 * f2 + f1)/24 + VetY (i); VetY(i + 1) = Ycor;
        end
        Erro = abs(Ycor - Ypre) * (19/270);
        printf("%d\t%f\t%f\t%f", i, VetX(i+1), VetY (i+1), Erro);
    end
endfunction
