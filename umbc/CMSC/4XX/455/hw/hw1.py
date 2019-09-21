from collections import defaultdict

LENGTH = 0.311 #meters
DIAMETER = 0.0241 #meters
BODY_AREA = 0.506E-3 #square meters
CD_BODY = 0.45 #dimensionless
FINS_AREA = 0.00496 #square meters
FINS_AMT = 3 #number
CD_FINS = 0.01 #dimensionless
MASS_ROCKET = 0.0340 #kilogram
MASS_ENGINE_START = 0.0242 #kilogram
MASS_ENGINE_FINAL = 0.0094 #kilogram
DT = 0.1 # second
RHO = 1.2983 #kilograms per meter cubed
G = 9.80665
THRUST = defaultdict(float,{
    0.0: 0.0,
    0.1: 6.0,
    0.2: 14.09,
    0.3: 5.0,
    0.4: 4.74,
    0.5: 4.6,
    0.6: 4.5,
    0.7: 4.4,
    0.8: 4.3,
    0.9: 4.3,
    1.0: 4.3,
    1.1: 4.3,
    1.2: 4.3,
    1.3: 4.3,
    1.4: 4.3,
    1.5: 4.3,
    1.6: 4.3,
    1.7: 4.3,
    1.8: 4.3,
    1.9: 0
})
MASS_LOST = 0.0001644

def check_thrust():
    return sum(THRUST.values())

def force_drag(cd: float, rho: float, area: float, v: float) -> float:
    return (cd * rho * area * v**2) / 2

def force_drag_body(v: float) -> float:
    return force_drag(CD_BODY, RHO, BODY_AREA, v)

def force_drag_fins(v: float) -> float:
    return force_drag(CD_FINS, RHO, FINS_AREA, v)

def force_gravity(m: float) -> float:
    return m * G

def force(m: float, v: float, t: float) -> float:
    return THRUST[round(t,1)] - (force_drag_body(v) + force_drag_fins(v) + force_gravity(m))

def compute():
    t = 0
    s = 0
    v = 0
    a = 0
    F = 0
    m = MASS_ROCKET + MASS_ENGINE_START
    while v >= 0:
        t += DT
        F = force(m, v, t)
        a = F/m
        dv = a * DT
        v += dv
        ds = v * DT
        s += ds
        print(f"{round(t,1)} s, {s} m, {v} m/s, {a} m/s^2, {m} kg")
        m -= MASS_LOST * THRUST[round(t,1)]

if __name__ == "__main__":
    compute()
    #print(check_thrust())