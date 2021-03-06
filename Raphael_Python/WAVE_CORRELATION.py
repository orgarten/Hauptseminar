# -*- coding: utf-8 -*-
#!/usr/bin/env python
"""
Created on Sun May  1 17:28:41 2016

@author: Raphael Hildebrand
Correlates stereo WAV-Files using scipy
Plots results using pyplotlib

TODO
    - export data as plot, text, ...
"""

import scipy.io.wavfile as wav
import matplotlib.pyplot as plt
from scipy import signal
import scipy.integrate as integrate
from os import listdir
import os
import numpy as np
import time

print("Correlation of stereo WAV-Files \n\n"

"   |\      _,,,---,,_\n"                       # Meow
"   /,`.-'`'    -.  ;-;;,_\n"
"  |,4-  ) )-,_..;\ (  `'-'\n"
" '---''(_/--'  `-'\_) \n\n"

"created by O. Garten, R. Hildebrand, F. Roth, L. Weber\n\n"

"")

#def correlate(dataA, dataB):
#
#    corr = signal.correlate(dataA, dataB, mode='full')  # calculate correlation function in time domain
#    maximum = max(corr) + 0.0 # get maximum and convert to float
#    corr = corr/maximum     # normalize the correlated data
#    return corr     # return result

def correlate_fft(dataA, dataB):
    starttime = time.time()
    corr = signal.fftconvolve(dataA, dataB[::-1], mode='full') # calculate correlation function in frequency domain
    maximum = max(corr) + 0.0 # get maximum and convert to float
    corr = corr/maximum     # normalize the correlated data
    stoptime = time.time()  # time measurement
    print("Runtime: ", (stoptime-starttime))
    interpret(corr) # interpret correlation result
    return corr     # return result

def stereo(path, blockSize, workingdir):

    (rate, data) = wav.read(path, mmap=False)   # import stereo WAV file
    if len(data) > blockSize:
            middle = len(data)/2                 # get middle of samples
            blockStart = middle - blockSize/2     # find starting point of block
            blockStop = middle + blockSize/2      # find stop point of block
            data = data[blockStart:blockStop]       # cut whole data to block
    saveFile = path.replace(workingdir, workingdir + "/BLOCKS/")    # path for used blocks
    print(saveFile)
    wav.write(saveFile, rate, data)              # write used block to new wav file
    (dataA, dataB) = np.hsplit(data,2)        # split the 2 stereo channels
    dataA = dataA.tolist()           # convert numpy array format to standard list format
    dataB = dataB.tolist()           # for signal.correlate()
                                    # don't ask why, it's just fresh, fruity, stupid, fruity
    return(dataA, dataB)         # return sample data of both channels

def interpret(corr):

    maximum = max(corr)     # get correlation maximum
    corrLength = len(corr)  # get correlation length
    middle = corrLength/2   # get middle of correlation
    maxRegionStart = middle - corrLength*0.005   # get start point of integration region
    maxRegionStop = middle + corrLength*0.005    # get stop point of integration region
    maxRegion = corr[maxRegionStart:maxRegionStop]    # create list of integration region
    integrated = sum(abs(maxRegion))    # integrate (simply add) the absolute values of the integration region
    maxResult = maximum*len(maxRegion)     # calculate the max. possible result
    print("peaky:", 1-integrated/maxResult)
    print("maximum:", maximum)

def main():

    # ask for wanted sample block size
    blockSize = input("Specify block size [<100k for fast calculation] or press ENTER to use standard block size:")
    if blockSize:
        blockSize = int(blockSize) # convert given block size from string to int
    #if blockszie is empty or exceeds limits
    if not blockSize or blockSize < 0:
        blockSize = 8192
        print("Blocksize set to 8192")

    print("[S] - Use single file with specified path\n"
    "[ENTER] - use stereo files at /PATH/TO/THIS/SCRIPT/WAVE/\n")

    userinput = input("[S]/[ENTER]:")
    userinput = str.lower(userinput)
    if userinput == "s":
        print("S pressed")
        wd = os.getcwd() + "/WAVE/"
        specificFile = input("Specify path to file: ") # user input of specific filepath
        print(specificFile)
        (dataA, dataB) = stereo(specificFile, blockSize, wd)         # get data of wav file
#        corr = correlate(dataA, dataB)           # get correlation output of wav data using correlation in time domain
        corr = correlate_fft(dataA, dataB)      # get correlation output of wav data using correlation in frequency domain
        plt.plot(corr)                   # plot correlation output

    else:
        print("\nProcessing files: \n")
        wd = os.getcwd() + "/WAVE/"       # saves path of wav files to 'wd' (workingdirectory/WAVE/)
        print(wd)
        dirlist = [f for f in os.listdir(wd) if os.path.isfile(os.path.join(wd, f))]    # creates list of files in wav directory
        while len(dirlist) > 0:
            element = dirlist.pop(0)         # returns and deletes first element of dirlist

            #print(element)

            filepath = wd + element           # get full path of file
            (dataA, dataB) = stereo(filepath, blockSize, wd)        # get data of wav file
   #         corr = correlate(dataA, dataB)              # get correlation output of wav data using correlation in time domain
            corr = correlate_fft(dataA, dataB)      # get correlation output of wav data using correlation in frequency domain
            plt.plot(corr)           # plot correlation output

    print("Finished!\n")

    plt. show()             # show plot


    print("\n     >=< \n"      #hippo!
    ",.--'  ''-.\n"
    "(  )  ',_.'\n"
    "Xx'xX \n")

if __name__ == "__main__":
    main()
