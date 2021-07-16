function [ H,W,t,f,movfundFrecy,FmovfundFrecy ] = movFundFrecy( inSignal,f0,fs,k )
%movFundFrecy  IIR�ݲ���ȥ����Ƶ����
%   inSignal  �����ź�
%   f0  ��Ƶ
%   fs  ����Ƶ��
%   K���ڲ���
%   H  ��Ƶ��Ӧʸ��
%   W  Ƶ������
%   t  ʱ��ʸ��
%   f  ����Ƶ��ʸ��
%   movfundFrecy  ȥ��Ƶ��ʱ���ź�
%   FmovfundFrecy  ȥ��Ƶ���źŵķ�������
    T=1/fs;     %��������
    L=length(inSignal);   %�źų���
    t=(0:L-1)*T;   %ʱ��ʸ��
    f=fs*(0:(L/2))/L;     %����Ƶ��ʸ��
    w0=2*pi*f0/fs;             %��Ƶ��
    B=[1 -2*cos(w0) 1];        %ϵͳ���ݺ�������
    A=[1 -2*k*cos(w0) k*k];    %ϵͳ���ݺ�����ĸ
    [H,W]=freqz(B,A);          %HΪ��Ƶ��Ӧʸ����WΪƵ��ʸ��
    movfundFrecy=filter(B,A,inSignal);    %ȥ��Ƶ
    FmovfundFrecy=fft(movfundFrecy);    %ȥ����ȥ��Ƶ���źŸ���Ҷ�任
    P2FmovfundFrecy=FmovfundFrecy/L.*conj(FmovfundFrecy)/L;      %˫�๦����
    FmovfundFrecy=P2FmovfundFrecy(1:L/2+1);     %���๦����
    FmovfundFrecy(2:end-1)=2*FmovfundFrecy(2:end-1);    %P1(1)��ֱ������
end

