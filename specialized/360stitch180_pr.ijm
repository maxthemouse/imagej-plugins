//Macro to stitch 360 degree scan results into 180 degree scan projections used for PITRE or XTRACT.
macro "360stitch180PR, ver1.0" {

rawdatadir=getDirectory("Choose Raw Data Directory"); 
darkpath=rawdatadir+"\\Dark";
flatpath=rawdatadir+"\\Flat";
tomopath=rawdatadir+"\\Tomo";
savepath=rawdatadir+"\\Combination";
File.makeDirectory(savepath);

//Stitch Dark images
run("Image Sequence...", "open=darkpath");
makeRectangle(724, 0, 3275, 880);
run("Crop");
rename("1");
run("Duplicate...", "title=2 duplicate");
run("Flip Horizontally", "stack");
run("Combine...", "stack1=2 stack2=1");
//save the result
run("Image Sequence... ", "format=TIFF name=dark_ save=[savepath]");
close();

//Stitch Flat images
run("Image Sequence...", "open=flatpath");
makeRectangle(724, 0, 3275, 880);
run("Crop");
rename("1");
run("Duplicate...", "title=2 duplicate");
run("Flip Horizontally", "stack");
run("Combine...", "stack1=2 stack2=1");
//save the result
run("Image Sequence... ", "format=TIFF name=flat_ save=[savepath]");
close();

//Stitch Tomo images
run("Image Sequence...", "open=tomopath number=3000 sort");
makeRectangle(724, 0, 3275, 880);
run("Crop");
rename("1");
run("Image Sequence...", "open=tomopath number=3000 starting=3001 sort");
makeRectangle(724, 0, 3275, 880);
run("Crop");
run("Flip Horizontally", "stack");
rename("2");
run("Combine...", "stack1=2 stack2=1");
//save the result
run("Image Sequence... ", "format=TIFF name=tomo_ save=[savepath]");
close();
