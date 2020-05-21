% Walking Robot Startup Script

%% Clear everything
clc
clear
close all

%% Add folders to the path
addpath(genpath('ReinforcementLearning'), ...    % Reinforcement learning files
        genpath('Libraries'), ...                % Other dependencies
        genpath('CAD'), ...                      % CAD Models
        genpath('savedAgents'));                 % Saved Agents
                         
%% Load basic robot parameters
robotParametersRL

%% Open the README file
% edit README.md