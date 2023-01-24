%%%%%%%%%%%%%%%%%%%%%%%%%%%% PRACTICA 2 - MATLAB %%%%%%%%%%%%%%%%%%%%%%%%%%

%% EJERCICIO 1

% Las imagenes estan tomadas para la deteccion de cancer de mama

%% EJERCICIO 2

% Tenemos dos subcarpetas: una para imagenes de tumores benignos y otra
% para imagenes de tumores malignos. En cada carpeta hay una serie de
% imagenes de ultrasonidos de la zona de la mama, cada una de ellas
% acompañada de una mascara que segmenta el tumor.

%% EJERCICIO 3

% Lectura imagen benigna y su mascara
im_benigna = imread('US_breast/benign/benign (181).png');
mask_benigna = imread('US_breast/benign/benign (181)_mask.png');

% Lectura imagen maligna y su mascara
im_maligna = imread('US_breast/malignant/malignant (200).png');
mask_maligna = imread('US_breast/malignant/malignant (200)_mask.png');

% Si hubiera mas de una mascara la leemos tambien
try
    mask_benigna2 = imread('US_breast/benign/benign (181)_mask_1.png');
    mask_benigna = mask_benigna + mask_benigna2;
    mask_maligna2 = imread('US_breast/malignant/malignant (181)_mask_.png');
    mask_maligna = mask_maligna + mask_maligna2;
catch    
end

% Obtenemos imagenes tras aplicar la mascara
im_benigna_mask = im2gray(im_benigna).*im2gray(uint8(mask_benigna));
im_maligna_mask = im2gray(im_maligna).*im2gray(uint8(mask_maligna));

% Representacion
figure,
subplot(231),imshow(im_benigna), title('Imagen benigna original'),...
    subplot(232),imshow(mask_benigna), title('Mascara'), ...
    subplot(233),imshow(im_benigna_mask), title('Imagen benigna tras aplicar mascara')

subplot(234),imshow(im_maligna), title('Imagen maligna original'),...
    subplot(235),imshow(mask_maligna), title('Mascara'), ...
    subplot(236),imshow(im_maligna_mask), title('Imagen maligna tras aplicar mascara')

%% EJERCICIO 4

S_benigna = regionprops(mask_benigna,'Perimeter','Area');
perimetro_benigna = S_benigna.Perimeter; area_benigna = S_benigna.Area;

S_maligna = regionprops(mask_maligna,'Perimeter','Area');
perimetro_maligna = S_maligna.Perimeter; area_maligna = S_maligna.Area;

densidad_benigna = (perimetro_benigna^2)/(area_benigna);
densidad_maligna = (perimetro_maligna^2)/(area_maligna);

%% EJERCICIO 5

% Nivel de gris medio imagen benigna (tras aplicar mascara):
nivel_gris_benigna = mean(im_benigna_mask(im_benigna_mask~=0));

% Nivel de gris medio imagen maligna (tras aplicar mascara):
nivel_gris_maligna = mean(im_maligna_mask(im_maligna_mask~=0));

%% EJERCICIO 6

% Imprimimos por linea de comandos la informacion
fprintf('Densidad tumor benigno: %f\n', densidad_benigna);
fprintf('Densidad tumor maligno: %f\n', densidad_maligna);
fprintf('Nivel gris medio tumor benigno: %f\n', nivel_gris_benigna);
fprintf('Nivel gris medio tumor maligno: %f\n', nivel_gris_maligna);

% Parece que la densidad del tumor maligno es siempre mayor que el del
% benigno. Igual con el nivel de gris.
