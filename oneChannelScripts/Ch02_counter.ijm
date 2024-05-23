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

//run("8-bit");
waitForUser("attempt to threshold");
run("Auto Local Threshold", "method=Bernsen radius=15 parameter_1=0 parameter_2=0 white")
// Huang2: 11 - id'ed 406 worms, missed large clumps (either one large object or ignored)
//Intermodes: bad
//IsoData: 16 102 good for close clumps, missed small worms with divided gut. This is about as good as we can get. 
//Li: 11
//run("Auto Threshold", "method=Huang2 white show");
//setThreshold(200, 65535, "raw");
//run("Analyze Particles...", "size=10000-100000 show=Masks display clear add");
run("Analyze Particles...", "size=5000-100000 show=Masks display clear add");
run("Select All");
roiManager("Measure");

waitForUser("check results, then hit 'ok'"
// Close all windows
close("all");

