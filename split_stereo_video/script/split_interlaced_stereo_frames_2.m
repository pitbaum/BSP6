function split_interlaced_stereo_frames_2(dirname)
% Input  - path to directory containing pgmyuv files extracted
%          from a stereo video using mplayer.
%
% Output - left and right frames in the respective 'left' and
%          'right' directories in the given input directory.
%
% Author - Olaf Ronneberger
%          http://lmb.informatik.uni-freiburg.de/people/ronneber/
%

cd(dirname);    
d = dir('*.pgmyuv');
mkdir left
mkdir right

for fi=1:length(d)
  filename = d(fi).name;
  disp(['processing ' filename]);
  
  %a = gpuArray(im2single(imread( filename)));
  a = im2single(imread( filename));
  %
  % crop channels from the image
  %
  Y = a( 1:1080, 1:1920);
  U = a( 1081:end, 1:960);
  V = a( 1081:end, 961:end);
  
  %
  % deinterlacing
  %
  Y1 = Y(1:2:end, :);
  Y2 = Y(2:2:end, :);
  
  U1 = U(1:2:end, :);
  U2 = U(2:2:end, :);
  
  V1 = V(1:2:end, :);
  V2 = V(2:2:end, :);
  
  %
  %  left,  right splitting
  %
  Y1left  = Y1(:,1:960);
  Y1right = Y1(:,961:end);
  
  Y2left  = Y2(:,1:960);
  Y2right = Y2(:,961:end);
  
  U1left  = U1(:,1:480);
  U1right = U1(:,481:end);
  
  U2left  = U2(:,1:480);
  U2right = U2(:,481:end);
  
  V1left  = V1(:,1:480);
  V1right = V1(:,481:end);
  
  V2left  = V2(:,1:480);
  V2right = V2(:,481:end);
  
  %
  %  combine to RGB
  %
  rgb_1_left = ycbcr2rgb( double(cat(3, Y1left, ...
							  imresize( U1left, 2), ...
							  imresize( V1left, 2))));
  
  rgb_2_left = ycbcr2rgb( double(cat(3, Y2left, ...
							  imresize( U2left, 2), ...
							  imresize( V2left, 2))));
  
  rgb_1_right = ycbcr2rgb( double(cat(3, Y1right, ...
							   imresize( U1right, 2), ...
							   imresize( V1right, 2))));
  
  rgb_2_right = ycbcr2rgb( double(cat(3, Y2right, ...
							   imresize( U2right, 2), ...
							   imresize( V2right, 2))));
  
  %
  %  save to invidual files
  %
  filestub = filename(1:end-7);
  
  imwrite( rgb_1_left, ['left/' filestub '_A.ppm']);
  imwrite( rgb_2_left, ['left/' filestub '_B.ppm']);
  imwrite( rgb_1_right, ['right/' filestub '_A.ppm']);
  imwrite( rgb_2_right, ['right/' filestub '_B.ppm']);

end %imglist
cd ..
