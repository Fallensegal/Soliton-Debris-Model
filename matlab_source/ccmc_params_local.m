% Connor Wilson - August 2023
function [Debye,DebyeK,Alpha,Beta,scale,G,ni,ni2,mi,mi2,vac,v_sup,v_sub,B] = ccmc_params_local(radius,alt,lat,lon,UTCtime)
%originally created by Alexis as ccmc_params, but this has been mostly
%changed by Connor to use the 2016 iri model and remove precursor soliton
%methods

% Constants
K = 100;
Alpha = 1.0051; % for Kappa = 100
Beta = 0.4925; % for Kappa = 100
kbj = 1.38064852*10^-23; %J/K SI - Boltzman constant
mp = 1.67*10^-27; % kg - mass of a proton

%load iri for this location
        gIon.time = UTCtime;
        gIon.lat = lat;
        gIon.lon = lon;

        gIon.altkmrange = alt;
        iono = iri2016.iri2016(gIon.time, gIon.lat, gIon.lon,gIon.altkmrange);
        ne = iono.Ne;
        Te = iono.Te;
        Ti = iono.Ti;
        nO = iono.nO;
        nH = iono.nH;
        nHe = iono.nHe;
        nO2 = iono.nO2;
        nNO = iono.nNO;
        nN = iono.nN;

        mO = 16*mp;
        mH = mp;
        mHe = 4*mp;
        mO2 = 2*16*mp;
        mNO = (14+16)*mp;
        mN = 14*mp;

        Ions = [nO mO; nH mH; nHe mHe; nO2 mO2; nNO mNO; nN mN];
        IonsSort = flip(sortrows(Ions,1));
        ni = IonsSort(1,1);
        mi = IonsSort(1,2);
        ni2 = IonsSort(2,1);
        mi2 = IonsSort(2,2);

        %load dominant ion scaling - this may need changed in the future
load('scale_hydrogen','phinormd','Gs'); 
load('scale_oxygen','phinormdo');
Gscale = Gs; clear Gs ;
                                  
Debye = 69*sqrt(Te/ne);
DebyeK = Debye*(2*K-3)/(2*K-1);
G = radius/DebyeK;
% Charge of debris is based on dominant ion
if mi > 1.25*mHe
    scale = abs(interp1(Gscale,phinormdo(:,1),G,'linear','extrap')); % Oxygen (also used as a nitrogen substitute)
else
    scale = abs(interp1(Gscale,phinormd(:,1),G,'linear','extrap')); % Hydrogen (also used as a helium substitute)
end

Area = scale*G*sqrt(pi);
v_sup = 1+((3*(Alpha/2)^2*(Area)^2)/(16*Beta))^(1/3);
v_sub = 1-((3*(Alpha/2)^2*(Area)^2)/(4*Beta))^(1/3);

vac = sqrt(kbj*Te/mi);
B = Te/Ti;

fprintf('The value of Te is: %f\n', Te);
fprintf('The value of Ti is: %f\n', Ti);

end