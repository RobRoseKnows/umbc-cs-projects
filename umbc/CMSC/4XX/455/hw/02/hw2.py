import math

import numpy as np

from numpy.polynomial import polynomial as P

X = [   0.0, 0.1, 0.2, 0.3, 
        0.4, 0.5, 0.6, 0.7, 
        0.8, 0.9, 1.0, 1.1, 
        1.2, 1.3, 1.4, 1.5, 
        1.6, 1.7, 1.8, 1.9  ]
Y = [   00.00, 06.00, 14.09, 05.00,
        04.74, 04.60, 04.50, 04.40,
        04.30, 04.30, 04.30, 04.30,
        04.30, 04.30, 04.30, 04.30,
        04.30, 04.30, 04.30, 00.00  ]

x = np.array(X)
y = np.array(Y)

for deg in range(3, 18):
    coef, (residual, _, _, _) = P.polyfit(x, y, deg, full=True)
    errors = [ abs(Y[key] - P.polyval(val, coef)) for key, val in enumerate(X) ]
    max_error = max(errors)
    avg_error = sum(errors) / len(errors)
    rms_error = math.sqrt(sum(map(lambda x: x ** 2, errors)) / len(errors))
    print(f"Degree: {deg}, Coefficients: {list(coef)}, Residuals: {residual[0]}, Max Error: {max_error}, Average Error: {avg_error}, RMS Error: {rms_error}")
