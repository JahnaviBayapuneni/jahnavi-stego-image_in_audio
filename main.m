clc; 
close all;
clear all;

%% To read a Image and Audio file
secret_image = 'lena-gs-2.png';
cover_audio = 'drum-loop.wav';
output_audio = 'emb-drum-loop.wav';

% image_data = input_image;
image_file = imread(secret_image);
figure(1); imshow(image_file); title('Image Before  Encryption');
figure(2);imhist(image_file);  title('Histogram Before Encryption');
[~, ~, wav_data] = wav_read(cover_audio);
num_samples = length(audioread(cover_audio));

% size in KB
wav_size = get_file_size(cover_audio) / 1024;
img_size = get_file_size(secret_image) / 1024;

img_data_len = numel(image_file);
wav_data_len = length(wav_data);


    tic
    imbed= input('no. of bits to be made as secret bits=');
    embed_process(0, cover_audio, secret_image, output_audio);
    toc
   
    
    tic
    decrypt_key= input('enter the secret bits=');
if(imbed==decrypt_key)
    disp('Authenticated');
    msgbox('Authenticated');
    image = extract_image(0, output_audio);
    toc
    figure(3); imshow(image);  title('Image after Decryption');
    figure(4);  imhist(image); title('Histogram After Decryption');          
    oa = audioread(cover_audio);
    sa = audioread(output_audio);
    
    N1 = length(oa(:, 1));
    N2 = length(oa(:, 2));

    mse_1 = (sum((oa(:, 1) - sa(:, 1)) .^ 2)) / N1;
    mse_2 = (sum((oa(:, 2) - sa(:, 2)) .^ 2)) / N2;
    
    snr_1 = 10 * log10((sum(oa(:, 1) .^ 2) / N1) / mse_1);
    snr_2 = 10 * log10((sum(oa(:, 2) .^ 2) / N2) / mse_2);



else
    disp('Unauthenticated ');
    msgbox('Unauthenticated');
end

