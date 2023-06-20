import os
import numpy as np
import matplotlib.pyplot as plt

# Set latex font
plt.rcdefaults()

plt.rcParams.update({
    "text.usetex": True,
    "font.family": "serif",
    "font.serif": "mathptmx",
    "font.size": 11,
    })

width=4.6778 #Read width from latex document

folder = "Convergence_Spectral/"
folder_es = os.path.join(folder,"convergence_data_es.csv")
folder_ec = os.path.join(folder,"convergence_data_ec.csv")

# Read in data from csv files
data = np.genfromtxt(folder_es, delimiter=',', names=True, dtype=None)
N_es       = data['N_pol']
Err_es  = data['L2_Error'] 
data = np.genfromtxt(folder_ec, delimiter=',', names=True, dtype=None)
N_ec       = data['N_pol']
Err_ec  = data['L2_Error'] 

# Create figure
fig,ax = plt.subplots(figsize=(width, 1/1.5*width))
l = list(range(2))  # Legend handles
l[0], = ax.semilogy(N_es, Err_es, color = 'tab:blue', marker='^', markeredgecolor='black')
l[1], = ax.semilogy(N_ec, Err_ec, color = 'tab:orange', marker='o', markeredgecolor='black')

ax.legend((l[0],l[1]),('ES','EC'),loc='best')

ax.set_xlabel(r'N')
ax.set_ylabel(r'$L_2$ Error')

ax.set_xlim([5,30])
ax.set_ylim([1e-14,10e-1])

plt.tight_layout()
plt.savefig(os.path.join(folder,'convergence_plot.pdf'), format='pdf')
