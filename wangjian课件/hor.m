clc,clear all,close all,
Img = imread('.\Pics\Ch04\Homomorphic.bmp');    
Img =rgb2gray(Img);
Img =im2uint8(Img);
[M N]=size(Img);         %�ô�С     
figure;
imshow(Img);             %��ʾͼ 
Img=double(Img);         %ת������     
lnImg = log(Img+1);        %ȡ����
FImg  = fft2(lnImg);     %����Ҷ�任
P =fftshift(FImg);       %��Ƶ��ԭ���Ƶ�ͼ������  
for i=1:M 
    for j=1:N  
        D(i,j)=((i-M/2)^2+(j-N/2)^2); %�㣨i,j����Ƶ��ƽ��ԭ��ľ���
    end                
end 
c=0.8;         %�񻯲������ɵ� 
Do=200 ;   %һ���Ƿ��� (�˲����ĸ�ͨ��ֹƵ��)
H=(2.0-0.25)*(1-exp(c*(-D/(Do^2))))+0.25; %�˲�������
hImg=FImg.*H;                                
gImg=ifft2(hImg);     %�渵��Ҷ�任
Y=exp(gImg);       %ȡָ�� 
G=real(Y); 
%%
G = (G-min(G(:)))/(max(G(:))-min(G(:)));
figure,imshow(G); 
imwrite(G,'result.bmp');