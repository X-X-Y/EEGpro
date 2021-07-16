load data;  %�������ݣ��������鱻�⣬zcy��
zcy=struct('zcy0',zcy_0,'zcy1',zcy_1,'zcy2',zcy_2,'zcy3',zcy_3);  %���ĸ�ʱ��������ɽṹ��
names=fieldnames(zcy);  %��ñ���zcy�ṹ���
allPowFeat={zeros(16,5) zeros(16,5) zeros(16,5) zeros(16,5) };  %��ʹ����ά�����ͼʱ��Ҫ��һ������

% �˴���ȫ������ÿ��ʱ��ÿ��ͨ�������ͼƬ���������ܴ����½����ֶ������źűȽϹ۲�
% for channel=1:2  %�ֶ�ѡ��ͨ��
%     figure(channel);
%     sinPicEEGpro(zcy_0,channel,10000,11000);  %�ֶ�ѡ�������źźͿ�ʼ�����˵�
% end

% ��ȡ��ҩǰ��ÿ��ʱ��16��ͨ��5�����ɵĹ��ʲ�����
for i=1:length(names)  %������ҩǰ���ĸ�ʱ��
    key=names(i);  %��õ�ǰ��
    key=key{1};
    for channel=1:16  %����ʮ����ͨ��
        [powerFeatures] = sinPowEEGpro(zcy.(key),channel,0,length(zcy.(key)));  %��ȡĳͨ��ȫ������ƽ������
        allPowFeat{i}(channel,:)=powerFeatures;  %����zcyȫ������ƽ�����ʱ���
    end
end

% ͬһʱ��16��ͨ��5��������״ͼ
for times=1:4
    subplot(2,2,times);bar3(allPowFeat{times});
    switch times  %���õ�ǰͼ����
        case 1
            title('��ҩǰ');
        case 2
            title('��ҩ��һСʱ');
        case 3
            title('��ҩ����Сʱ');
        case 4
            title('��ҩ����Сʱ');
    end
    set(gca,'xticklabel',{'delta','theta','alpha','beta','gamma'});  %���ø���������
end


