fileName = 'vs.MP4';
obj = VideoReader(fileName);
frame_no = 1;
mkdir('frame3');
while hasFrame(obj) && frame_no < 300
  this_frame = readFrame(obj);
  frame_name = strcat(num2str(frame_no), '.jpg');
  frame_name = strcat('frame3/', frame_name);
  imwrite(this_frame, frame_name);
  frame_no = frame_no+1;
end