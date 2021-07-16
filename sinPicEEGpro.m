function sinPicEEGpro( Original,channel,start,finish )
%singleEEGpro  处理某个通道某段数据
%   Original  原始信号
%   channel  选择通道
%   start  信号开始的采样点
%   finish  信号结束的采样点

    %去除基线干扰
    [y,t,f,zcy0,P1Fzcy0,zcy0ed]=movBaseline(Original,channel,500,start,finish);
    subplot(3,3,1);plot(t,zcy0);title('原始信号');xlabel('t(S)');ylabel('uV');    %显示原始信号,持续时间2s
    subplot(3,3,2);plot(f,P1Fzcy0);title('原始信号的功率谱');xlabel('f(HZ)');ylabel('|P1(f)|');
    subplot(3,3,3);plot(t,y);title('拟合基线');xlabel('t(S)');ylabel('uV');
    subplot(3,3,4);plot(t,zcy0ed);title('去除基线后的信号');xlabel('t(S)');ylabel('uV');  %显示去除基线干扰后的信号

    %IIR陷波器去除工频干扰
    [H,W,t,f,zcy0edFil,P1Fzcy0edFil]=movFundFrecy(zcy0ed,50,500,0.98);
    subplot(3,3,5);plot(W,abs(H));title('陷波器的幅频响应');
    subplot(3,3,6);plot(t,zcy0edFil);title('去基线去工频后信号');
    subplot(3,3,7);plot(f,P1Fzcy0edFil);title('去基线去工频后信号的幅功率谱');xlabel('f(HZ)');ylabel('|P1(f)|');

    %求功率谱密度以及各个节律频带的信号功率
    [pxx,fpow,powerFeatures] = powerSort( zcy0edFil,500 );
    subplot(3,3,8);plot(fpow,pxx);title('当前通道完整信号功率谱密度');
    subplot(3,3,9);bar(powerFeatures);title('当前通道完整信号各节律功率');
    set(gca,'xticklabel',{'delta','theta','alpha','beta','gamma'});
end

