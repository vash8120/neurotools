% glmtest
% [vm_all,t_all,te_all]=izhikevich(0.02,0.2,-55,4,@(z) 10.*((heaviside(z-200)-heaviside(z-250))+(heaviside(z-800)-heaviside(z-870))+heaviside(z-1000)-heaviside(z-1800)),[0,10000],0.05)
% I=Isym(t_all);


% [vm_all,t_all,te_all]=izhikevich(0.02,0.25,-55,0.05,@(z) 0.6.*((heaviside(z-200)-heaviside(z-250))+(heaviside(z-800)-heaviside(z-870))+heaviside(z-1000)-heaviside(z-1800)+heaviside(z-2600)-heaviside(z-5000)+heaviside(z-7000)-heaviside(z-7200)+heaviside(z-7600)-heaviside(z-7660)),[0,10000],0.05);
% Isym = @(z) 0.6.*((heaviside(z-200)-heaviside(z-250))+(heaviside(z-800)-heaviside(z-870))+heaviside(z-1000)-heaviside(z-1800)+heaviside(z-2600)-heaviside(z-5000)+heaviside(z-7000)-heaviside(z-7200)+heaviside(z-7600)-heaviside(z-7660));



% Isym = @(z) 0.6.*((heaviside(z-200)-heaviside(z-250))+(heaviside(z-800)-heaviside(z-870))+heaviside(z-1000)-heaviside(z-1800)+heaviside(z-2600)-heaviside(z-5000)+heaviside(z-7000)-heaviside(z-7200)+heaviside(z-7600)-heaviside(z-7660));
tt = 0:0.05:(10000-0.05);
tt=tt';
I=0.01.*randn(200000,1);
I(130000:149999,1)=0.1*x(10000:29999)';
% [vm_all,t_all,te_all]=izhikevich(0.02,0.25,-55,0.05,@(z) I(find(abs(tt-z)<0.02,1)),[0,10000],0.05);
[vm_all,t_all,te_all]=izhikevich(0.02,0.25,-55,0.05,@(z) I(find(abs(tt-z)<0.1,1)),[0,10000],0.05);

t_all=t_all(1:200000);
hh=histogram(te_all,t_all);
spikes=hh.Values;
spikes(200000)=0;
spikes=spikes';
dt=0.05;

%% STEP 2: fit GLM

% first choose parameters for basis vectors that characterize the
% stimulus and post-spike filters

% Note that the parameters for basis vectors here were used to fit the
% regular spiking behavior in Weber & Pillow 2017 (Neural Computation).
% For other cell types, different sets of basis vectors were used, so
% simply changing the cell type above will not directly reproduce results
% from the paper.


%%% basis functions for stimulus filter
nkt = 100; % number of ms in stim filter
kbasprs.neye = 0; % number of "identity" basis vectors near time of spike;
kbasprs.ncos = 7; % number of raised-cosine vectors to use
kbasprs.kpeaks = [.1 round(nkt/1.2)];  % position of first and last bump (relative to identity bumps)
kbasprs.b = 10; % how nonlinear to make spacings (larger -> more linear)
%%% basis functions for post-spike kernel
ihbasprs.ncols = 7;  % number of basis vectors for post-spike kernel
ihbasprs.hpeaks = [.1 100];  % peak location for first and last vectors, in ms
ihbasprs.b = 10;  % how nonlinear to make spacings (larger -> more linear)
ihbasprs.absref = 1; % absolute refractory period, in ms

softRect = 0;    % use exponential nonlinearity
plotFlag = 1;    % plot fit
saveFlag = 0;    % save fit to fid, in new folder
maxIter = 1000;  % max number of iterations for fitting, also used for maximum number of function evaluations(MaxFunEvals)
tolFun = 1e-12;  % function tolerance for fitting
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

% compare_glm_to_iz(cellType,fid,softRect,jitter)

