function runAndDispay(args) 
    n = numel(args.pics);
    nf = numel(args.f);
    na = numel(args.a);
    'runAndDispay'

    
    last=1;
    c={};
    for i = 1 : na
        
        if args.a{i} ~= '|'     
            'okif'
            c={c{:}, args.a{i}};
        else
            'okelse'
            culo(last)=c;
            c={};
            last=last+1;
        end
    end 
    culo(last)=c;%sennò mi perdo il last

    for i = 1 : nf
        x=culo(i);
        figure, imshow(imbinarize(args.pics{i}, args.f{i}(x{:})));

    end
end