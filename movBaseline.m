function [ y,t,f,Originaled,Foriginaled,movOriginaledBline   ] = movBaseline( Original,channel,fs,start,finish )
%movBaseline  ����������ȡԭʼ�źŵ�ĳ��ͨ��һ�β��������ݣ�������ȡ������ݼ��䵥�߹����ף���������ȥ�����ߴ�������ʱ���ź�
%   Original  ԭʼ�ź�
%   channel  ԭʼ�źŲɼ�ͨ��
%   fs  ԭʼ�źŲ���Ƶ��
%   start  ԭʼ�źſ�ʼ�Ĳ�����
%   finish  ԭʼ�źŽ����Ĳ�����
%   t  ʱ��ʸ��
%   f  ����Ƶ��ʸ��
%   Originaled  ԭʼ�źŽ�ȡ���һ��ʱ���ź�
%   Foriginaled  Originaled�ĵ��߹�����
%   y  ��ϻ���
%   movOriginaledBline  Originaledȥ�����ߺ��ʱ���ź�
    T=1/fs;     %��������
    L=finish-start;   %�źų���
    t=(0:L-1)*T;   %ʱ��ʸ��
    Originaled=Original(channel,start+1:finish);    %��ȡͨ��channel��start:finish����������
    Fori=fft(Originaled);    %ԭʼ�ź�������Ҷ�任
    P2FOriginaled=Fori/L.*conj(Fori)/L;      %˫�߹�����
    Foriginaled=P2FOriginaled(1:L/2+1);     %���߹�����
    Foriginaled(2:end-1)=2*Foriginaled(2:end-1);    %P1(1)��ֱ������
    f=fs*(0:(L/2))/L;     %����Ƶ��ʸ��
    [p,~,mu] = polyfit(t,Originaled,4);   %���4�ζ���ʽϵ������p
    y=polyval(p,t,[],mu);   %��ϻ���
    movOriginaledBline=Originaled-y;  %ȥ�����ߺ��ź�
end

