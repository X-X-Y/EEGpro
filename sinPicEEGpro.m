function sinPicEEGpro( Original,channel,start,finish )
%singleEEGpro  ����ĳ��ͨ��ĳ������
%   Original  ԭʼ�ź�
%   channel  ѡ��ͨ��
%   start  �źſ�ʼ�Ĳ�����
%   finish  �źŽ����Ĳ�����

    %ȥ�����߸���
    [y,t,f,zcy0,P1Fzcy0,zcy0ed]=movBaseline(Original,channel,500,start,finish);
    subplot(3,3,1);plot(t,zcy0);title('ԭʼ�ź�');xlabel('t(S)');ylabel('uV');    %��ʾԭʼ�ź�,����ʱ��2s
    subplot(3,3,2);plot(f,P1Fzcy0);title('ԭʼ�źŵĹ�����');xlabel('f(HZ)');ylabel('|P1(f)|');
    subplot(3,3,3);plot(t,y);title('��ϻ���');xlabel('t(S)');ylabel('uV');
    subplot(3,3,4);plot(t,zcy0ed);title('ȥ�����ߺ���ź�');xlabel('t(S)');ylabel('uV');  %��ʾȥ�����߸��ź���ź�

    %IIR�ݲ���ȥ����Ƶ����
    [H,W,t,f,zcy0edFil,P1Fzcy0edFil]=movFundFrecy(zcy0ed,50,500,0.98);
    subplot(3,3,5);plot(W,abs(H));title('�ݲ����ķ�Ƶ��Ӧ');
    subplot(3,3,6);plot(t,zcy0edFil);title('ȥ����ȥ��Ƶ���ź�');
    subplot(3,3,7);plot(f,P1Fzcy0edFil);title('ȥ����ȥ��Ƶ���źŵķ�������');xlabel('f(HZ)');ylabel('|P1(f)|');

    %�������ܶ��Լ���������Ƶ�����źŹ���
    [pxx,fpow,powerFeatures] = powerSort( zcy0edFil,500 );
    subplot(3,3,8);plot(fpow,pxx);title('��ǰͨ�������źŹ������ܶ�');
    subplot(3,3,9);bar(powerFeatures);title('��ǰͨ�������źŸ����ɹ���');
    set(gca,'xticklabel',{'delta','theta','alpha','beta','gamma'});
end

