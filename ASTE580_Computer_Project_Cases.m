%%%ASTE 580 Computer Project Cases%%%

%Case 1
disp('Case 1');
r0 = [-14192.498 -16471.197 -1611.2886]; %Position vector (km)
v0 = [-4.0072937 -1.2757932 1.9314620]; %Velocity vector (km/s)
centralbody = 'Earth';
dt = 8*3600; %Delta t (sec)

%Propagate orbit and report proper answers
answer_table_case1 = ASTE580_Computer_Project(r0, v0, centralbody, dt);
save('answer_table_case1', 'answer_table_case1');
%%

%Case 2
disp('Case 2');
r0 = [148204590.0357 250341849.5862 72221948.8400]; %Position vector (km)
v0 = [-20.5065125006 7.8793469985 20.0718337416]; %Velocity vector (km/s)
centralbody = 'Sun';
dt = 10*(23*3600 + 56*60 + 4.09054); %Delta t (sec)

%Propagate orbit and report proper answers
answer_table_case2 = ASTE580_Computer_Project(r0, v0, centralbody, dt);
save('answer_table_case2', 'answer_table_case2');
%%

%Case 3
disp('Case 3');
r0 = [-321601.0957 -584995.9962 -78062.5449]; %Position vector (km)
v0 = [8.57101142 7.92783797 1.90640217]; %Velocity vector (km/s)
centralbody = 'Saturn';
t0 = datetime(2004, 6, 30, 14, 0, 0);
t = datetime(2004, 7, 1, 0, 47, 39.3);
dt = seconds(t - t0); %Delta t (sec)

%Propagate orbit and report proper answers
answer_table_case3 = ASTE580_Computer_Project(r0, v0, centralbody, dt);
save('answer_table_case3', 'answer_table_case3');
%%
%Case 4
disp('Case 4');
r0 = [8193.2875 -21696.2925 7298.8168]; %Position vector (km)
v0 = [-2.29275936 4.94003573 -1.67537281]; %Velocity vector (km/s)
centralbody = 'Titan';
dt = 1*3600 + 4*60 + 1.18; %Delta t (sec)

%Propagate orbit and report proper answers
answer_table_case4 = ASTE580_Computer_Project(r0, v0, centralbody, dt);
save('answer_table_case4', 'answer_table_case4');
%%
%Case 5
disp('Case 5');
r0 = [5492.00034 3984.0014 2.95581]; %Position vector (km)
v0 = [-3.931046491 5.498676921 3.665980697]; %Velocity vector (km/s)
centralbody = 'Earth';
dt = 5*3600; %Delta t (sec)

%Propagate orbit and report proper answers
answer_table_case5 = ASTE580_Computer_Project(r0, v0, centralbody, dt);
save('answer_table_case5', 'answer_table_case5');