%% Unpack data from file

function joint = unpack(joint_name)
prompt = 'Set file name to unpack: ';
str = input(prompt);
load(str);

%% Joint
%% Roll
if exist('roll_motor_r') && joint_name == "roll"
   joint.position.time = roll_motor_r.joints_state_samples.time - roll_motor_r.joints_state_samples.time(1);
   joint.position.signal = roll_motor_r.joints_state_samples.position;
   joint.effort = roll_motor_r.joints_state_samples.effort;
end
%% Pitch
if exist('pitch_motor_r') && joint_name == "pitch"
   joint.position.time = pitch_motor_r.joints_state_samples.time - pitch_motor_r.joints_state_samples.time(1);
   joint.position.signal = pitch_motor_r.joints_state_samples.position;
   joint.effort = pitch_motor_r.joints_state_samples.effort;
end

%% Yaw
if exist('yaw_motor_r') && joint_name == "yaw"
   joint.position.time = yaw_motor_r.joints_state_samples.time - yaw_motor_r.joints_state_samples.time(1);
   joint.position.signal = yaw_motor_r.joints_state_samples.position;
   joint.effort = yaw_motor_r.joints_state_samples.effort;
end

%% Joint_ref
if exist('joint_ref')
   joint.ref.time = joint_ref.jointsRef.time - joint_ref.jointsRef.time(1);
   joint.ref.position = joint_ref.jointsRef.position;
   joint.ref.vel = joint_ref.jointsRef.speed;
   joint.ref.acc = joint_ref.jointsRef.acceleration;
   joint.ref.effort = joint_ref.jointsRef.effort;
end

% %% Joint_obs
% if exist('joint_obs')
%    joint.est.time = joint_obs.jointsOut.time - yaw_motor_r.joints_state_samples.time(1);
%    joint.est.position = joint_obs.jointsOut.position;
%    joint.est.vel = joint_obs.jointsOut.speed;
%    joint.est.acc = joint_obs.jointsOut.acceleration;
% end

%% Friction_compensation
if exist('friction_compensation')
   joint.friction.time = friction_compensation.effortOut.time - friction_compensation.effortOut.time(1);
   joint.friction.effortPID = friction_compensation.effortOut.effort;
   joint.friction.friction = friction_compensation.friction;
end

joint.vel.time = joint_obs.jointsOut.time - yaw_motor_r.joints_state_samples.time(1);
joint.vel.signal = joint_obs.jointsOut.speed;