cd('C:\Users\kriped\Chalmers\Christophe Demaziere - XEROM\Matlab code\1G_HOM_REAL_MAIN_SC')
load('C:\Users\kriped\Chalmers\Christophe Demaziere - XEROM\Matlab code\1G_HOM_REAL_MAIN_SC\input\input_data.mat')

%Should crossterms be included (1 = Yes 0 = No)
crossterms = 1;
nodevol = cellvol;
 % calculate keff
keff = XS_HOMO.NF/(XS_HOMO.D*bsq(1)+XS_HOMO.SA);
XS_HOMO.SE = XS_HOMO.NF/keff-XS_HOMO.SA;

phiInt0 = sum(phi(:,:,:,1)*nodevol,'all'); % calculate the volume integral over the fundamental mode
%XS_HOMO.NF/nu*phiInt0

PS = reactor_power*keff/(phiInt0*XS_HOMO.KF); % calculate the power scaling

phieq = phi(:,:,:,1).*PS; % Apply power scaling to the fundamental mode (cm^-2*s^-1)
%phieq_old =phi(:,:,:,1).*PS_old;
phieq_average = nodevol*sum(phieq,'all')/V;
%phieq_old_average = nodevol*sum(phieq_old,'all')/V
Xeq = (gammaI+gammaX).*(XS_HOMO.NF/nu)*phieq./(keff.*(lambdaX+sigmaX*phieq)); % Calculate the equilibrium xenon concentration (cm^-3)
Xeq_average = nodevol *sum(Xeq,'all')/V;

phi0mat = zeros(nmodes);% Initialise vectors
X0mat = zeros(nmodes); % Initialise vectors

EMI = sum(phi(:,:,:,1)*nodevol,'all'); % Calculate the Equlibrium mode integral for the feedback term


 if crossterms == 1 % Include all cross terms
     
    for m = 1:nmodes
        norm_m = sum(phi(:,:,:,m).^2*nodevol,'all'); % Calculate normalisation term m
        for n = 1:m
            norm_n = sum(phi(:,:,:,n).^2*nodevol,'all'); % Calculate opposite normalistation term
            phiint = sum(phieq(:,:,:).*phi(:,:,:,m).*phi(:,:,:,n)*nodevol,'all'); % Calculate phi crossterm
            phi0mat(n,m) = phiint/norm_n; % Normalise cross term in m 
            phi0mat(m,n) = phiint/norm_m; % Normalise cross term in n
            X0int = sum(Xeq(:,:,:).*phi(:,:,:,m).*phi(:,:,:,n)*nodevol,'all'); % Calculate X cross terms
            X0mat(n,m) = X0int/norm_n; % Normalise crossterms in m
            X0mat(m,n) = X0int/norm_m; % Normalise crosterms in n
        end
    end
    X0m = sum(X0mat); % Perform sum of X crossterms (Collapse collumns)
    phi0m = sum(phi0mat); %Perform sum of phi crossterms (Collapse collumns)
 else % Include cross terms
    X0m = zeros(1:length(nmodes)); % Initialise vectors
    phi0m = zeros(1:length(nmodes));  % Initialise vectors
    for m = 1:nmodes
        norm = sum(phi(:,:,:,m).^2*nodevol,'all'); % Calculate normalistation term
        phiint = sum(phieq(:,:,:).*phi(:,:,:,m).^2*nodevol,'all'); % Calculate phi term
        phi0m(m) = phiint/norm; % Normalise phi term
        X0int = sum(Xeq(:,:,:).*phi(:,:,:,m).^2*nodevol,'all'); % Calculate x term
        X0m(m) = X0int/norm; % normalise X term
    end
end


%clear   phieq Xeq PS phiInt0 phiint X0int norm n m DF Lambda modes

save('input\ROM_input.mat')
