% Requires loaded agent!
onnx_folder = 'ONNX'
% agent = saved_agent
%% Export actor network to ONNX file
myactor = getActor(agent)
myactornetwork = getModel(myactor)
exportONNXNetwork(myactornetwork, 'ONNX\actor.onnx')

%% Export critic network to ONNX file
mycritic = getCritic(agent)
mycriticnetwork = getModel(mycritic)
exportONNXNetwork(mycriticnetwork, 'ONNX\critic.onnx')


%% Cleanup variables
clear myactor myactornetwork mycritic mycriticnetwork
