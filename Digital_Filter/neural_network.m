load('pitch_torque');
t = 39650:42000;
pos = joint_obs.jointsOut.position(t);
net = feedforwardnet([100]);
net.trainParam.min_grad = 1e-11;
net = train(net, t, pos');
plot(t,pos,t,net(t));