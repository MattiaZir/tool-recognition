function out = compute_local_descriptors(image, tsize, tstep, compute_funct)
%tasselli quadrati di dim tsize x tsize
%tstep è utile se voglio tasselli parzialmente sovrapposti
  [rows,cols,ch] = size(image);%anche su più canali se il callback lo supporta
  
  half = floor(tsize/2);
  
  tmp = padarray(image,[half,half],'symmetric');
 
  descriptors = [];

  nt_cols = 0;
  
  for c = half : tstep : cols+half-1
    nt_cols = nt_cols+1;
    nt_rows = 0;
    
    for r = half : tstep: rows+half-1
      nt_rows = nt_rows+1;
      
      %fprintf('(%d, %d)\n',r,c);

      tassello = tmp(r-half+1:r+half+1, c-half+1:c+half+1,:);
    
      res = compute_funct(tassello);
      
      descriptors = [descriptors;res];
      
    end
    
  end

  out.descriptors = descriptors;
  out.nt_rows = nt_rows;
  out.nt_cols = nt_cols;
  
end