function [ H,W,t,f,movfundFrecy,FmovfundFrecy ] = movFundFrecy( inSignal,f0,fs,k )
%movFundFrecy  IIR陷波器去除工频干扰
%   inSignal  输入信号
%   f0  工频
%   fs  采样频率
%   K调节参数
%   H  复频响应矢量
%   W  频率向量
%   t  时间矢量
%   f  单侧频率矢量
%   movfundFrecy  去工频后时域信号
%   FmovfundFrecy  去工频后信号的幅功率谱
    T=1/fs;     %采样周期
    L=length(inSignal);   %信号长度
    t=(0:L-1)*T;   %时间矢量
    f=fs*(0:(L/2))/L;     %单侧频率矢量
    w0=2*pi*f0/fs;             %角频率
    B=[1 -2*cos(w0) 1];        %系统传递函数分子
    A=[1 -2*k*cos(w0) k*k];    %系统传递函数分母
    [H,W]=freqz(B,A);          %H为幅频响应矢量，W为频率矢量
    movfundFrecy=filter(B,A,inSignal);    %去工频
    FmovfundFrecy=fft(movfundFrecy);    %去基线去工频后信号傅里叶变换
    P2FmovfundFrecy=FmovfundFrecy/L.*conj(FmovfundFrecy)/L;      %双侧功率谱
    FmovfundFrecy=P2FmovfundFrecy(1:L/2+1);     %单侧功率谱
    FmovfundFrecy(2:end-1)=2*FmovfundFrecy(2:end-1);    %P1(1)是直流分量
end

