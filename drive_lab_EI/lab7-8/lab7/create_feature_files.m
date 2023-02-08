function create_feature_files(images)

  n = numel(images);

  lbp = []; % Local binary pattern histograms
  
  glcm = []; % Gray-Level Co-Occurence Matrices
  
  ghist = []; % Gray-level histograms
  
  for j = 1 : n
    disp(['Compute features for image ' images{j}]);
    im = imread(images{j});

    lbp = [lbp; compute_lbp(im)];
    glcm = [glcm; compute_glcm(im)];
    ghist = [ghist; compute_ghist(im)];
   
  end

  save('lbp','lbp');
  save('glcm','glcm');
  save('ghist','ghist');
  
end