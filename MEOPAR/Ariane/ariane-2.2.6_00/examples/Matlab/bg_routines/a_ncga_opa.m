%% a_ncga_opa.M - Read in Ariane file the namelist values
%% record as global attributes
%-----------------------------------------------------
% Nicolas.Grima@univ-brest.fr
% 2009 July
%-----------------------------------------------------

imt             = nc.imt(:);
jmt             = nc.jmt(:);
kmt             = nc.kmt(:);
lmt             = nc.lmt(:);

key_computew    = nc.key_computew(:);
key_partialstep = nc.key_partialstep(:);

key_jfold       = nc.key_jfold(:);
if strcmp(key_jfold,'.TRUE.')
  jperio = 1;
else
  jperio = 0;
end

pivot = nc.pivot(:);
key_periodic     = nc.key_periodic(:);
if strcmp(key_periodic,'.TRUE.')
  iperio = 1;
else
  iperio = 0;
end

%% OLD OLD OLD OLD OLD OLD
%% Old global attributs %%
key_sigma        = nc.key_sigma(:);
zsigma           = nc.zsigma(:);

if strcmp(key_alltracers,'.TRUE.')
  if strcmp(key_computesigma,'.FALSE.')
    % Density file(s)
    c_dir_de       = nc.c_dir_de(:);
    c_prefix_de    = nc.c_prefix_de(:);
    ind0_de        = nc.ind0_de(:);
    indn_de        = nc.indn_de(:);
    maxsize_de     = nc.maxsize_de(:);
    c_suffix_de    = nc.c_suffix_de(:);
    nc_var_de      = nc.nc_var_de(:);
    nc_att_mask_de = nc.nc_att_mask_de(:);
  end
end
%% OLD OLD OLD OLD 0LD 

if strcmp(mode,'qualitative')
  if strcmp(key_region,'.FALSE.')
    imt_reg_start     = 1;
    imt_reg_end       = imt;
    imt_reg           = imt;
    jmt_reg_start     = 1;
    jmt_reg_end       = jmt;
    jmt_reg           = jmt;
    kmt_reg_start     = 1;
    kmt_reg_end       = kmt;
    kmt_reg           = kmt;
  end
else
  if strcmp(key_reducmem,'.FALSE.')
    imt_reg_start     = 1;
    imt_reg_end       = imt;
    imt_reg           = imt;
    jmt_reg_start     = 1;
    jmt_reg_end       = jmt;
    jmt_reg           = jmt;
    kmt_reg_start     = 1;
    kmt_reg_end       = kmt;
    kmt_reg           = kmt;
  end
end

% ORCA grid file and variable names
dir_mesh           = nc.dir_mesh(:);
if strcmp( dir_mesh(size(dir_mesh,2)-1:size(dir_mesh,2)),'\0')
  dir_mesh = dir_mesh(1:size(dir_mesh,2)-2);
end

fn_mesh      = nc.fn_mesh(:);
nc_var_xx_tt = nc.nc_var_xx_tt(:);
nc_var_xx_uu = nc.nc_var_xx_uu(:);
nc_var_zz_ww = nc.nc_var_zz_ww(:);
nc_var_e2u   = nc.nc_var_e2u(:);
nc_var_e1v   = nc.nc_var_e1v(:);
nc_var_e1t   = nc.nc_var_e1t(:);
nc_var_e2t   = nc.nc_var_e2t(:);
nc_var_e3t   = nc.nc_var_e3t(:);
nc_var_tmask = nc.nc_var_tmask(:);
nc_mask_val  = nc.nc_mask_val(:);
