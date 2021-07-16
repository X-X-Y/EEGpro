load data;  %导入数据，包含两组被测，zcy和
zcy=struct('zcy0',zcy_0,'zcy1',zcy_1,'zcy2',zcy_2,'zcy3',zcy_3);  %将四个时期数据组成结构体
names=fieldnames(zcy);  %获得被测zcy结构体键
allPowFeat={zeros(16,5) zeros(16,5) zeros(16,5) zeros(16,5) };  %若使用三维数组绘图时需要进一步处理

% 此处若全部绘制每个时期每个通道的相关图片，工作量很大，以下仅供手动部分信号比较观察
% for channel=1:2  %手动选择通道
%     figure(channel);
%     sinPicEEGpro(zcy_0,channel,10000,11000);  %手动选择输入信号和开始结束端点
% end

% 求取用药前后每个时期16个通道5个节律的功率并保存
for i=1:length(names)  %遍历用药前后四个时期
    key=names(i);  %获得当前键
    key=key{1};
    for channel=1:16  %遍历十六个通道
        [powerFeatures] = sinPowEEGpro(zcy.(key),channel,0,length(zcy.(key)));  %获取某通道全部节律平均功率
        allPowFeat{i}(channel,:)=powerFeatures;  %被测zcy全部节律平均功率保存
    end
end

% 同一时期16个通道5个节律柱状图
for times=1:4
    subplot(2,2,times);bar3(allPowFeat{times});
    switch times  %设置当前图标题
        case 1
            title('用药前');
        case 2
            title('用药后一小时');
        case 3
            title('用药后两小时');
        case 4
            title('用药后三小时');
    end
    set(gca,'xticklabel',{'delta','theta','alpha','beta','gamma'});  %设置各节律名称
end


