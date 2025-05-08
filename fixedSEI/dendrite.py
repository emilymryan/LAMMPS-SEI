# Calculate the mass deposited on Anode Surface
# 30 Jun 2022
# Madison Morey
import numpy as np
import pandas as pd

job = 'SEI_Case1_26Feb25_50nm_RC5.0e-4_5.0e-6_0.46_2856176'
fname = '/projectnb/ryanlab/mmorey/LAMMPS_BATTERY_SEI/Case1/newresults/combocase/' + job

Nfreq = 2880
totDump = 151
dumpT = 0.1 
time = 0
totAtoms = 360000
length = np.zeros((totAtoms,1),dtype=float)
Lay = 0.06
Lmax = 0.0
solid = 0
Ltemp = 0
Lx = 5.0

def my_range(start, end, step):
    while start <= end:
        yield start
        start += step

##Create array to hold mass and time mass 
##Mass is in index 6 of dump file
##Assumes fluid mass is 0

data = np.zeros((totDump,4),dtype=float)

#loop through totDumps that start at 0

for i in range(0,totDump):
    data[i,0] = round(time,3)
    time = time + dumpT
    num = i*Nfreq
    fid = fname + "/dump." + str(num) + ".dat"
    PartType = np.loadtxt(fid, skiprows=9, usecols=1)
    y = np.loadtxt(fid, skiprows=9, usecols=3)
    for j in range(0,totAtoms):
        if int(PartType[j]) == int(2):
            Ltemp = y[j]
            length[j] = y[j]
            solid = 1 + solid
            if (Ltemp > Lmax):
                Lmax = Ltemp

    mass = np.loadtxt(fid, skiprows=9, usecols=8)
    mass_sum = round(np.sum(mass) - 0.29167,5)
    data[i,1] = mass_sum

    data[i,2] = round((Lmax - Lay),3)

    density = round(mass_sum / (Lx*Lmax),5)
    data[i,3] = density

    print(i)

#Save mass, time, and length data to csv
columns = ['Time', 'Deposited Mass', 'Max Length', 'Dendrite Density']
Data = pd.DataFrame(data, columns=columns)
Data.to_csv(job + '.csv',index=False)


    
 
