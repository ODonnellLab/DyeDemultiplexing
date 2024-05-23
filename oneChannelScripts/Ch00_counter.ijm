// Brightfield worm identifier

// find Ch02 files in the selected folder
// current working directory is the folder containing this script, 
// which is "~[path to git repo]/DyeDemultiplexing/oneChannelScripts/"

// Define the folder path
currentDir = File.directory;
// workaround for folder, rather than file selection:
filepath = File.openDialog("Choose a file");
folder = File.getParent(filepath);

// Get the list of files in the folder
list = getFileList(folder);
print("searching for files within " + folder)
channel = "ch00"
pattern = ".*ch00.*"

// Iterate over each element of the original array
for (i = 0; i < list.length; i++) {
    // Check if the element matches the pattern
    if (matches(list[i], pattern)) {
        // Add the matching element to the filtered array
        filteredArray = Array.concat(filteredArray, list[i]);
    }
}

// Print the filtered array
print("File list to analyze:");
for (i = 1; i < filteredArray.length; i++) {
    print(filteredArray[i]);
}

// start without a loop, then loop through multiple ch02 images
// Loop over each image path in the array
//for (i = 0; i < imagePaths.length; i++) {
//    // Get the image path
//    imagePath = imagePaths[i];
//    
//    // Open the image using the FileOpener
//    FileOpener.open(imagePath);
//    
//    // Add your image processing code here
//    // For example:
//    run("Invert");
//    run("Enhance Contrast", "saturated=0.35");
//    
//    // Close the current image
//    close();
//}
print("Opening file " + filteredArray[1]);
open(filteredArray[1]);
run("8-bit")
waitForUser("run threshold");
run("Subtract Background...", "rolling=25 light");
run("Auto Local Threshold", "method=Contrast radius=12 parameter_1=0 parameter_2=0");
run("Analyze Particles...", "size=5000-100000 circularity=0.00-0.2 show=Outlines display clear add composite");

roiManager("Save", folder + File.separator + "ROIset.zip");


// now open ch01
newchannel = "ch01"
ch01file = replace(filteredArray[1], channel, newchannel)

open(ch01file);
run("8-bit");

// Step 1: Open ROI Manager
run("ROI Manager...");

// Step 2: Get the number of ROIs
nROIs = roiManager("count");

// Step 3: Loop through each ROI and measure it
for (i = 0; i < nROIs; i++) {
    // Select ROI by index
    roiManager("select", i);
    // Measure the selected ROI
    roiManager("Measure");
}


// now open ch01
newchannel = "ch02"
ch02file = replace(filteredArray[1], channel, newchannel)

open(ch02file);
run("8-bit");

// Step 1: Open ROI Manager
run("ROI Manager...");

// Step 2: Get the number of ROIs
nROIs = roiManager("count");

// Step 3: Loop through each ROI and measure it
for (i = 0; i < nROIs; i++) {
    // Select ROI by index
    roiManager("select", i);
    // Measure the selected ROI
    roiManager("Measure");
}



