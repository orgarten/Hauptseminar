import wave
import matplotlib.pyplot as plt
import numpy as np
from scipy import signal
import time

print "This is a little program to test the speed of different ways to cross correllate two wave files."
print "Please put two mono recorded .wav files in the directory C:\Users\Lucas\PycharmProjects\KKF"
print "These two files will be crosscorrelated."

#first ver

#a function that converts the 16-Bit-wav file to a array
def convert16 (file):
    filestring = file.readframes(file.getnframes())
    filearray = np.fromstring(filestring, "Int16")
    filearray = filearray.astype(float)
    return filearray

def norm (file):
    file = file/np.amax(file)
    return file

def cut(eins,zwei,freq1, freq2):
    dataeins = convert16(eins)
    datazwei = convert16(zwei)
    frameperT1 = eins.getframerate()/freq1
    frameperT2 = zwei.getframerate()/freq2
    dataeins = dataeins[0:frameperT1/2+1]/np.amax(dataeins)
    datazwei = datazwei[0:frameperT2/2+1]/np.amax(datazwei)
    plt.plot(datazwei)
    plt.show()
    kkfint = signal.correlate(dataeins, datazwei, "full")
    return kkfint

"""sig1 = np.linspace(1,1,10)
sig2 = np.linspace(1,1,10)
corr = signal.correlate(sig1, sig2, "full")
print corr
plt.plot(corr, "r^")
plt.show()"""

"""def kkftrial (eins,zwei):
    k = 0
    if len(eins) != len(zwei):
        print "Both files have to be equal in the samplenumber."
    kkf = []
    while k <= (len(eins)+len(zwei)-1):
        n=0
        while n < len(eins):
            kkf2 = eins[n]+zwei[n+k]
            kkf.append(kkf2)
            n += 1
        k += 1
    return kkf"""

#This ist the function which correlates two files with normal sums
#kkf = perKKF(fileone, filetwo, 1000, 1000)
def normal():
    start_time = time.time()

    fileone = wave.open("C:\Users\Lucas\PycharmProjects\KKF\klirr.wav", "r")
    filetwo = wave.open("C:\Users\Lucas\PycharmProjects\KKF\klirr.wav", "r")

    dataone = convert16(fileone)
    datatwo = convert16(filetwo)

    fileone.close()
    filetwo.close()

    datatwo = norm(datatwo)
    dataone = norm(dataone)
    kkf = signal.correlate(dataone, datatwo, "full")

    maximum = np.amax(kkf)
    print maximum

    plt.plot(kkf)
    stop_time = time.time()
    deltaT = stop_time - start_time
    print "Die Rechenzeit betraegt %1.2f Sekunden" % deltaT
    plt.show()

def withFFT ():
    start_time = time.time()

    fileone = wave.open("C:\Users\Lucas\PycharmProjects\KKF\klirr.wav", "r")
    filetwo = wave.open("C:\Users\Lucas\PycharmProjects\KKF\klirr.wav", "r")

    dataone = convert16(fileone)
    datatwo = convert16(filetwo)

    fileone.close()
    filetwo.close()

    dataone = norm(dataone)
    datatwo = norm(datatwo)
    # frameperT1 = fileone.getframerate() / 1000
    # frameperT2 = filetwo.getframerate() / 1000
    # dataone = dataone[0:frameperT1 / 2 + 1] / np.amax(dataone)
    # plt.plot(dataone)
    # plt.show()
    # datatwo = datatwo[0:frameperT2 / 2 + 1] / np.amax(datatwo)
    one_trans = np.fft.fft(dataone)
    two_trans = np.conj(np.fft.fft(datatwo))

    n = 0
    kkf_trans = np.zeros(len(dataone), dtype=complex)

    while n < len(one_trans):
        number1 = one_trans[n]
        number2 = two_trans[n]
        # print number1*number2
        kkf_trans[n] = number1*number2
        n += 1


    kkf = np.fft.irfft(kkf_trans)
    maximum = np.amax(kkf)
    print maximum

    plt.plot(kkf, "r^")

    stop_time = time.time()
    deltaT = stop_time - start_time
    print "Die Rechenzeit betraegt: %f Sekunden" % deltaT

    plt.show()

def FFTtry():
    dataone = convert16(fileone)
    plt.plot(dataone)
    plt.show()
    trans = np.fft.fft(dataone)
    dataone = np.fft.fft(trans)
    plt.plot(dataone)
    plt.show()

# FFTtry()





normal()
withFFT()





"""dataone = convert16(fileone)
plt.plot(dataone)
plt.show()
one_trans = fft(dataone)
dataone = ifft(one_trans)
plt.plot(dataone)
plt.show()"""
