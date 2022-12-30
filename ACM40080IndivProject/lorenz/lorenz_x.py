import numpy as np
sigma = 10.
b = 8./3
r = 28
x=-0.1
y=1.
z=0.
ni = 5000
dt = DELTAT
t = np.arange(0, 25+dt, dt)
ni = t.size
xf = np.zeros(ni)
yf = np.zeros(ni)
zf = np.zeros(ni)
for i in range(ni):
    dx = sigma*(y-x)
    dy = (r*x) - y - (x*z)
    dz = (x*y) - (b*z)
    x = x + dt*dx
    xf[i] = x
    y = y + dt*dy
    yf[i] = y
    z = z + dt*dz
    zf[i] = z

