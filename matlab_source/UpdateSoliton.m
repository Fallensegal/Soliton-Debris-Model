% Connor Wilson - August 2023
function [U_tk_1,U_tk_2,X,Y,tvec,xDim,yDim,uDim,neDim,neRelDim,tDim,Ubasic] = UpdateSoliton(R,V,UTCtime,time,diameter)

% Constants
K = 100; % Kappa-distributed plasma
alpha = 1.0051; % for Kappa = 100e
beta = 0.4925; % for Kappa = 100
e = 1.6*10^-19; % coulombs
me = 9.1*10^-31; %kg
eps = 8.854*10^-12; % C^2/(N m^2)

%parameters
gm = 'DebrisD';     % Choose the force profile from sol_force_d2d
cmode = 2;          % FFT (1) or Derivative method (2) in sol_steps_d2d

% Temporary calculation for Kappa-distributed Debye length
LLA = ecef2lla(R);

alt = LLA(3)/1000;  % km
lat = LLA(1);       %degrees
lon = LLA(2);       %degrees


%diameter will need to be updated to match the debris and relative velocity 
%will need to be adjusted for each timestep

clear U U_tk_1 U_tk_2
        
%% Initial Plasma parameters and transcritical limits
        
        
        [~,DebyeK,~,~,scale,G,ni,ni2,mi,mi2,vac,~,~,B] ...
            = ccmc_params_local(diameter,alt,lat,lon,UTCtime);
        
        vs = norm(V)/vac;
        fprintf('The debye length is: %f\n',DebyeK)

%% Domain
        % Optimize run time based on previously observed soliton trends.
        % you may need to adjust the size of deltaTreal, Lt, L, Ly, and N.
        % this is based on test and guess methodology as described in my
        % thesis. you may need to test for run time and make sure the
        % domains are so small as to distort the results. this was
        % optimized for the target sets applied in the thesis. If the
        % target size or the radar location changes, then you may need to
        % make big changes here.
        dt = 0.01; 
        dt10 = dt/10; saves = 1;
        tstart = time*(vac/DebyeK);
        deltaTreal = time+0.0002;
        tmax = deltaTreal*(vac/DebyeK);
        nmax = round((tmax-tstart)/dt);
        Lt = 2*vs*(tmax-tstart); 
        L = 16+16*floor(Lt/16); 
        %Ly = 6*round(L/16);  % 30 cm
        Ly = round(L/16); % 10 cm
        N = 16+16*floor(3*L/16); % 10 cm 
        %N = 16+16*floor(L/16); % 30 cm
        Ny = N;
        % Now define domain
        clear x xx y yy k ky X Y KX KY mult
        s = pi/L;
        sy = pi/Ly;
        dx = 2*L/N; dy = 2*Ly/Ny;
        k = [0:1:N/2,-(N/2-1):1:-1]; % Olsen
        ky = [0:1:Ny/2,-(Ny/2-1):1:-1]; % Olsen
        xx = (2*pi/N)*(0:1:N-1); % Olsen
        yy = (2*pi/Ny)*(0:1:Ny-1); % Olsen

        for ii = 1:N
            x(ii) = L * (xx(ii) /pi- 1);
        end
        for ii = 1:Ny
            y(ii) = Ly * (yy(ii) /pi- 1);
        end

        [X,Y]=meshgrid(x,y);
        [KX,KY]=meshgrid(s.*k,sy.*ky);
        % Fourier multiplier, zero out infinity values
        mult = -1i./(KX + 1i*(2^-52)); mult(:,1) = 0;


        
%% Damping coefficient (Arshad)
        ne = ni + ni2;
        NN = (ni/ne) + (ni2/ne)*(mi/mi2);
        del = (ni/ne) + (ni2/ne)*(mi/mi2)^2;
        wpi = sqrt((e^2)*ni/(eps*mi)); %plasma freq
        Gw1 = -sqrt(pi/8)*(gamma(K+1)*sqrt(NN))./(gamma(K-0.5)*(2^1.5*(K-0.5)^1.5));
        Gw2 = sqrt(me/mi);
        Gw3a = (ni/ne)*(B^1.5);
        Gw3b = (1 + ((B*NN)/(2*(2*K-1))) + ((3*del)/((2*K-3)*NN)))^(-K-1);
        Gw4 = (ni2/ne)*(B^1.5)*sqrt(mi2/mi);
        Gw5 = (1 + B*NN/(2*(2*K-1)) + del*(mi2/mi)*3/(NN*(2*K-3)))^(-K-1);
        Gw = abs(Gw1.*(Gw2 + Gw3a*Gw3b + Gw4*Gw5));

            Solwidth = 200*diameter*DebyeK;%diameter*200*DebyeK; %meters, 10cm debris has 10debye wide soliton
            ws = (vs*vac/(2*Solwidth)); % in wpi units, option 2
            DC = -Gw.*ws/wpi; % ws is in units ws/wpi, Damping coefficient in wpi

        
        

%% Initialize debris propagation

t = tstart;

clear g gm2 Fftg Fftgm1 Ifftg U_Init U_Initm1 U U_tk_1 U_tk_2
[g,gm1,Fftg,Fftgm1,Ifftg,~,~,A,offset,alpha,beta,CC] = ...
        sol_force_d2d(gm,scale,k,X,Y,t,dt,vs,G,KX,KY);

        %Initialization block
        t = tstart;
        kk=1;
        savesin = 1; U = zeros(length(y),length(x),savesin); tvec = zeros(1,savesin);
        U_tk_1_0 = ifft2((0.5*dt10*Fftg));
        U(:,:,1) = U_tk_1_0;

        U_tk_2 = zeros(length(y),length(x));
        Vtmp = zeros(length(y),length(x)); V_tk = zeros(length(y),length(x));

        [tvec,U,U_tk_1,U_tk_2,Vtmp,V_tk] = sol_steps_d2d(gm,scale,alpha,beta,dt10,t,tvec,U,X,Y,k,...
            U_tk_1_0,U_tk_2,savesin,kk,10,cmode,s,N,Ny,vs,G,DC,ky,sy,mult,KX,KY,dx,dy,Vtmp,V_tk);
        t = tvec(length(tvec));
        U_tk_2 = zeros(length(y),length(x));
    
    % Step through solution
    
    kk=1; U = zeros(length(y),length(x),saves);
    tvec = zeros(1,saves);
    U(:,:,1) = U_tk_1; tvec(1) = t;
    Vtmp = zeros(length(y),length(x)); V_tk = zeros(length(y),length(x));
    
    [tvec,U,U_tk_1,U_tk_2,Vtmp,V_tk] = sol_steps_d2d(gm,scale,alpha,beta,dt,t,tvec,U,X,Y,k,...
        U_tk_1,U_tk_2,saves,kk,nmax,cmode,s,N,Ny,vs,G,DC,ky,sy,mult,KX,KY,dx,dy,Vtmp,V_tk);


    %dimensionalize
    xDim = X*DebyeK;
    yDim = Y*DebyeK;
    Ubasic = real(U);
    uDim = Ubasic*vac;
    neDim = Ubasic*ne+ne;
    neRelDim = real(U)*ne;
    tDim = (tvec-dt)*(DebyeK/vac);
end