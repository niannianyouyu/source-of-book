clc,clear all,close all,
Img = imread('.\Pics\Ch04\Homomorphic.bmp');    
Img =rgb2gray(Img);
Img =im2uint8(Img);
[M N]=size(Img);         %得大小     
figure;
imshow(Img);             %显示图 
Img=double(Img);         %转换类型     
lnImg = log(Img+1);        %取对数
FImg  = fft2(lnImg);     %傅立叶变换
P =fftshift(FImg);       %将频域原点移到图像中心  
for i=1:M 
    for j=1:N  
        D(i,j)=((i-M/2)^2+(j-N/2)^2); %点（i,j）到频率平面原点的距离
    end                
end 
c=0.8;         %锐化参数，可调 
Do=200 ;   %一般是方差 (滤波器的高通截止频率)
H=(2.0-0.25)*(1-exp(c*(-D/(Do^2))))+0.25; %滤波器函数
hImg=FImg.*H;                                
gImg=ifft2(hImg);     %逆傅立叶变换
Y=exp(gImg);       %取指数 
G=real(Y); 
%%
G = (G-min(G(:)))/(max(G(:))-min(G(:)));
figure,imshow(G); 
imwrite(G,'result.bmp');