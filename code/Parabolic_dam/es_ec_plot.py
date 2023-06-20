import pandas as pd
import os
import matplotlib.pyplot as plt

# Latex font
plt.rcdefaults()
plt.rcParams.update({
    "text.usetex": True,
    "font.family": "serif",
    "font.serif": "mathptmx",
    "font.size": 11,
    })

width=4.6778 # width from latex document

# Data Directory
dir = ("Parabolic_dam")
os.chdir(dir)

# Dataframe
df = pd.DataFrame(columns=['H1_es','H1_ec','H2_es','H2_ec','arclength'])

# Read in Data
data_es = pd.read_table('data_es.csv',delimiter=',')
data_ec = pd.read_table('data_ec.csv',delimiter=',')

# Plot
fig,ax = plt.subplots(figsize=(width, 1/1.5*width))

ax.plot(data_ec['Points_0'].to_numpy(dtype=float),data_ec['H_upper'].to_numpy(dtype=float)
        ,color ='tab:blue',label=r'$H_1$-ES')
ax.plot(data_es['Points_0'].to_numpy(dtype=float),data_es['H_upper'].to_numpy(dtype=float)
        ,color ='tab:blue',linestyle='dotted',label=r'$H_1$-EC')

ax.plot(data_ec['Points_0'].to_numpy(dtype=float),data_ec['H_lower'].to_numpy(dtype=float)
        ,color='tab:orange',label=r'$H_2$-ES')
ax.plot(data_es['Points_0'].to_numpy(dtype=float),data_es['H_lower'].to_numpy(dtype=float)
        ,color='tab:orange',linestyle='dotted',label=r'$H_2$-EC')

ax.set_xlabel('x')
ax.set_ylabel('Height')
ax.legend(loc=1)
ax.set_ylim([0.5,2.3])
ax.set_xlim([4,6])

plt.tight_layout()
plt.savefig('comparison_es_ec.pdf', format='pdf')