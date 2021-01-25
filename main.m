%%% Main script called from executable %%%
clear; % Clear variables

% Create input UI
prompt = {'Enter initial position vector (rx, ry, rz) in km:', ...
    'Enter initial velocity vector (vx, vy, vz) in km/s:', ...
    'Enter central body:', 'Enter time step in s:'};
dlgtitle = 'Input';
dims = [1 70];
answer = inputdlg(prompt,dlgtitle,dims);

% Check for valid inputs
if length(str2num(answer{1})) ~= 3
    error(['Input a valid initial position vector (rx, ry, rz), either comma' ...
        ' or space-separated.']);
elseif length(str2num(answer{2})) ~= 3
    error(['Input a valid initial velocity vector (vx, vy, vz), either comma' ...
        ' or space-separated.']);
elseif isempty(str2num(answer{3}))
    error('Input a valid central body entry');
elseif length(str2num(answer{4})) ~= 1
    error('Input a valid time step value.');
end

% Run propagator
r0 = str2num(answer{1});
v0 = str2num(answer{2});
centralbody = answer{3};
dt = str2num(answer{4});
orbitprop(r0, v0, centralbody, dt);

