function [ powerFeatures ] = sinPowEEGpro( Original,channel,start,finish )
%sinPowEEGpro  求取单个通道各节律平均功率
%   Original  原始信号
%   channel  选择通道
%   start  信号开始的采样点
%   finish  信号结束的采样点
%   powerFeatures  某个通道的各节律平均功率数组
    [~,~,~,~,~,zcy0ed]=movBaseline(Original,channel,500,start,finish);
    [~,~,~,~,zcy0edFil,~]=movFundFrecy(zcy0ed,50,500,0.98);
    [~,~,powerFeatures] = powerSort( zcy0edFil,500 );
end

