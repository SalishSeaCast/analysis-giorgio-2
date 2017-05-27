%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Read global attributes which correspond to namelist parameters
% in the Ariane NetCDF outputs.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
nbga = 1;

disp(sprintf('\n'));
disp('Reading Global attributes in Ariane output file:')
if exist('ariane_trajectories_qualitative.nc')
  disp('    - ariane_trajectories_qualitative.nc')
  nc = netcdf('ariane_trajectories_qualitative.nc');
elseif exist('ariane_statistics_quantitative.nc')
  disp('    - ariane_statistics_quantitative.nc')
  nc = netcdf('ariane_statistics_quantitative.nc');
else
  disp('ERROR: no correct Ariane NetCDF input file.');
  disp('    - ariane_trajectories_qualitative.nc');
  disp('or  - ariane_statistics_quantitative.nc');
  stop;
end

key_roms              = nc.key_roms(:);
key_symphonie         = nc.key_symphonie(:);
key_sequential        = nc.key_sequential(:);
key_alltracers        = nc.key_alltracers(:);
key_ascii_outputs     = nc.key_ascii_outputs(:);
key_read_age          = nc.key_read_age(:);
mode                  = nc.mode(:);
forback               = nc.forback(:);
bin                   = nc.bin(:);
init_final            = nc.init_final(:);
nmax                  = nc.nmax(:);
tunit                 = nc.tunit(:);
ntfic                 = nc.ntfic(:);
tcyc                  = nc.tcyc(:);
key_approximatesigma  = nc.key_approximatesigma(:);
key_computesigma      = nc.key_computesigma(:);
zsigma                = nc.zsigma(:);

if strcmp(key_sequential,'.TRUE.')
  key_interp_temporal = nc.key_interp_temporal(:);
  maxcycles           = nc.maxcycles(:);
end

if strcmp(mode,'qualitative')
  delta_t             = nc.delta_t(:);
  frequency           = nc.frequency(:);
  nb_output           = nc.nb_output(:);
  mask                = nc.mask(:);
  key_region          = nc.key_region(:);
  %% To correct a bug in Ariane
  if isempty(key_region)
    key_region          = nc.k_region(:);
  end
  if strcmp(key_region,'.TRUE.')
    imt_reg_start     = nc.imt_reg_start(:);
    imt_reg_end       = nc.imt_reg_end(:);
    imt_reg           = nc.imt_reg(:);
    jmt_reg_start     = nc.jmt_reg_start(:);
    jmt_reg_end       = nc.jmt_reg_end(:);
    jmt_reg           = nc.jmt_reg(:);
    kmt_reg_start     = nc.kmt_reg_start(:);
    kmt_reg_end       = nc.kmt_reg_end(:);
    kmt_reg           = nc.kmt_reg(:);
  end
else
  key_2dquant         = nc.key_2dquant(:);
  key_eco             = nc.key_eco(:);
  key_reducmem        = nc.key_reducmem(:);
  if strcmp( key_reducmem(size(key_reducmem,2)-1:size(key_reducmem,2)),'\0')
    key_reducmem = key_reducmem(1:size(key_reducmem,2)-2);
  end
  if strcmp(key_reducmem,'.TRUE.')
    imt_reg_start     = nc.imt_reg_start(:);
    imt_reg_end       = nc.imt_reg_end(:);
    imt_reg           = nc.imt_reg(:);
    jmt_reg_start     = nc.jmt_reg_start(:);
    jmt_reg_end       = nc.jmt_reg_end(:);
    jmt_reg           = nc.jmt_reg(:);
    kmt_reg_start     = nc.kmt_reg_start(:);
    kmt_reg_end       = nc.kmt_reg_end(:);
    kmt_reg           = nc.kmt_reg(:);
  end
  key_unitm3          = nc.key_unitm3(:);
  key_nointerpolstats = nc.key_nointerpolstats(:);
  max_transport       = nc.max_transport(:);
  lmin                = nc.lmin(:);
  lmax                = nc.lmax(:);
end


% Zonal current file(s)
c_dir_zo         = nc.c_dir_zo(:);
c_prefix_zo      = nc.c_prefix_zo(:);
ind0_zo          = nc.ind0_zo(:);
indn_zo          = nc.indn_zo(:);
maxsize_zo       = nc.maxsize_zo(:);
c_suffix_zo      = nc.c_suffix_zo(:);
nc_var_zo        = nc.nc_var_zo(:);
nc_var_eivu      = nc.nc_var_eivu(:);
nc_att_mask_zo   = nc.nc_att_mask_zo(:);

% Meridional current file(s)
c_dir_me         = nc.c_dir_me(:);
c_prefix_me      = nc.c_prefix_me(:);
ind0_me          = nc.ind0_me(:);
indn_me          = nc.indn_me(:);
maxsize_me       = nc.maxsize_me(:);
c_suffix_me      = nc.c_suffix_me(:);
nc_var_me        = nc.nc_var_me(:);
nc_var_eivv      = nc.nc_var_eivv(:);
nc_att_mask_me   = nc.nc_att_mask_me(:);


if exist('key_computew')
  if strcmp(key_computew,'.FALSE.')
    c_dir_ve       = nc.c_dir_ve(:);
    c_prefix_ve    = nc.c_prefix_ve(:);
    ind0_ve        = nc.ind0_ve(:);
    indn_ve        = nc.indn_ve(:);
    maxsize_ve     = nc.maxsize_ve(:);
    c_suffix_ve    = nc.c_suffix_ve(:);
    nc_var_ve      = nc.nc_var_ve(:);
    nc_var_eivw    = nc.nc_var_eivw(:);
    nc_att_mask_ve = nc.nc_att_mask_ve(:);
  end
end


if strcmp(key_alltracers,'.TRUE.')
  % Temperature file(s)
  c_dir_te       = nc.c_dir_te(:);
  c_prefix_te    = nc.c_prefix_te(:);
  ind0_te        = nc.ind0_te(:);
  indn_te        = nc.indn_te(:);
  maxsize_te     = nc.maxsize_te(:);
  c_suffix_te    = nc.c_suffix_te(:);
  nc_var_te      = nc.nc_var_te(:);
  nc_att_mask_te = nc.nc_att_mask_te(:);

  % Salinity file(s)
  c_dir_sa       = nc.c_dir_sa(:);
  c_prefix_sa    = nc.c_prefix_sa(:);
  ind0_sa        = nc.ind0_sa(:);
  indn_sa        = nc.indn_sa(:);
  maxsize_sa     = nc.maxsize_sa(:);
  c_suffix_sa    = nc.c_suffix_sa(:);
  nc_var_sa      = nc.nc_var_sa(:);
  nc_att_mask_sa = nc.nc_att_mask_sa(:);


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

if strcmp(key_roms,'.TRUE.')
  disp('    - results computed with ROMS data')
  a_ncga_roms;
elseif strcmp(key_symphonie,'.TRUE.')
  disp('    - results computed with SYMPHONIE data')
  a_ncga_symphonie;  
else
  disp('    - results computed with OPA data')
  a_ncga_opa;
end

clear nc;

disp('Reading is done.')
