# -*- coding: utf-8 -*-
#!/usr/bin/env python

import scipy.io.wavfile as wav
import matplotlib.pyplot as plt
from scipy import signal
import numpy as np
from os import listdir
import os

middle = 1

def correlate(dataA, dataB):
    corr = signal.correlate(dataA, dataB, mode='full')  # the actual (cross-)correlation function     
    maximum = max(corr) + 0.0 # get maximum and convert to float
    corr = corr/maximum
    return corr
    
def stereo(path, blockSize):
    (rate, data) = wav.read(path, mmap=False)   # import stereo WAV file
    if len(data) > blockSize:
            middle = len(data)/2    # get middle of samples
            blockStart = middle - blockSize/2     # find starting point of block
            blockStop = middle + blockSize/2      # find stop point of block
            data = data[blockStart:blockStop]   # cut whole data to block
#    wav.write("used_block.wav", rate, data)     # write used block to new wav file
    (dataA, dataB) = np.hsplit(data,2)      # split the 2 stereo channels
    dataA = dataA.tolist()  # convert numpy array format to standard list format
    dataB = dataB.tolist()  # for signal.correlate()
                            # don't ask why, it's just fresh, fruity, stupid, fruity
    return(dataA, dataB)   # return sample data of both channels
    
def main():
    a = os.getcwd() + "/WAVE/"  # saves path of wav files to 'a'
    dirlist = listdir(a) # creates list of files in wav directory
    try:
        blockSize = input("Specify block size in samples[ca. 100...20000] or blank for 2500:")
    except SyntaxError: # blank input results in standard block size
        blockSize = 2500 # standard block size
    while len(dirlist) > 0:
        b = dirlist.pop(0)
        print(b)        
        filepath = a + b
        #filepath = stereoDir()
        #print filepath
        (dataA, dataB) = stereo(filepath, blockSize)
        corr = correlate(dataA, dataB)
        plt.plot(corr)
    
    plt.show()
    
main()