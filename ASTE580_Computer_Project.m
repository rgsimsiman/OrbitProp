function answer_table = ASTE580_Computer_Project(r0, v0, centralbody, dt)
%Name: ASTE580_Computer_Project
%Author: Rob Simsiman
%Date: 4/22/2020
%
%Purpose: Given initial position and velocity vectors, central body
%           parameters, and change in time, this function determines the
%           type of orbit, computes Keplerian elements, determines whether 
%           the S/C will impact the central body, and propagates the 
%           position and velocity vectors at time t
%
%Inputs:    r0 - initial position vector
%           v0 - initial velocity vector
%           centralbody - string indicating the central body
%           dt - change in time
%
%Outputs:   answer_table - Table of required answers per ASTE 580 Computer
%                           Project Handout

%Set constants of central body
T = readtable('Astronomical_Constants.xlsx');
centralbody_idx = find(strcmp(lower(T.Body), lower(centralbody)));
mu = T.mu_km_3_s_2_(centralbody_idx);
R = T.R_km_(centralbody_idx);

%Find the eccentricity to determine the type of orbit
evect = (1/mu)*((norm(v0)^2 - (mu/norm(r0)))*r0 - dot(r0, v0)*v0); %Eccentricity vector
e = norm(evect); %Eccentricity
fprintf('The eccentricity of this orbit is %f\n', e);

%Find the inclination, RAAN, and argument of periapsis
%Unit reference vectors in Z direction of XYZ frame
Khat = [0 0 1];
hhat = cross(r0, v0)/norm(cross(r0, v0)); %Angular momentum unit vector (km^2/s)
i = acosd(hhat(3)); %Inclination (deg)
Nhat = cross(Khat, hhat)/norm(cross(Khat, hhat)); %Nhat unit vector
capomega = acosd(Nhat(1)); %Right acension of the ascending node (deg)
if Nhat(2) < 0
    capomega = 360 - capomega; %Adjust if necessary
end
lomega = acosd((dot(evect, Nhat))/e); %Argument of periapsis (deg)
if evect(3) < 0
    lomega = 360 - lomega; %Adjust if necessary
end

%Find the true anomaly by first finding flight path angle and X0
beta = acosd(sind(acosd(dot(r0, v0)/(norm(r0)*norm(v0))))); %Flight path angle (deg)
X0 = norm(r0)*(norm(v0))^2/mu; %X0 parameter
theta = atand(X0*sind(beta)*cosd(beta)/(X0*cosd(beta)^2 - 1)); %True anomaly (deg)
if beta > 0 && theta < 0 || beta < 0 && theta > 0
    theta = theta + 180; %Adjust if in the wrong quadrant
elseif beta < 0 && theta < 0
    theta = theta + 360; %Adjust to have 0<=theta<=360
end

%Find variables to initialize orbit propagation process
alpha0 = (2/norm(r0)) - (norm(v0)^2/mu); %Alpha0 parameter for orbit propagation
E = 2*atand(sqrt((1-e)/(1+e))*tand(theta/2)); %Eccentric anomaly for initial state(deg)
M = (E * pi/180) - e*sind(E); %Mean anomaly (rad)
E1 = M + (e*sin(M)/(1 - sin(M + e) + sin(M))); %Initial guess for propagated E (rad)
theta1 = 2*atan(sqrt((1+e)/(1-e))*tan(E1/2)); %Initial guess for propagated theta (rad)

orbit_shape = "This orbit is a(n) ...";

if e > 10^-7 && e < (1 - 10^-7)
    disp('Therefore, this orbit is an ELLIPSE');
    orbit_shape(2) = "ELLIPSE";
    h = norm(r0)*norm(v0)*cosd(beta); %Angular momentum (km^2/s)
    p = h^2/mu; %Semilatus rectum (km)
    fprintf('The semilatus rectum is %f km\n', p);
    a = p/(1-e^2); %Semimajor axis (km)
    fprintf('The semimajor axis is %f km\n', a);
    tau = 2*pi*sqrt(a^3/mu); %Period (sec)
    fprintf('The period is %f seconds\n', tau);
    rp = a*(1-e); %Radius of periapsis (km)
    fprintf('The radius of periapsis is %f km\n', rp);
    ra = a*(1+e); %Radius of apoapsis (km)
    fprintf('The radius of apoapsis is %f km\n', ra);
    fprintf('The inclination is %f deg\n', i);
    fprintf('The RAAN is %f deg\n', capomega);
    fprintf('The argument of periapsis is %f deg\n', lomega);
    fprintf('The true anomaly is %f deg\n', theta);
    fprintf('The eccentric anomaly is %f deg\n', E);
    fprintf('The mean anomaly is %f deg\n', M * 180/pi);
    tp = sqrt(a^3/mu)*M; %Time to periapsis passage (sec)
    fprintf('The time to periapsis passage is %f seconds\n', tp);
    answers = [e, p, a, tau, rp, ra, i, capomega, lomega, theta, E, M * 180/pi, tp]; %Answers and labels for table
    answers_labels = ["Eccentricity", "Semilatus Rectum (km)", "Semimajor Axis (km)", ...
        "Period (sec)", "Radius of Periapsis (km)", "Radius of Apoapsis (km)", "Inclination (deg)", ...
        "RAAN (deg)", "Arg of Periapsis (deg)", "True Anomaly (deg)", "Eccentric Anomaly (deg)", ...
        "Mean Anomaly (deg)", "Time to Periapsis Passage (sec)"];
    
    %Set initial x for orbit propagation
    x = (E1 - E*(pi/180))/sqrt(alpha0); %Initial guess for x
elseif e > (1 - 10^-7) && e < (1 + 10^-7)
    disp('Therefore, this orbit is a PARABOLA');
    orbit_shape(2) = "PARABOLA";
    h = norm(r0)*norm(v0)*cosd(beta); %Angular momentum (km^2/s)
    p = h^2/mu; %Semilatus rectum (km)
    fprintf('The semilatus rectum is %f km\n', p);
    a = p/(1-e^2); %Semimajor axis (km)
    rp = a*(1-e); %Radius of periapsis (km)
    fprintf('The radius of periapsis is %f km\n', rp);
    fprintf('The inclination is %f deg\n', i);
    fprintf('The RAAN is %f deg\n', capomega);
    fprintf('The argument of periapsis is %f deg\n', lomega);
    fprintf('The true anomaly is %f deg\n', theta);
    answers = [p, rp, i, capomega, lomega, theta]; %Answers and labels for table
    answers_labels = ["Semilatus Rectum (km)", "Radius of Periapsis (km)", "Inclination (deg)", ...
        "RAAN (deg)", "Arg of Periapsis (deg)", "True Anomaly (deg)"];
    
    %Set initial x for orbit propagation
    x = sqrt(p) * (tan(theta1/2) - tand(theta/2)); %Initial guess for x
else
    disp('Therefore, this orbit is a HYPERBOLA');
    orbit_shape(2) = "HYPERBOLA";
    h = norm(r0)*norm(v0)*cosd(beta); %Angular momentum (km^2/s)
    p = h^2/mu; %Semilatus rectum (km)
    fprintf('The semilatus rectum is %f km\n', p);
    a = p/(1-e^2); %Semimajor axis (km)
    fprintf('The semimajor axis is %f km\n', a);
    vinf = sqrt(-mu/a); %Hyperbolic excess velocity (km/s)
    fprintf('The hyperbolic excess velocity is %f km/s\n', vinf);
    rp = a*(1-e); %Radius of periapsis (km)
    fprintf('The radius of periapsis is %f km\n', rp);
    fprintf('The inclination is %f deg\n', i);
    fprintf('The RAAN is %f deg\n', capomega);
    fprintf('The argument of periapsis is %f deg\n', lomega);
    fprintf('The true anomaly is %f deg\n', theta);
    answers = [e, p, a, vinf, rp, i, capomega, lomega, theta]; %Answers and labels for table
    answers_labels = ["Eccentricity", "Semilatus Rectum (km)", "Semimajor Axis (km)", ...
        "Hyperbolic Excess Velocity (km/s)", "Radius of Periapsis (km)", "Inclination (deg)", ...
        "RAAN (deg)", "Arg of Periapsis (deg)", "True Anomaly (deg)"];
    
    %Set initial x for orbit propagation
    H = 2*atan(sqrt((e-1)/(e+1))*tand(theta/2)); %Hyperbolic anomaly of initial state (rad)
    H1 = 2*atan(sqrt((e-1)/(e+1))*tan(theta1/2)); %Initial guess for propagated H (rad)
    x = (H1 - H)/sqrt(-alpha0); %Initial guess for x
end

%Determine whether the S/C will impact the central body
crash = "Will the spacecraft impact the central body?";
if rp <= R
    disp('The spacecraft WILL impact the central body');
    crash(2) = "YES";
else
    disp('The spacecraft WILL NOT impact the central body');
    crash(2) = "NO";
end

%Propagate the new position and velocity vectors at time t
tolerance = 10^-12; %Error tolerance between x and xnew
while 1
    SCInput = alpha0 * x^2; %Input to the S and C functions
    
    %Determine S and C functions according to input value
    if SCInput > 10^-7
        S = (sqrt(SCInput) - sin(sqrt(SCInput)))/(sqrt(SCInput))^3;
        C = (1 - cos(sqrt(SCInput)))/SCInput;
    elseif SCInput < -10^-7
        S = (sinh(sqrt(-SCInput)) - sqrt(-SCInput))/(sqrt(-SCInput))^3;
        C = (cosh(sqrt(-SCInput)) - 1)/(-SCInput);
    else
        S = 1/6;
        C = 1/2;
    end
    
    %Find xnew = x - F(x)/F'(x) where F(x) = G(x) - K
    G = (dot(r0, v0)/sqrt(mu))*x^2*C + (1-norm(r0)*alpha0)*x^3*S + norm(r0)*x;
    K = sqrt(mu)*dt;
    F = G - K;
    Fprime = (dot(r0, v0)/sqrt(mu))*(x - alpha0*x^3*S) + (1 - norm(r0)*alpha0)*x^2*C + norm(r0);
    xnew = x - (F/Fprime);
    
    %If xnew is within tolerance of x, break and solve for r(t) and v(t)
    %If not, continue iterating
    if abs(x - xnew) < tolerance
        break
    end
    x = xnew;
end

%Determine new positiona and velocity vectors after dt seconds
rt = (1 - ((x^2/norm(r0))*C))*r0 + (dt - ((x^3/sqrt(mu))*S))*v0; %Position vector (km)
fprintf('The position vector after dt = %f sec is r(t) = (%f, %f, %f) km\n', dt, rt(1), rt(2), rt(3));
vt = (sqrt(mu)/(norm(rt)*norm(r0)))*(alpha0*x^3*S - x)*r0 + (1-((x^2/norm(rt))*C))*v0; %Velocity vector (km/s)
fprintf('The velocity vector after dt = %f sec is v(t) = (%f, %f, %f) km/s\n', dt, vt(1), vt(2), vt(3));

%Construct table of answers
row1 = {orbit_shape(1)}; %State orbit shape
for i = 1:length(answers_labels)
    row1{end + 1} = answers_labels(i); %State Keplerian elements
end
%State whether S/C will crash and new r(t) and v(t)
row1 = [row1, {crash(1), "r(t) (km)", "v(t) (km/s)"}];
row2 = {orbit_shape(2)}; %State orbit shape
for i = 1:length(answers)
    row2{end + 1} = answers(i); %State Keplerian elements
end
%State whether S/C will crash and new r(t) and v(t)
row2 = [row2, {crash(2), rt, vt}];
Description = row1';
Answer = row2';
answer_table = table(Description, Answer); %Piece together rows 1 and 2

end

