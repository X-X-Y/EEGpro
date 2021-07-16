function [ pxx,fpow,powerFeatures ] = powerSort( inSignal,fs )
%powerSort  �������ܶ��Լ���������Ƶ�����źŹ���
%   inSignal  �����ź�
%   fs  ����Ƶ��
%   pxx  �������ܶ�
%   fpow  Ƶ������
%   powerFeatures  ������Ƶ�����źŹ�����ɵ�����
    %ʹ�� welch ������ȡ�������ܶ�
    [pxx, fpow] = pwelch(inSignal, [], [], [], fs);    %��ȥ����ȥ��Ƶ���ź��������ܶ�
    %�����������Ƶ�����ź�ƽ������
    power_delta = bandpower(pxx, fpow, [0.5, 3], 'psd');
    power_theta = bandpower(pxx, fpow, [4, 7], 'psd');
    power_alpha = bandpower(pxx, fpow, [8, 13], 'psd');
    power_beta = bandpower(pxx, fpow, [14, 30], 'psd');
    power_gamma = bandpower(pxx, fpow, [31, 60], 'psd');%�ӹ����׿��Կ���50HZ�Ժ�ͻ���û�з�����
    %������ƽ����������
    powerFeatures=[power_delta,power_theta,power_alpha,power_beta,power_gamma];
end

