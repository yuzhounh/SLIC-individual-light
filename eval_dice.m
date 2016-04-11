function dice=eval_dice(method,sub1,sub2,iK)
% Dice
% 2015-9-2 10:15:24

%     Parcellating whole brain for individuals by simple linear iterative clustering
%     Copyright (C) 2016 Jing Wang
%
%     This program is free software: you can redistribute it and/or modify
%     it under the terms of the GNU General Public License as published by
%     the Free Software Foundation, either version 3 of the License, or
%     (at your option) any later version.
%
%     This program is distributed in the hope that it will be useful,
%     but WITHOUT ANY WARRANTY; without even the implied warranty of
%     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%     GNU General Public License for more details.
%
%     You should have received a copy of the GNU General Public License
%     along with this program.  If not, see <http://www.gnu.org/licenses/>.

load parc_graymatter.mat;
nM=num_gray;
 
load sK.mat;
cK=sK(iK);
 
load(sprintf( '%s_sub_parc/sub%05d_K%d.mat',method,sub1,cK));
A=img_parc(msk_gray);
 
load(sprintf( '%s_sub_parc/sub%05d_K%d.mat',method,sub2,cK));
B=img_parc(msk_gray);
 
SA=0;
SB=0;
SC=0;
tic;
for i=1:nM
    for j=1:nM
        if A(i)==A(j)
            SA=SA+1;
        end
       
        if B(i)==B(j)
            SB=SB+1;
        end
       
        if A(i)==A(j) && B(i)==B(j)
            SC=SC+1;
        end
    end
    perct(toc,i,nM,10);
end
 
% Dice's coefficient
dice=(2*SC-2*nM)/(SA+SB-2*nM);
