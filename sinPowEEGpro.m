function [ powerFeatures ] = sinPowEEGpro( Original,channel,start,finish )
%sinPowEEGpro  ��ȡ����ͨ��������ƽ������
%   Original  ԭʼ�ź�
%   channel  ѡ��ͨ��
%   start  �źſ�ʼ�Ĳ�����
%   finish  �źŽ����Ĳ�����
%   powerFeatures  ĳ��ͨ���ĸ�����ƽ����������
    [~,~,~,~,~,zcy0ed]=movBaseline(Original,channel,500,start,finish);
    [~,~,~,~,zcy0edFil,~]=movFundFrecy(zcy0ed,50,500,0.98);
    [~,~,powerFeatures] = powerSort( zcy0edFil,500 );
end

