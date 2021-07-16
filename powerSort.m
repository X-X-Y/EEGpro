function [ pxx,fpow,powerFeatures ] = powerSort( inSignal,fs )
%powerSort  求功率谱密度以及各个节律频带的信号功率
%   inSignal  输入信号
%   fs  采样频率
%   pxx  功率谱密度
%   fpow  频率向量
%   powerFeatures  各节律频带的信号功率组成的数组
    %使用 welch 法来提取功率谱密度
    [pxx, fpow] = pwelch(inSignal, [], [], [], fs);    %对去基线去工频的信号求功率谱密度
    %计算各个节律频带的信号平均功率
    power_delta = bandpower(pxx, fpow, [0.5, 3], 'psd');
    power_theta = bandpower(pxx, fpow, [4, 7], 'psd');
    power_alpha = bandpower(pxx, fpow, [8, 13], 'psd');
    power_beta = bandpower(pxx, fpow, [14, 30], 'psd');
    power_gamma = bandpower(pxx, fpow, [31, 60], 'psd');%从功率谱可以看出50HZ以后就基本没有幅度了
    %各节律平均功率数组
    powerFeatures=[power_delta,power_theta,power_alpha,power_beta,power_gamma];
end

