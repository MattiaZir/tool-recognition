% COMPAREMASKSV2 function
% gli passo 2 maschere e lui conta le differenze tra le due.
function out_f = compareMasksV2(mask1 , mask2)

    if nargin < 2
        error("too few arguments")
    end

    count = 0;
    [row cols] = size(mask1);
    for i = 1:row
        for j = 1:cols
            if mask1(i, j) ~= mask2(i, j)
                count = count +1;
            end
        end
    end
    out_f = count;
end