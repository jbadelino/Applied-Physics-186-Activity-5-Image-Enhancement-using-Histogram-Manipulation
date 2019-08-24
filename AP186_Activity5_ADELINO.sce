stacksize("max")

img = imread('C:\Users\Asus\Documents\MATLAB\5.jpg');
img_gs = rgb2gray(img);
gs_min = min(img_gs);
gs_max = max(img_gs);
disp("minimum = "); disp(gs_min); 
disp("maximum = "); disp(gs_max);
[r,c] = size(img_gs);
imwrite(img_gs, 'C:\Users\Asus\Documents\Applied Physics 186\act 5\gs5_1.png');

//displays the histogram of the original image 
scf(); histplot(256, double(img_gs));
xtitle("grayscale probability distribution function of the original image");

//displays the CDF of the original image 
[counts_o, bins_o] = imhist(img_gs);
CDF_o = cumsum(counts_o)/length(img_gs);
scf(); plot(CDF_o);
xtitle("cumulative distribution function of the original image");

//desired linear CDF
x = [0:255];
des_CDF = x/255.0; 
scf(); plot(des_CDF);
xtitle("Desired cumulative distribution function (linear)");

//desired quadratic CDF 
des_2CDF = x.^2/(255.0^2);
scf(); plot(des_2CDF);
xtitle("Desired cumulative distribution function (quadratic)");

//desired erf CDF 
range1 = linspace(-2,2,256);
des_3CDF = 0.5*(erf(range1)+1);
scf(); plot(des_3CDF);
xtitle("Desired cumulative distribution function (erf)")

//backprojection
d = splin(x,des_CDF);
[yy, yya, yyb] = interp(CDF_o, des_CDF, x, d);
newimg = img_gs;

for i = 0:255
    newimg(find(img_gs == i)) = yy(i+1);
end 

imwrite(newimg, "C:\Users\Asus\Documents\Applied Physics 186\act 5\e5_CDF_1.png")

//displays the histogram of the modified image
scf(); histplot(256, double(newimg));
xtitle("grayscale probability distribution function of the enhanced image");

////displays the CDF of the modified image
[counts_e, bins_e] = imhist(newimg);
CDF_e = cumsum(counts_e)/length(newimg);
scf(); plot(CDF_e);
xtitle("cumulative distribution function of the enhanced image");





