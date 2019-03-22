# Repository for LuGre Friction identification
LuGre Friction model is 

<img src="https://latex.codecogs.com/svg.latex?\Large&space;\dot{z}=\dot{q}-\frac{\sigma_0\left|\dot{q}\right|}{s(\dot{q})}z" title="\Large \dot{z}=\dot{q}-\frac{\sigma_0\left|\dot{q}\right|}{s(\dot{q})}z" />

<img src="https://latex.codecogs.com/svg.latex?\Large&space;s(\dot{q})=F_c+(F_s-F_c)e^{-(\frac{\dot{q}}{v_s})^2}" title="\Large s(\dot{q})=F_c+(F_s-F_c)e^{-(\frac{\dot{q}}{v_s})^2}" />

<img src="https://latex.codecogs.com/svg.latex?\Large&space;\tau_{F_r}=\sigma_0z+\sigma_1\dot{z}+\sigma_2\dot{q}" title="\Large \tau_{F_r} &= \sigma_0 z + \sigma_1 \dot{z} + \sigma_2 \dot{q}" />

This identification algorithm is divided in two steps: 
1. Static parameters
2. Dynamic parameters

## Static Parameters Identification
