
%TODO: Renderla più generale
function out =  creaTabellaDaRegionProps(saved_stats)
T = struct;
counter = 1;

for k = 1:length(saved_stats)
    curr = saved_stats(k);

    for lab = 1:length(curr.props)
        tmp = curr.props(lab);
        %T(counter).object = curr.label;
        T(counter).EulerNumber = tmp.EulerNumber;
        T(counter).BBox_ratio = tmp.BoundingBox(1,3) / tmp.BoundingBox(1,4);
        T(counter).APSquared = tmp.Area/(tmp.Perimeter^2);
        T(counter).Rectangularity = (tmp.BoundingBox(1,3)*tmp.BoundingBox(1,4))/tmp.Area;
        T(counter).Eccentricity = tmp.Eccentricity;
        T(counter).Circularity = tmp.Circularity;
        T(counter).Solidity = tmp.Solidity;
        T(counter).humoments = curr.moments;

%         T(counter).m1 = curr.moments(1);
%         T(counter).m2 = curr.moments(2);
%         T(counter).m3 = curr.moments(3);
%         T(counter).m4 = curr.moments(4);
%         T(counter).m5 = curr.moments(5);
%         T(counter).m6 = curr.moments(6);
%         T(counter).m7 = curr.moments(7);

        counter = counter + 1;
    end
end

out = struct2table(T);
end