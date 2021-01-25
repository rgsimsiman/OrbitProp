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
default_position = '';
default_velocity = '';
default_centralbody = 'Earth';
[current_year, current_month, current_day] = ymd(datetime(clock));
default_start = [datestr(datetime(current_year, current_month, current_day)) ' 00:00:00'];
default_stop = [datestr(datetime(current_year, current_month, current_day) + days(1)) ' 00:00:00'];
default_timestep = '';
definput = {default_position, default_velocity, default_centralbody, ...
    default_start, default_stop, default_timestep};
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

