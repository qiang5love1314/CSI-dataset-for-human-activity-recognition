
function [abs_RX1_amp_interp, abs_RX2_amp_interp, abs_RX3_amp_interp] = extract_amp_interp(TX_ant, data_file, values)
% data_file = 'occupancy_model_verification/data/perp_2_5m5t1_sh_5s_2.dat' ;
[amp_RX1_ant_sq, amp_RX2_ant_sq, amp_RX3_ant_sq] = extract_CSI_from_TX_antenna(TX_ant, data_file, values);%提取CSI，三个接收天线对应三个矩阵

num_elements = numel(num2str(size(amp_RX1_ant_sq,2)));%提取1接收天线的包个数，amp_RX1_ant_sq为30*9940（发了10000个，收到9940个）

% e.g.:  num_elements = 5, size(amp_RX1_ant_sq,2) = 58999, 
% interp_val = ceil(58999/10^4)*10^4
    interp_val = ceil(size(amp_RX1_ant_sq,2)/10^(num_elements-1))*10^(num_elements-1);%interp_val=10000

abs_RX1_amp = abs(amp_RX1_ant_sq);%求csi振幅值
abs_RX2_amp = abs(amp_RX2_ant_sq);
abs_RX3_amp = abs(amp_RX3_ant_sq);
abs_RX1_amp_interp = zeros(30,interp_val);
abs_RX2_amp_interp = zeros(30,interp_val);
abs_RX3_amp_interp = zeros(30,interp_val);

%30个子载波，通过插值来补全丢包
for i = 1:30
    abs_RX1_amp_interp(i,:) = interp1( abs_RX1_amp(i,:)',1:(size(abs_RX1_amp,2)-1)/(interp_val-1):size(abs_RX1_amp,2));%figure;mesh(Hs_f_interp);
    abs_RX2_amp_interp(i,:) = interp1( abs_RX2_amp(i,:)',1:(size(abs_RX2_amp,2)-1)/(interp_val-1):size(abs_RX2_amp,2));%figure;mesh(Hs_f_interp);
    abs_RX3_amp_interp(i,:) = interp1( abs_RX3_amp(i,:)',1:(size(abs_RX3_amp,2)-1)/(interp_val-1):size(abs_RX3_amp,2));%figure;mesh(Hs_f_interp);
end



