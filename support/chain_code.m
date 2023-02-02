function out = chain_code(boundary)
    ccode = "";
    for i = 2:size(boundary,1) % parti dal secondo, il primo equivale allo starting point
        prev = [boundary(i - 1,1), boundary(i - 1,2)];
        curr = [boundary(i,1), boundary(i,2)];
        diff = -(prev - curr);

        ccode = ccode + get_coord8(diff(1,1), diff(1,2));
        
    end
    
    out = ccode;
end


function c = get_coord8(y, x) % è row-column l'ordine di MATLAB (almeno, sembra)
    if x == -1
        if y == -1
            c = 5;
        elseif y == 0
            c = 4;
        elseif y == 1
            c = 3;
        end
    elseif x == 1
        if y == -1
            c = 7;
        elseif y == 0
            c = 0;
        elseif y == 1
            c = 1;
        end
    elseif x == 0
        if y == 1
            c = 2;
        elseif y == -1
            c = 6;
        end
    else
        c = -1;
    end
end
