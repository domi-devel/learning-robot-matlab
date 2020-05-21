%% DDPG Agent Options
agentOptions = rlDDPGAgentOptions;
agentOptions.SampleTime = Ts;
agentOptions.DiscountFactor = 0.99;
agentOptions.MiniBatchSize = 5;
agentOptions.ExperienceBufferLength = 5e5;
agentOptions.TargetSmoothFactor = 1e-1;
% agentOptions.NoiseOptions.MeanAttractionConstant = 2;
agentOptions.NoiseOptions.Variance = 15e-2;
agentOptions.NoiseOptions.VarianceDecayRate = 0;
% Set agent option parameter:
agentOptions.ResetExperienceBufferBeforeTraining = not(resumeTraining);
agentOptions.SaveExperienceBufferWithAgent = true;


%% Training Options
trainingOptions = rlTrainingOptions;
trainingOptions.MaxEpisodes = 10000;
trainingOptions.MaxStepsPerEpisode = Tf/Ts;
trainingOptions.ScoreAveragingWindowLength = 100;
trainingOptions.StopTrainingCriteria = 'AverageReward';
trainingOptions.StopTrainingValue = 510;
trainingOptions.SaveAgentCriteria = 'EpisodeReward';
trainingOptions.SaveAgentValue = 200;
trainingOptions.Plots = 'training-progress';
trainingOptions.Verbose = true;
if useParallel
    trainingOptions.Parallelization = 'async';
    trainingOptions.ParallelizationOptions.StepsUntilDataIsSent = 30;
end