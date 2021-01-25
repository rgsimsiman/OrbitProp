function PlanetaryConstants = PlanetaryConstants(bodies)
    % This function generates the planetary constants to be used in orbit
    % propagation.
    %
    % More planetary body constants can be added as necessary.
    %
    %   Inputs:
    %       bodies (1xN cell) - List of names of bodies (i.e. Earth, Sun,
    %       etc.)
    %
    %   Outputs:
    %       PlanetaryConstants (Nx3 structure) - Structure of planetary
    %       constants
    %           Body (string) - Name of body
    %           Mu (double) - Gravitational Parameter (km^3/s^2)
    %           R  (double) - Body Radius (km)
    
    %Initialize structure
    PlanetaryConstants = struct();
    
    %List of bodies
%     planets = {'Mercury', 'Venus', 'Earth', 'Mars', 'Jupiter', 'Saturn', ...
%         'Uranus', 'Neptune', 'Pluto'};
%     sun = 'Sun';
%     bodies = [planets sun];
    
    %Populate structure with constants
    if ~iscell(bodies) == 1
        bodies = {bodies};
    end
    
    for i = 1:length(bodies)
        PlanetaryConstants(i).Body = bodies{i};
        switch lower(bodies{i})
            case 'mercury'
                PlanetaryConstants(i).Mu = 22032.08;
                PlanetaryConstants(i).R = 2440.53;
            case 'venus'
                PlanetaryConstants(i).Mu = 324858.599;
                PlanetaryConstants(i).R = 6051.8;
            case 'earth'
                PlanetaryConstants(i).Mu = 398600.433;
                PlanetaryConstants(i).R = 6378.1366;
            case 'mars'
                PlanetaryConstants(i).Mu = 42828.314;
                PlanetaryConstants(i).R = 3396.19;
            case 'jupiter'
                PlanetaryConstants(i).Mu = 126712767.858;
                PlanetaryConstants(i).R = 71492;
            case 'saturn'
                PlanetaryConstants(i).Mu = 37940626.061;
                PlanetaryConstants(i).R = 60268;
            case 'uranus'
                PlanetaryConstants(i).Mu = 5794549.007;
                PlanetaryConstants(i).R = 25559;
            case 'neptune'
                PlanetaryConstants(i).Mu = 6836534.064;
                PlanetaryConstants(i).R = 24764;
            case 'pluto'
                PlanetaryConstants(i).Mu = 981.601;
                PlanetaryConstants(i).R = 1188.3;
            case 'sun'
                PlanetaryConstants(i).Mu = 132712440017.987;
                PlanetaryConstants(i).R = 696000;
            otherwise
                error(['The following body is not yet supported: ' ...
                    bodies{i} '. Add the body and its constants to PlanetaryConstants.']);
        end
    end
end