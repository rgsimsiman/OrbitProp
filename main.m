%%% Main script called from executable %%%
clear; % Clear variables

% Create input UI
prompt = {'Enter initial position vector (rx, ry, rz) in km:', ...
    'Enter initial velocity vector (vx, vy, vz) in km/s:', ...
    'Enter central body:', ...
    'Enter start date and time (DD-MMM-YYYY HH:MM:SS):', ...
    'Enter stop date and time (DD-MMM-YYYY HH:MM:SS):', ...
    'Enter time step in s:'};
dlgtitle = 'Input';
dims = [1 70];
definput = {'-14192.498 -16471.197 -1611.2886', '-4.0072937 -1.2757932 1.9314620', 'Earth', '01-Jan-2021 00:00:00', '01-Jan-2021 08:00:00', '60'};
answer = inputdlg(prompt, dlgtitle, dims, definput);

% Check for valid inputs
if length(str2num(answer{1})) ~= 3
    error(['Input a valid initial position vector (rx, ry, rz), either comma' ...
        ' or space-separated.']);
elseif length(str2num(answer{2})) ~= 3
    error(['Input a valid initial velocity vector (vx, vy, vz), either comma' ...
        ' or space-separated.']);
elseif ~isempty(str2num(answer{3}))
    error('Input a valid central body entry');
elseif length(str2num(answer{6})) ~= 1
    error('Input a valid time step value.');
end

try
    start = datetime(answer{4});
catch
    error('Input a valid start date and time in the correct format (DD-MMM-YYYY HH:MM:SS)');
end

try
    stop = datetime(answer{5});
catch
    error('Input a valid stop date and time in the correct format (DD-MMM-YYYY HH:MM:SS)');
end

% Run propagator
r0 = str2num(answer{1});
v0 = str2num(answer{2});
centralbody = answer{3};
duration = seconds(stop - start);
dt = str2num(answer{6});
orbitprop(r0, v0, centralbody, duration, dt);

