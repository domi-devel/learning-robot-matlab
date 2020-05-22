%% SET UP ENVIRONMENT
% Speedup options
useFastRestart = true;
useGPU = true;
useParallel = true;
% Set to true, to resume training from a saved agent
resumeTraining = false;
PRE_TRAINED_MODEL_FILE = 'trainedAgent_2D_05_22_2020_1738.mat';

% Create the observation info
numObs = 35;
observationInfo = rlNumericSpec([numObs 1]);
observationInfo.Name = 'observations';

% create the action info
numAct = 8;
actionInfo = rlNumericSpec([numAct 1],'LowerLimit',-1,'UpperLimit', 1);
actionInfo.Name = 'foot_angles';

% Environment
mdl = 'walkingRobotRL2D';
load_system(mdl);
blk = [mdl,'/RL Agent'];
env = rlSimulinkEnv(mdl,blk,observationInfo,actionInfo);
env.ResetFcn = @(in)walkerResetFcn(in,upper_leg_length/100,lower_leg_length/100,h/100,'2D');
if ~useFastRestart
   env.UseFastRestart = 'off';
end

%% CREATE NEURAL NETWORKS
createDDPGNetworks;
                     
%% CREATE AND TRAIN AGENT
createDDPGOptions;
if resumeTraining
    % Load the agent from the previous session
    sprintf('- Resume training of: %s', PRE_TRAINED_MODEL_FILE);
    load(PRE_TRAINED_MODEL_FILE,'agent');
%     load(PRE_TRAINED_MODEL_FILE,'saved_agent');
%     agent = saved_agent;
else
    % Create a fresh new agent
    agent = rlDDPGAgent(actor,critic,agentOptions);
end

trainingResults = train(agent,env,trainingOptions)

%% SAVE AGENT
%reset(agent); % Clears the experience buffer
curDir = pwd;
saveDir = 'savedAgents';
cd(saveDir)
save(['trainedAgent_2D_' datestr(now,'mm_DD_YYYY_HHMM')],'agent');
save(['trainingResults_2D_' datestr(now,'mm_DD_YYYY_HHMM')],'trainingResults');
cd(curDir)