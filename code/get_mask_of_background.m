function mask_of_background = get_mask_of_background(video)

    % Number of frames to sample
    numSampleFrames = 10;

    % Select frames
    n_avoid_frames = 100; % I really don't know why 100 works for 1st video while 1 works for 2nd video.
    frameNumbers = round(linspace(n_avoid_frames, video.NumFrames-(n_avoid_frames-1), numSampleFrames));

    % Initialize mask
    mask_of_background = true(video.Height, video.Width);

    for f = 1 : length(frameNumbers)

        % Set current time of video object
        video.CurrentTime = (frameNumbers(f)-1) / video.FrameRate;

        % Read frame
        frame = readFrame(video);

        % Pre-process
        grayFrame = rgb2gray(frame);
        sensitivity_threshold_for_background = 0.4; % higher, more 1 pixels
        binaryFrame = imbinarize(grayFrame, 'adaptive', 'Sensitivity', sensitivity_threshold_for_background);

        % Merge this frame's binary image with the overall mask
        mask_of_background = mask_of_background & binaryFrame;

    end

end
