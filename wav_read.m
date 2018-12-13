function [ header, len, data ] = wav_read( wav_path )
    fid = fopen(wav_path, 'r');
    
    header = fread(fid, 40, 'uint8=>char');
    len = fread(fid, 1, 'uint32');
    [data, ~] = fread(fid, inf, 'uint16');

    fclose(fid);
end

