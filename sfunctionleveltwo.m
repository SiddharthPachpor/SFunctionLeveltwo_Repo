%Author : Siddharth pachpor
%Reference : Lecture from Dr. Matthew Rudy
function sfunctionleveltwo(block)

% call the setup function
setup(block);

%endfunction

%% Function: setup ===================================================
%% Abstract:
%%   Set up the basic characteristics of the S-function block such as:

function setup(block)

% Register number of ports
block.NumInputPorts  = 3;
block.NumOutputPorts = 3;

% Setup port properties to be inherited or dynamic
block.SetPreCompInpPortInfoToDynamic;
block.SetPreCompOutPortInfoToDynamic;

% % Override input port properties
% block.InputPort(1).Dimensions        = 1;
% block.InputPort(1).DatatypeID  = 0;  % double
% block.InputPort(1).Complexity  = 'Real';
% block.InputPort(1).DirectFeedthrough = true;
% 
% % Override output port properties
% block.OutputPort(1).Dimensions       = 1;
% block.OutputPort(1).DatatypeID  = 0; % double
% block.OutputPort(1).Complexity  = 'Real';

% Register parameters
block.NumDialogPrms     = 0;

% Register sample times
%  [0 offset]            : Continuous sample time
%  [positive_num offset] : Discrete sample time
%
%  [-1, 0]               : Inherited sample time
%  [-2, 0]               : Variable sample time
block.SampleTimes = [0 0];
%continuous times
% Specify the block simStateCompliance. The allowed values are:
%    'UnknownSimState', < The default setting; warn and assume DefaultSimState
%    'DefaultSimState', < Same sim state as a built-in block
%    'HasNoSimState',   < No sim state
%    'CustomSimState',  < Has GetSimState and SetSimState methods
%    'DisallowSimState' < Error out when saving or restoring the model sim state
block.SimStateCompliance = 'DefaultSimState';


block.RegBlockMethod('SetInputPortSamplingMode', @SetInportFrameData);
block.RegBlockMethod('Outputs', @Outputs);     % Required
block.RegBlockMethod('Terminate', @Terminate); % Required

%end setup

function Outputs(block)
V = block.InputPort(1).Data;
alpha = block.InputPort(2).Data;
beta = block.InputPort(3).Data;

block.OutputPort(1).Data = V*cos(alpha)*cos(beta)
block.OutputPort(2).Data = V*sin(beta);
block.OutputPort(3).Data = V*sin(alpha)*cos(beta);
%end Outputs




function SetInportFrameData(block, idx, fd)
  block.InputPort(idx).SamplingMode = fd;
  for i = 1:block.NumOutputPorts
        block.OutputPort(i).SamplingMode = fd;
  end 
 

function Terminate(block)

%end Terminate

