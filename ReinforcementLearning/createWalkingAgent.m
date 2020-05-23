%% SET UP ENVIRONMENT
% Speedup options
useFastRestart = true;
useGPU = true;
useParallel = true;
resumeTraining = true;
renewOptions = true;
PRE_TRAINED_MODEL_FILE = 'Agent5018.mat';

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
    load(PRE_TRAINED_MODEL_FILE,'agent');
    if exist('agent', 'var') == 0
        load(PRE_TRAINED_MODEL_FILE,'saved_agent');
        agent = saved_agent;
    end
    if renewOptions
        tmpactor = getActor(agent);
        tmpcritic = getCritic(agent);
        tmpactor.Options = actorOptions;
        tmpcritic.Options = criticOptions;
        agent = rlDDPGAgent(tmpactor,tmpcritic,agentOptions)
        clear tmpactor tmpcritic  
    end
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