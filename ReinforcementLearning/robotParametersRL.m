% Walking Robot Parameters -- Reinforcement Learning
% Copyright 2019 The MathWorks, Inc.

%% Model parameters
% Mechanical
density = 500;
foot_density = 0;
if ~exist('actuatorType','var')
    actuatorType = 1;
end
world_damping = 1e-3;
world_rot_damping = 5e-2;
motor_speed_factor = 2;
                    
% Contact/friction parameters
contact_stiffness = 500;
contact_damping = 50;
mu_k = 0.7;
mu_s = 0.9;
mu_vth = 0.01;
height_plane = 0.025;
plane_x = 25;
plane_y = 10;
contact_point_radius = 1e-4;

% Foot dimensions
foot_radius = 2;
foot_width = 2;
foot_opacity = 0;
foot_offset = [-1 0 0];

% Leg dimensions
%leg_radius = 0.75;
lower_leg_length = 3.4;
upper_leg_length = 4.5;

% Torso dimensions
torso_y = 16;
torso_x = 23;
torso_z = 4;
torso_offset_y = torso_y/2 + 1;
torso_offset_z = -1.4;
torso_offset_x = torso_x/2-4.8;
mass = (0.01^3)*torso_y*torso_x*torso_z*density;
g = 9.80665;      

% Joint parameters
joint_damping = 1;
joint_stiffness = 0;
motion_time_constant = 0.01;
joint_limit_stiffness = 1e4;
joint_limit_damping = 10;

%% Reinforcement Learning (RL) parameters
Ts = 0.5; % Agent sample time
Tf = 30;    % Simulation end time
        

% Initial conditions
h = 9;     % Hip height [cm]
init_height = h + ...
              torso_z/2 + torso_offset_z + height_plane/2;
vx0 = 0;    % Initial X linear velocity [m/s]
vy0 = 0;    % Initial Y linear velocity [m/s]
wx0 = 0;    % Initial X angular velocity [rad/s]
wy0 = 0;    % Initial Y angular velocity [rad/s]
% Initial foot positions [m]
% leftinit =  [0;0;-h/100];
% rightinit = [0;0;-h/100];
leftinit =  [0;pi/2;-h/100];
rightinit = [0;0;-h/100];

% Calculate initial joint angles
% init_angs_L = walkerInvKin(leftinit, upper_leg_length/100, lower_leg_length/100,'3D');     
% init_angs_R = walkerInvKin(rightinit, upper_leg_length/100, lower_leg_length/100,'3D');
init_angs_L = walkerInvKin(leftinit, -pi/2, lower_leg_length/100,'3D');     
init_angs_R = walkerInvKin(rightinit, -pi/2, lower_leg_length/100,'3D');