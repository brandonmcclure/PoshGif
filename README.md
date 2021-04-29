# PoshGif
A powershell module for generating gifs from a directory of images

I wrote this to help out my son make a short stop motion video. There are some dependencies on Write-Log from [FC_Log](https://github.com/brandonmcclure/friendly-chainsaw) right now. The script will run without it, but you will not get any log information. 

# To Use

Take a bunch of images (.jpg right now) and put them in a folder. We named them 001,002... then run `Invoke-Giffer -Path C:\Path\To\Photos`. IT will produce a looping gif in the same directory as the source images. 

I do not know how to add a pause directly into the gif encoder, so we just duplicate the frames we add (ie each image is actually 7 frames of the end gif) and duplicate the image files themselves where we want to change the pacing of individual frames in the animation. 

This uses some code from [Reddit](https://www.reddit.com/r/PowerShell/comments/jhq5w9/creating_a_looping_animated_gif/) to inject the proper bytes into the gif to allow it to loop at the end