function placement = track_can1(vidFrames)
    size_camera = size(vidFrames);
    placement = [0,0];
    for i = 1:size_camera(4)
        img = vidFrames(200:450, 50:500,:,i); % for test1,2,3, 4
        sumed_img = rgb2gray(img);
        idx = find(sumed_img(:) > 240); % return anything that is above the 250 value 
        [row, col] = ind2sub(size(sumed_img),idx);
        row = mean(row(:));
        col = mean(col(:));
        placement = [placement; 200 + row, 50 + col];
    end
    save camera1_1.dat placement -ascii;
end 
