import numpy as np
import matplotlib.pyplot as plt

# Import datafiles as variables
t_1 = np.loadtxt("t_0.001.txt")
t_2 = np.loadtxt("t_0.0005.txt")
t_3 = np.loadtxt("t_0.0001.txt")
xf_1 = np.loadtxt("xf_0.001.txt")
xf_2 = np.loadtxt("xf_0.0005.txt")
xf_3 = np.loadtxt("xf_0.0001.txt")

# Plot the time versus the xf value for each DELTAT values
plt.plot(t_1, xf_1, label="dt=0.001")
plt.plot(t_2, xf_2, label="dt=0.0005")
plt.plot(t_3, xf_3, label="dt=0.0001")
plt.xlabel("time")
plt.ylabel("xf")
plt.legend(loc="lower left", prop={'size': 9})
plt.grid()
plt.savefig("ThreeLorenz.png") # Save the plot
