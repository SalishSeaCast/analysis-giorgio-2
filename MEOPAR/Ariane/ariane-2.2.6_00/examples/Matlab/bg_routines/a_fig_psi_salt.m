%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% You can set "a_cstep" to specify the LevelStep contour %%
%% You can set "a_title" to add a comment in the title    %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

disp(' ');
disp('---');
disp('--- Please wait, it could take a long time to plot ---');
disp('---');
disp(' ');

if ~exist('psi')
  a_xy0;
end

%% Minimum transport
if ~exist('min_transport')
   min_transport=0.;
end

%% change dimension SV in m3/s
if (min_transport < 100.)
  min_transport = min_transport * 1.e6;
end

%%colormap('hot');


figid=figure;
hold on;

%% Initialize the map projection. 
%% This first step is needed to use m_map routines.
a_projection;

%% Fill salinity field
max_salt=0.;
min_salt=100.;

%%%%%%%%%%
%% ROMS %%
%%%%%%%%%%
if strcmp(key_roms,'.TRUE.')
%%%%%%%
%-- V --
%%%%%%%

  for jy = 1:jmt_reg-1
   for ix = 1:imt_reg-1

      salt_v=sq_xy_svh_msk(ix+1,jy)/sq_xy_vh_msk(ix+1,jy);

      if ((salt_v ~= NaN) && (sq_xy_vh_msk(ix+1,jy) >= min_transport))

        if( salt_v > max_salt)
          max_salt=salt_v;
        end

        if( salt_v < min_salt)
          min_salt=salt_v;
        end

        Xpt=[xp_reg_msk(ix,jy) xt_reg_msk(ix+1,jy+1) ...
             xp_reg_msk(ix+1,jy) xt_reg_msk(ix+1,jy)];

        Ypt=[yp_reg_msk(ix,jy) yt_reg_msk(ix+1,jy+1) ...
             yp_reg_msk(ix+1,jy) yt_reg_msk(ix+1,jy)];
  
        [m_X,m_Y]=m_ll2xy(Xpt,Ypt);

        fill(m_X,m_Y,salt_v,'EdgeColor','none');
      end
    end
  end

 %%%%%%%
 %-- U --
 %%%%%%%
 for jy = 1:jmt_reg-1 
    for ix = 1:imt_reg-1

      salt_u=sq_xy_suh_msk(ix,jy+1)/sq_xy_uh_msk(ix,jy+1);

      if ((salt_u ~= NaN) && (sq_xy_uh_msk(ix,jy+1) >= min_transport))

        if( salt_u > max_salt)
          max_salt=salt_u;
        end

        if( salt_u < min_salt)
          min_salt=salt_u;
        end

        Xpt=[xt_reg_msk(ix,jy+1) xp_reg_msk(ix,jy+1) ...
             xt_reg_msk(ix+1,jy+1) xp_reg_msk(ix,jy)];
        Ypt=[yt_reg_msk(ix,jy+1) yp_reg_msk(ix,jy+1) ...
             yt_reg_msk(ix+1,jy+1) yp_reg_msk(ix,jy)];

        [m_X,m_Y]=m_ll2xy(Xpt,Ypt);

        fill(m_X,m_Y,salt_u,'EdgeColor','none');
      end
    end
  end

%%%%%%%%%%%%%%%
%% SYMPHONIE %%
%%%%%%%%%%%%%%%
  elseif strcmp(key_symphonie,'.TRUE.')
  %%%%%%%
  %-- V --
  %%%%%%%

    for jy = 1:jmt_reg-1
     for ix = 1:imt_reg-1

        salt_v=sq_xy_svh_msk(ix,jy+1)/sq_xy_vh_msk(ix,jy+1);

        if (salt_v ~= NaN)

          if( salt_v > max_salt)
            max_salt=salt_v;
          end

          if( salt_v < min_salt)
            min_salt=salt_v;
          end

          Xpt=[xp_reg_msk(ix  ,jy+1) xt_reg_msk(ix,jy+1) ...
               xp_reg_msk(ix+1,jy+1) xt_reg_msk(ix,jy)];

          Ypt=[yp_reg_msk(ix  ,jy+1) yt_reg_msk(ix,jy+1) ...
               yp_reg_msk(ix+1,jy+1) yt_reg_msk(ix,jy)];
  
          [m_X,m_Y]=m_ll2xy(Xpt,Ypt);

          fill(m_X,m_Y,salt_v,'EdgeColor','none');
        end
      end
    end

   %%%%%%%
   %-- U --
   %%%%%%%
   for jy = 1:jmt_reg-1
      for ix = 1:imt_reg-1

        salt_u=sq_xy_suh_msk(ix+1,jy)/sq_xy_uh_msk(ix+1,jy);

        if (salt_u ~= NaN)

          if( salt_u > max_salt)
            max_salt=salt_u;
          end

          if( salt_u < min_salt)
            min_salt=salt_u;
          end

          Xpt=[xt_reg_msk(ix,jy) xp_reg_msk(ix+1,jy+1) xt_reg_msk(ix+1,jy) xp_reg_msk(ix+1,jy)];
          Ypt=[yt_reg_msk(ix,jy) yp_reg_msk(ix+1,jy+1) yt_reg_msk(ix+1,jy) yp_reg_msk(ix+1,jy)];

          [m_X,m_Y]=m_ll2xy(Xpt,Ypt);

          fill(m_X,m_Y,salt_u,'EdgeColor','none');
        end
      end
    end
  %%%%%%%%%
  %% OPA %%
  %%%%%%%%%
  else

  %%%%%%%%%
  %-- V --%
  %%%%%%%%%
    for jy = 1:jmt_reg-1
     for ix = 2:imt_reg

        salt_v=sq_xy_svh_msk(ix,jy)/sq_xy_vh_msk(ix,jy);

        if ((salt_v ~= NaN) && (sq_xy_vh_msk(ix,jy) >= min_transport))

          if( salt_v > max_salt)
            max_salt=salt_v;
          end

          if( salt_v < min_salt)
            min_salt=salt_v;
          end

          Xpt=[xp_reg_msk(ix-1,jy) xt_reg_msk(ix,jy+1)...
	       xp_reg_msk(ix  ,jy) xt_reg_msk(ix,jy)];

          Ypt=[yp_reg_msk(ix-1,jy) yt_reg_msk(ix,jy+1)...
               yp_reg_msk(ix  ,jy) yt_reg_msk(ix,jy)];
  
          [m_X,m_Y]=m_ll2xy(Xpt,Ypt);

          fill(m_X,m_Y,salt_v,'EdgeColor','none');
        end
      end
    end

   %%%%%%%%%
   %-- U --%
   %%%%%%%%%
   for jy = 2:jmt_reg 
      for ix = 1:imt_reg-1

        salt_u=sq_xy_suh_msk(ix,jy)/sq_xy_uh_msk(ix,jy);

        if ((salt_u ~= NaN) && (sq_xy_uh_msk(ix,jy) >= min_transport))

          if( salt_u > max_salt)
            max_salt=salt_u;
          end

          if( salt_u < min_salt)
            min_salt=salt_u;
          end

          Xpt=[xt_reg_msk(ix  ,jy) xp_reg_msk(ix,jy) ...
               xt_reg_msk(ix+1,jy) xp_reg_msk(ix,jy-1)];

          Ypt=[yt_reg_msk(ix  ,jy) yp_reg_msk(ix,jy) ...
               yt_reg_msk(ix+1,jy) yp_reg_msk(ix,jy-1)];

          [m_X,m_Y]=m_ll2xy(Xpt,Ypt);

          fill(m_X,m_Y,salt_u,'EdgeColor','none');
        end
      end
    end

  end

  %% Set the color bar
  set(gca,'CLim',[min_salt max_salt]);
  colorbar;

  %% Contour psi (black contour, dashed lines for negative values and solid 
  %%	       lines for positive values).
  if exist('a_cstep')
    [c,h]=m_contour(xp_reg,yp_reg,squeeze(psi(:,:)),...
              'showtext','on','LineWidth',1.2, ...
              'LevelStep', a_cstep);
  else
    [c,h]=m_contour(xp_reg,yp_reg,squeeze(psi(:,:)),'Visible', 'off',...
         'LineColor','w' );

    levels = get(h,'LevelList');

    levels_pos=levels(find(levels >= 0.));
    levels_neg=levels(find(levels < 0.));

    if (size(levels_pos) == 1)
      levels_pos=[levels_pos levels_pos];
    end

    if (size(levels_neg) == 1)
      levels_neg=[levels_neg levels_neg];
    end

    [cn,hn]=m_contour(xp_reg,yp_reg,squeeze(psi(:,:)),levels_neg,...
                      'Visible', 'on',...
                      'showtext','on',...
                      'LineWidth',1.2,...
                      'LineStyle','--',...
                      'LineColor','k');

    [cp,hp]=m_contour(xp_reg,yp_reg,squeeze(psi(:,:)),levels_pos,...
                      'Visible', 'on',...
                      'showtext','on',...
                      'LineWidth',1.2,...
                      'LineColor','k');

  end

  %% Print sections
  for is = 1:nb_sec,
    if ((i1_reg(is) > 0) && (j1_reg(is) > 0) && ...
       (i2_reg(is) > 0) && (j2_reg(is) > 0))
      m_line([xp_reg(i1_reg(is),j1_reg(is)) xp_reg(i2_reg(is),j2_reg(is))], ...
           [yp_reg(i1_reg(is),j1_reg(is)) yp_reg(i2_reg(is),j2_reg(is))], ...
           'Color','k','LineWidth',2)
    end
  end

  %% print land mask
  a_mask_land;

  %% Print psi ref = 0.
  m_text(xref_psi,yref_psi,'psi=0');

  %% Title and axe labels
  if exist('a_title')
    title({'PSI \rm(in Sv) and Salinity',[a_title]},...
    'FontWeight','bold','FontSize',14);
  else
     title('PSI \rm(in Sv) and Salinity','FontWeight','bold','FontSize',14);
  end
  xlabel('longitudes','FontWeight','bold','FontSize',12);
  ylabel('latitudes','FontWeight','bold','FontSize',12);

  %% Save fig in jpeg format
  %% print -djpeg psi_pmt.jpeg
  
  fig_fn=strcat('psi_salt_',num2str(i_loop),'.tif')
  print('-dtiff',fig_fn)
  
%%  fig_fn=strcat('psi_salt_',num2str(i_loop),'.jpeg')
%%  print('-djpeg',fig_fn)


