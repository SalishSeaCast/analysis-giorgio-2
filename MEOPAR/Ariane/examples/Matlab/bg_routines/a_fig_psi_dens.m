%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% You can set "min_transport" %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

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

figure;
hold on;

a_projection;

%% Fill density field
max_dens=-100.;
min_dens= 100.;

  %%%%%%%%%%
  %% ROMS %%
  %%%%%%%%%%
  if strcmp(key_roms,'.TRUE.')
  %%%%%%%
  %-- V --
  %%%%%%%

    for ix = 1:imt_reg-1
     for jy = 1:jmt_reg-1

        dens_v=sq_xy_rvh_msk(ix+1,jy)/sq_xy_vh_msk(ix+1,jy);

        if ((dens_v ~= NaN) && (sq_xy_vh_msk(ix+1,jy) >= min_transport))

          if( dens_v > max_dens)
            max_dens=dens_v;
          end

          if( dens_v < min_dens)
            min_dens=dens_v;
          end

          Xpt=[xp_reg_msk(ix,jy) xt_reg_msk(ix+1,jy+1) xp_reg_msk(ix+1,jy) xt_reg_msk(ix+1,jy)];
          Ypt=[yp_reg_msk(ix,jy) yt_reg_msk(ix+1,jy+1) yp_reg_msk(ix+1,jy) yt_reg_msk(ix+1,jy)];
  
          [m_X,m_Y]=m_ll2xy(Xpt,Ypt);

          fill(m_X,m_Y,dens_v,'EdgeColor','none');
        end
      end
    end

   %%%%%%%
   %-- U --
   %%%%%%%
   for ix = 1:imt_reg-1
      for jy = 1:jmt_reg-1

        dens_u=sq_xy_ruh_msk(ix,jy+1)/sq_xy_uh_msk(ix,jy+1);

        if ((dens_u ~= NaN) && (sq_xy_uh_msk(ix,jy+1) >= min_transport))

          if( dens_u > max_dens)
            max_dens=dens_u;
          end

          if( dens_u < min_dens)
            min_dens=dens_u;
          end

          Xpt=[xt_reg_msk(ix,jy+1) xp_reg_msk(ix,jy+1) ...
               xt_reg_msk(ix+1,jy+1) xp_reg_msk(ix,jy)];

          Ypt=[yt_reg_msk(ix,jy+1) yp_reg_msk(ix,jy+1) ...
               yt_reg_msk(ix+1,jy+1) yp_reg_msk(ix,jy)];

          [m_X,m_Y]=m_ll2xy(Xpt,Ypt);

          fill(m_X,m_Y,dens_u,'EdgeColor','none');
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

    for ix = 1:imt_reg-1
     for jy = 1:jmt_reg-1

        dens_v=sq_xy_rvh_msk(ix,jy+1)/sq_xy_vh_msk(ix,jy+1);

        if (dens_v ~= NaN)

          if( dens_v > max_dens)
            max_dens=dens_v;
          end

          if( dens_v < min_dens)
            min_dens=dens_v;
          end

          Xpt=[xp_reg_msk(ix,jy+1) xt_reg_msk(ix,jy+1) ...
	       xp_reg_msk(ix+1,jy+1) xt_reg_msk(ix,jy)];

          Ypt=[yp_reg_msk(ix,jy+1) yt_reg_msk(ix,jy+1) ...
               yp_reg_msk(ix+1,jy+1) yt_reg_msk(ix,jy)];
  
          [m_X,m_Y]=m_ll2xy(Xpt,Ypt);

          fill(m_X,m_Y,dens_v,'EdgeColor','none');
        end
      end
    end

   %%%%%%%
   %-- U --
   %%%%%%%
   for ix = 1:imt_reg-1
      for jy = 1:jmt_reg-1

        dens_u=sq_xy_ruh_msk(ix+1,jy)/sq_xy_uh_msk(ix+1,jy);

        if (dens_u ~= NaN)

          if( dens_u > max_dens)
            max_dens=dens_u;
          end

          if( dens_u < min_dens)
            min_dens=dens_u;
          end

          Xpt=[xt_reg_msk(ix,jy) xp_reg_msk(ix+1,jy+1) ...
               xt_reg_msk(ix+1,jy) xp_reg_msk(ix+1,jy)];

          Ypt=[yt_reg_msk(ix,jy) yp_reg_msk(ix+1,jy+1) ...
               yt_reg_msk(ix+1,jy) yp_reg_msk(ix+1,jy)];

          [m_X,m_Y]=m_ll2xy(Xpt,Ypt);

          fill(m_X,m_Y,dens_u,'EdgeColor','none');
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

        dens_v=sq_xy_rvh_msk(ix,jy)/sq_xy_vh_msk(ix,jy);

        if ((dens_v ~= NaN) && (sq_xy_vh_msk(ix,jy) >= min_transport))

          if( dens_v > max_dens)
            max_dens=dens_v;
          end

          if( dens_v < min_dens)
            min_dens=dens_v;
          end

          Xpt=[xp_reg_msk(ix-1,jy) xt_reg_msk(ix,jy+1)...
	       xp_reg_msk(ix  ,jy) xt_reg_msk(ix,jy)];

          Ypt=[yp_reg_msk(ix-1,jy) yt_reg_msk(ix,jy+1)...
               yp_reg_msk(ix  ,jy) yt_reg_msk(ix,jy)];
  
          [m_X,m_Y]=m_ll2xy(Xpt,Ypt);

          fill(m_X,m_Y,dens_v,'EdgeColor','none');
        end
      end
    end

   %%%%%%%%%
   %-- U --%
   %%%%%%%%%
   for jy = 2:jmt_reg 
      for ix = 1:imt_reg-1

        dens_u=sq_xy_ruh_msk(ix,jy)/sq_xy_uh_msk(ix,jy);

        if ((dens_u ~= NaN) && (sq_xy_uh_msk(ix,jy) >= min_transport))

          if( dens_u > max_dens)
            max_dens=dens_u;
          end

          if( dens_u < min_dens)
            min_dens=dens_u;
          end

          Xpt=[xt_reg_msk(ix  ,jy) xp_reg_msk(ix,jy) ...
               xt_reg_msk(ix+1,jy) xp_reg_msk(ix,jy-1)];

          Ypt=[yt_reg_msk(ix  ,jy) yp_reg_msk(ix,jy) ...
               yt_reg_msk(ix+1,jy) yp_reg_msk(ix,jy-1)];

          [m_X,m_Y]=m_ll2xy(Xpt,Ypt);

          fill(m_X,m_Y,dens_u,'EdgeColor','none');
        end
      end
    end

  end

  %% Set the color bar
  set(gca,'CLim',[min_dens max_dens]);
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

    [cn,hn]=m_contour(xp_reg,yp_reg,squeeze(psi(:,:)),levels_neg,'Visible', 'on',...
              'showtext','on','LineWidth',1.2,'LineStyle','--','LineColor','k');

    [cp,hp]=m_contour(xp_reg,yp_reg,squeeze(psi(:,:)),levels_pos,'Visible', 'on',...
              'showtext','on','LineWidth',1.2,'LineColor','k');

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
    title({'PSI \rm(in Sv) and Density',[a_title]},...
    'FontWeight','bold','FontSize',14);
  else
    title('PSI \rm(in Sv) and Density','FontWeight','bold','FontSize',14);
  end
  xlabel('longitudes','FontWeight','bold','FontSize',12);
  ylabel('latitudes','FontWeight','bold','FontSize',12);

  %% Save fig in jpeg format
  %% print -dtiff psi_dens.tiff
  %% print -djpeg psi_dens.jpeg

  fig_fn=strcat('psi_dens_',num2str(i_loop),'.tif')
  print('-dtiff',fig_fn)
  
%%  fig_fn=strcat('psi_dens_',num2str(i_loop),'.jpeg')
%%  print('-djpeg',fig_fn)


