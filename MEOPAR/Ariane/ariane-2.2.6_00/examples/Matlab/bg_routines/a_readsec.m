%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Read values in the Ariane file sections.txt %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Comment
disp(sprintf('\n'));
disp('Reading Ariane file section.txt');

% First step: open file to count the number of line
fid=fopen('sections.txt','r');

nb_sec=0;

while 1
  tline = fgetl(fid);
  if ~ischar(tline)
    break
  else 
   nb_sec = nb_sec + 1;
  end
end
fclose(fid);

% Second step: open again file to read data
% Support white space in section name
fid=fopen('sections.txt','r');

segname='';

for is = 1:nb_sec,
  segind(is)=fscanf(fid,'%d',1);
  i10=fscanf(fid,'%d',1);
  i1(is)=abs(i10);
  i20=fscanf(fid,'%d',1);
  i2(is)=abs(i20);
  j10=fscanf(fid,'%d',1);
  j1(is)=abs(j10);
  j20=fscanf(fid,'%d',1);
  j2(is)=abs(j20);
  k10=fscanf(fid,'%d',1);
  k20=fscanf(fid,'%d',1);
  sname=fscanf(fid,'%s',1);
  while ~strcmp(sname(size(sname,2)),'"')
    str=fscanf(fid,'%s',1);
    sname=strcat(sname,str);
  end
  segname=strvcat(segname,sname);
  if i10 < 0 | j10 < 0
    segor(is) = -1;
  end
  disp(sprintf('%i %i %i %i %i %i %i %s',segind(is),i1(is),i2(is),j1(is),j2(is),k10,k20,sname));

end

fclose(fid);

% Read grid parameters and data if need
if ~exist('imt_reg_start')
  a_ncreadgrid;
end

if (iperio == 1) & (imt_reg_end < imt_reg_start)
  i1_reg=i1-(imt_reg_start)+1;
  i2_reg=i2-(imt_reg_start)+1;
else
  i1_reg=i1-imt_reg_start+1;
  i2_reg=i2-imt_reg_start+1;
end

j1_reg=j1-jmt_reg_start+1;
j2_reg=j2-jmt_reg_start+1;
