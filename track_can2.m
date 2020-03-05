function placement = track_can2(vidFrames)
    size_camera = size(vidFrames);
    placement = [0,0];
    for i = 1:size_camera(4)
        img = vidFrames(140:440, 70:417,:,i); % for test 4
        %img = vidFrames(90:420, 120:510,:, i);% for test 2
        %img = vidFrames(140:415, 180:490, :, i); %for test 3 
        %img = vidFrames(190:450, 60:420,:,i); % for test 1 
        
         
        sumed_img = rgb2gray(img);
        idx = find(sumed_img(:) > 240); % return anything that is above the 250 value 
        [row, col] = ind2sub(size(sumed_img),idx);
        row = mean(row(:));
        col = mean(col(:));
        % remember to change the constant value according to the test 
        placement = [placement; 140 + row, 70 + col];  
    end
    %placement = placement(2:end, :); 
    save camera2_1.dat placement -ascii;
end 
