%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Plot the land mask on a map %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% N. Grima 2007 %%
%%%%%%%%%%%%%%%%%%%

addpath(genpath(fullfile(pwd,'bg_routines')));

if ~exist('xt_reg')
  a_ncreadgrid;
end

if ~exist('flag_projection')
  a_projection;
end

if ~exist('land_mask.mat','file') & ~exist('a_no_save_mask')
  disp(' ');
  disp('Is creating a high resolution land mask... please wait');
  disp('(If it is to long please submit again with a_no_save_mask=1)');
  m_gshhs_f('save','land_mask');
end

if exist('land_mask.mat','file')
  m_usercoast('land_mask.mat','patch',[0.7 0.7 0.7],...
              'edgecolor','k');
  m_grid('box','fancy');
else
  m_coast('patch',[0.7 0.7 0.7],'edgecolor','k');
  m_grid('box','fancy');
end

