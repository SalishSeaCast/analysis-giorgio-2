%% Read NetCDF OPA/NEMO grid.
%----------------------------
% Read:
% - longitude in T, U, V and F
% - latitude  in T, U, V and F
% - mask in T
%--------------------------------------------------------------------------
% Nicolas.Grima@univ-brest.fr
% 2009 July
%--------------------------------------------------------------------------

if strcmp(nc_var_xx_tt,'glamt') & strcmp(nc_var_xx_uu,'glamu')
  nc_var_xx_vv='glamv';
  nc_var_xx_ff='glamf';
  nc_var_yy_tt='gphit';
  nc_var_yy_uu='gphiu';
  nc_var_yy_vv='gphiv';
  nc_var_yy_ff='gphif';
elseif strcmp(nc_var_xx_tt,'xt') & strcmp(nc_var_xx_uu,'xu')
  nc_var_xx_vv='xv';
  nc_var_xx_ff='xf';
  nc_var_yy_tt='yt';
  nc_var_yy_uu='yu';
  nc_var_yy_vv='yv';
  nc_var_yy_ff='yf';
elseif strcmp(nc_var_xx_tt,'p_lon') & strcmp(nc_var_xx_uu,'u_lon')
  nc_var_xx_vv='v_lon';
  nc_var_xx_ff='p_lon';
  nc_var_yy_tt='p_lat';
  nc_var_yy_uu='u_lat';
  nc_var_yy_vv='v_lat';
  nc_var_yy_ff='p_lat';
else
  disp(' ');
disp('The Ariane Matlab package doesn t know how to read grid coordinates.');
disp('Please edit bg_routines/a_ncrg_opa.m to set your coordinate data names.');
  disp(' ');
  stop
end

ncload([dir_mesh '/' fn_mesh],...
        nc_var_xx_tt,...
        nc_var_xx_uu,...
        nc_var_xx_vv,...
        nc_var_xx_ff,...
        nc_var_yy_tt,...
        nc_var_yy_uu,...
        nc_var_yy_vv,...
        nc_var_yy_ff);

xt=eval(nc_var_xx_tt)';
xu=eval(nc_var_xx_uu)';
xv=eval(nc_var_xx_vv)';
xp=eval(nc_var_xx_ff)';
yt=eval(nc_var_yy_tt)';
yu=eval(nc_var_yy_uu)';
yv=eval(nc_var_yy_vv)';
yp=eval(nc_var_yy_ff)';

%% Delete data which will be not used 
%------------------------------------
clear eval(nc_var_xx_tt);
clear eval(nc_var_xx_uu);
clear eval(nc_var_xx_vv);
clear eval(nc_var_xx_ff);
clear eval(nc_var_yy_tt);
clear eval(nc_var_yy_uu);
clear eval(nc_var_yy_vv);
clear eval(nc_var_yy_ff);


if exist('ariane_statistics_quantitative.nc')

  if verLessThan('matlab', '7.7.0.471')
    ncload('ariane_statistics_quantitative.nc',...
  	   'tmask');
    tmask_reg = squeeze(tmask(1,:,:))'; %'
  else
    disp('Reading tmask in the ariane_statistics_quantitative.nc file');

    % Open ariane file.
    % ncid = netcdf.open('ariane_statistics_quantitative.nc','NC_NOWRITE');

    % Get variable ID of tmask.
    % varid = netcdf.inqVarID(ncid,'tmask');

    % Get the value of tmask.
    % tmask_reg = netcdf.getVar(ncid,varid);

    ncload('ariane_statistics_quantitative.nc','tmask');
    tmask_reg = squeeze(tmask(1,:,:))'; %'
  end

else

  disp('Reading tmask in the meshmask file');

  if verLessThan('matlab', '7.7.0.471')

    ncload([dir_mesh '/' fn_mesh],...
 	   nc_var_tmask);
    tmask = squeeze(eval([nc_var_tmask,'(1,:,:)']))'; %'

  else

    % Open ariane file.
    ncid = netcdf.open([dir_mesh '/' fn_mesh],'NC_NOWRITE');

    % Get variable ID of tmask.
    varid = netcdf.inqVarID(ncid,'tmask');
  
    % Inquire variable
    [varname,xtype,dimids,natts] = netcdf.inqVar(ncid,varid);
  

    % Get the value of tmask.
    if (length(dimids) == 4) 
      tmask = netcdf.getVar(ncid,varid,...
		          [0 0 0 0],[size(xt,1) size(xt,2) 1 1]);
    else
      tmask = netcdf.getVar(ncid,varid,...
		          [0 0 0],[size(xt,1)-1 size(xt,2)-1 1]);
      tmask = tmask'; %'
    end
  end          
  
end
