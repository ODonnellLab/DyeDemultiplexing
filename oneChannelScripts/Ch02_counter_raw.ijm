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
pattern = ".*ch02.*"

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

waitForUser("attempt to threshold/n hight threshold (bright worms)");
setThreshold(511, 65535, "raw");
//run("Analyze Particles...", "size=5000-100000 circularity=0.00-0.20 show=Outlines display clear add composite");
run("Analyze Particles...", "size=5000-100000 circularity=0.00-0.20 show=Outlines display clear add composite");
run("Select All");
roiManager("Measure");
roiManager("Save", folder + File.separator + "Ch02_HighT_ROIset.zip");
roiManager("Delete");
/// need to save results and ROI here

selectImage("DiI_5-8-24 Merged_RAW_ch02.tif");
waitForUser("Low threshold worms (attempting to detecting fainter worms)");
setThreshold(160, 65535, "raw");
//run("Analyze Particles...", "size=5000-100000 show=Masks display clear add");
run("Analyze Particles...", "size=30000-100000 circularity=0.00-0.20 show=Outlines display clear add composite");
run("Select All");
roiManager("Measure");
roiManager("Save", folder + File.separator + "Ch02_LowT_ROIset.zip"); // swap in ch02 object to filename

waitForUser("check results, then hit 'ok'");
// Close all windows
close("all");

