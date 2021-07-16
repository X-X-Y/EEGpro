function [ y,t,f,Originaled,Foriginaled,movOriginaledBline   ] = movBaseline( Original,channel,fs,start,finish )
%movBaseline  函数用于提取原始信号的某个通道一段采样点数据，返回提取后的数据及其单边功率谱，并对其做去除基线处理，返回时域信号
%   Original  原始信号
%   channel  原始信号采集通道
%   fs  原始信号采样频率
%   start  原始信号开始的采样点
%   finish  原始信号结束的采样点
%   t  时间矢量
%   f  单边频率矢量
%   Originaled  原始信号截取后的一段时域信号
%   Foriginaled  Originaled的单边功率谱
%   y  拟合基线
%   movOriginaledBline  Originaled去除基线后的时域信号
    T=1/fs;     %采样周期
    L=finish-start;   %信号长度
    t=(0:L-1)*T;   %时间矢量
    Originaled=Original(channel,start+1:finish);    %获取通道channel中start:finish采样点数据
    Fori=fft(Originaled);    %原始信号做傅里叶变换
    P2FOriginaled=Fori/L.*conj(Fori)/L;      %双边功率谱
    Foriginaled=P2FOriginaled(1:L/2+1);     %单边功率谱
    Foriginaled(2:end-1)=2*Foriginaled(2:end-1);    %P1(1)是直流分量
    f=fs*(0:(L/2))/L;     %单边频率矢量
    [p,~,mu] = polyfit(t,Originaled,4);   %获得4次多项式系数向量p
    y=polyval(p,t,[],mu);   %拟合基线
    movOriginaledBline=Originaled-y;  %去除基线后信号
end

