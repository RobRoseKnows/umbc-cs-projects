import numpy as np

def calc(x, y):
    return np.exp(np.sin(50.0 * x)) + np.sin(60.0 * np.exp(y)) +\
        np.sin(70.0 * np.sin(x)) + np.sin(np.sin(80.0 * y)) -\
        np.sin(20.0 * (x+y)) + (np.square(x)+np.square(y))/4.0

def optm(f, xmin, xmax, xf, ymin, ymax, yf, minstep=1.0e-6, tol=1.0e-6, maxeval=1000):
    cnt = 0
    dx = minstep # must be positive, should check
    dy = minstep
    xb = xf
    yb = yf
    zb = f(xb, yb)  # vb best = f(xb) to date
    while 1:
        x = xb # previous best
        y = yb
        z = zb # previous best
        xl = max(xmin,x-dx) # stay inside limits
        yl = max(ymin,y-dy)
        zl = f(xl, yl)
        if zl < zb:
            zb = zl
            xb = xl
            yb = yl
        xh = min(xmax,x+dx) # stay inside limits
        yh = min(ymax,y+dy)
        zh = f(xh, yh)
        if zh < zb :
            zb = zh
            xb = xh
            yb = yh
        cnt += 1
        if zl < z and z < zh:
            dx = 2.0*dx  # slope 1
            dy = 2.0*dy
        if zl < z and zh < z:
            dx = dx/2.0  # hump  2 and 4
            dy = dy/2.0
        if z < zh and z < zl:
            dx = dx/2.0  # valley  3 and 5
            dy = dy/2.0
        if zl > z and z > zh:
            dx = 2.0*dx   # slope 6
            dy = 2.0*dy
        
        # end this iteration, test for finish
        close = abs(z-zl)+abs(z-zh)
        if  dx < minstep or dy < minstep or close < tol or cnt > maxeval:
            return xb, yb, zb, cnt 

res = []
for startx in np.arange(-1, 1, 0.1):
    for starty in np.arange(-1, 1, 0.1):
        xbest, ybest, zbest, cnt = optm(calc, -1, 1, startx, -1, 1, starty)
        res += [(zbest, xbest, ybest, cnt)]
        print(f"startx={startx}, starty={starty}: xbest={xbest}, ybest={ybest}, zbest={zbest}, cnt={cnt}")
zbest, xbest, ybest, cnt = min(res)
print(f"Overall: xbest={xbest}, ybest={ybest}, zbest={zbest}, cnt={cnt}")

