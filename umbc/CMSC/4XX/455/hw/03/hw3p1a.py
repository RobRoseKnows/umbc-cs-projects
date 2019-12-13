import numpy as np

# based on: https://www.math.ubc.ca/~pwalls/math-python/integration/trapezoid-rule/
def trapezoid(func, start, end, n):
    x = np.linspace(start, end, n+1)
    y = func(x)
    right = y[1:]
    left = y[:-1]
    dx = (end - start) / n
    return (dx/2) * np.sum(right + left)

exact = 1.0-np.cos(1.0)
print(f"Exact: {exact}")
for x in [16, 32, 64, 128]:
    aprox = trapezoid(np.sin, 0.0, 1.0, x)
    print(f"trapezoid n={x}: {aprox}, error: {abs(aprox - exact)}")
