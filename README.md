# Repository for LuGre Friction identification
LuGre Friction model:

<img src="https://latex.codecogs.com/svg.latex?\Large&space;\dot{z}=\dot{q}-\frac{\sigma_0\left|\dot{q}\right|}{s(\dot{q})}z" title="\Large \dot{z}=\dot{q}-\frac{\sigma_0\left|\dot{q}\right|}{s(\dot{q})}z" />

<img src="https://latex.codecogs.com/svg.latex?\Large&space;s(\dot{q})=F_c+(F_s-F_c)e^{-(\frac{\dot{q}}{v_s})^2}" title="\Large s(\dot{q})=F_c+(F_s-F_c)e^{-(\frac{\dot{q}}{v_s})^2}" />

<img src="https://latex.codecogs.com/svg.latex?\Large&space;\tau_{F_r}=\sigma_0z+\sigma_1\dot{z}+\sigma_2\dot{q}" title="\Large \tau_{F_r} &= \sigma_0 z + \sigma_1 \dot{z} + \sigma_2 \dot{q}" />

This identification algorithm is divided in two steps: 

## 1. Static Parameters Identification
An experiment using constant velocity reference signal and a Control has to be conducted. In this way, the system acceleration is equal to zero and therefore the effort measured is equal to friction torque.
As each velocity will be mapped with a friction torque, this identification will need as many velocities as possible. After that a velocity-torque point cloud will be used in a Particle Swarm Optimization (PSO) to fit with LuGre model curve.

### Preprocessing
`identify_static_param.m` reads one `.mat` file from one joint experiment.
This script requires `unpack.m` to generate joint data, `interval_definition.m` to divide experiment into different velocity points, `signal_filter.m` to obtain the mean value from velocity and friction torque.

### Optimization
`getCost.m`,`fun_contraint.m` and `fun_barrier.m` will be used within `static_optim.m` to run PSO algorithm. Then a plot is given comparing actual friction points and the friction model with parameters from PSO. 

## 2. Dynamic Parameters Identification
Run `identify_dynamic_param.m`, input parameters should be joint name `"yaw"`, `"pitch"`, `"roll"`, sigma2 value and joint mass


#References
[LuGre Aproximation Models for Static and Dynamic parameters identification](http://citeseerx.ist.psu.edu/viewdoc/download?doi=10.1.1.887.5758&rep=rep1&type=pdf)
[Friction Identification and Compensation, Kermani 2007](https://ieeexplore.ieee.org/stamp/stamp.jsp?arnumber=4389106)
