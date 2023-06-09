%% STEP 2: fit GLM

% first choose parameters for basis vectors that characterize the
% stimulus and post-spike filters

% Note that the parameters for basis vectors here were used to fit the
% regular spiking behavior in Weber & Pillow 2017 (Neural Computation).
% For other cell types, different sets of basis vectors were used, so
% simply changing the cell type above will not directly reproduce results
% from the paper.


%%% basis functions for stimulus filter
nkt = 300; % number of ms in stim filter
kbasprs.neye = 0; % number of "identity" basis vectors near time of spike;
kbasprs.ncos = 7; % number of raised-cosine vectors to use
kbasprs.kpeaks = [.1 round(nkt/1.2)];  % position of first and last bump (relative to identity bumps)
kbasprs.b = 10; % how nonlinear to make spacings (larger -> more linear)
%%% basis functions for post-spike kernel
ihbasprs.ncols = 7;  % number of basis vectors for post-spike kernel
ihbasprs.hpeaks = [.1 300];  % peak location for first and last vectors, in ms
ihbasprs.b = 10;  % how nonlinear to make spacings (larger -> more linear)
ihbasprs.absref = 1; % absolute refractory period, in ms

softRect = 0;    % use exponential nonlinearity
plotFlag = 1;    % plot fit
saveFlag = 0;    % save fit to fid, in new folder
maxIter = 5000;  % max number of iterations for fitting, also used for maximum number of function evaluations(MaxFunEvals)
tolFun = 1e-15;  % function tolerance for fitting
L2pen = 0;       % penalty on L2-norm of parameter coefficients

[k, h, dc, prs, kbasis, hbasis] = fit_glm(I,spikes,dt,nkt,kbasprs,ihbasprs,[],softRect,plotFlag,maxIter,tolFun,L2pen);

% save
if saveFlag
    if ~isdir([fid '/glm_fits'])
        mkdir(fid, 'glm_fits')
    end
    tag = '';
    if softRect
        tag = '_sr';
    end
    save([fid '/glm_fits/' cid tag '_glmfit.mat'],'cellType','cid','dt','I','spikes','prs','kbasis','hbasis','softRect','maxIter','tolFun','L2pen','nkt','kbasprs','ihbasprs','k','h','dc')
    disp(['saved: ' fid '/glm_fits/' cid tag '_glmfit.mat'])
end

%% STEP 3: simulate responses of fit GLM

plotFlag = 1; % plot simulated data
saveFlag = 0; % save simulated data
runs = 10;    % number of trials to simulate

[y, stimcurr, hcurr, r] = simulate_glm(I,dt,k,h,dc,runs,softRect,plotFlag);

if saveFlag
    if ~isdir([fid '/glm_sim_data'])
        mkdir(fid, 'glm_sim_data')
    end
    save([fid '/glm_sim_data/' cid tag '_glmdata.mat'],'y','stimcurr','hcurr','r')
    disp(['saved: ' fid '/glm_sim_data/' cid tag '_glmdata.mat'])
end

%% STEP 4: compare responses from simulated GLM and original Izhikevich data

compare_glm_to_iz(cellType,fid,softRect,jitter)

