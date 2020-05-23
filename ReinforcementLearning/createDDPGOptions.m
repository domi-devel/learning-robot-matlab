%% DDPG Agent Options
agentOptions = rlDDPGAgentOptions;
agentOptions.SampleTime = Ts;
agentOptions.DiscountFactor = 0.99;
agentOptions.MiniBatchSize = 100;
agentOptions.ExperienceBufferLength = 5e5;
agentOptions.TargetSmoothFactor = 1e-1;
% agentOptions.NoiseOptions.MeanAttractionConstant = 2;
agentOptions.NoiseOptions.Variance = 3e-3;
agentOptions.NoiseOptions.VarianceDecayRate = 0;
% Set agent option parameter:
agentOptions.ResetExperienceBufferBeforeTraining = not(resumeTraining);
agentOptions.SaveExperienceBufferWithAgent = true;


%% Training Options
trainingOptions = rlTrainingOptions;
trainingOptions.MaxEpisodes = 20000;
trainingOptions.MaxStepsPerEpisode = Tf/Ts;
trainingOptions.ScoreAveragingWindowLength = 50;
trainingOptions.StopTrainingCriteria = 'AverageReward';
trainingOptions.StopTrainingValue = 200;
trainingOptions.SaveAgentCriteria = 'EpisodeReward';
trainingOptions.SaveAgentValue = 90;
trainingOptions.Plots = 'training-progress';
trainingOptions.Verbose = true;
if useParallel
    trainingOptions.Parallelization = 'async';
    trainingOptions.ParallelizationOptions.StepsUntilDataIsSent = 30;
end