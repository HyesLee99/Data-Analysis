function placement = track_can3(vidFrames)
    size_camera = size(vidFrames);
    placement = [0,0];
    for i = 1:size_camera(4)
        img = vidFrames(130:330,220:570,:,i); % for test 4 
        %img = vidFrames(160:460, 240:620, :, i); %for test 2 / for test 3
        %img = vidFrames(10:480,190:430,:,i); % for test 1 
        
        sumed_img = rgb2gray(img);
        idx = find(sumed_img(:) > 230); 
        % test 1, 2, 3, 240 
        % return anything that is above the 250 value 
        [row, col] = ind2sub(size(sumed_img),idx);
        row = mean(row(:));
        col = mean(col(:));
        placement = [placement; 130 + row, 220 + col];
    end
    %placement = placement(2:end, :); 
    save camera3_1.dat placement -ascii;
end 
