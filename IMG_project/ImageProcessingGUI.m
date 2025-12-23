function ImageProcessingGUI
clc; close all;

% ================= FIGURE =================
fig = figure('Name','Image Processing GUI ?',...
    'NumberTitle','off',...
    'Color',[1 0.9 0.93],...
    'Position',[100 50 1250 800]);
% ================= AXES ===================
axesOriginal = axes('Parent',fig,...
    'Position',[0.08 0.45 0.35 0.45]);
imshow(zeros(10));
axis off
title('Original Image','FontSize',12,'FontWeight','bold')

axesProcessed = axes('Parent',fig,...
    'Position',[0.57 0.45 0.35 0.45]);
imshow(zeros(10));
axis off
title('Processed Image','FontSize',12,'FontWeight','bold')

% ================= DATA ===================
data.original = [];
data.processed = [];
data.fourier = [];  % ????: ???? Fourier Transform
data.params.threshold = 0.5;
data.params.gamma = 0.5;
data.params.brightness = 50;
data.params.D0 = 30;
data.params.order = 2;
data.params.noiseAmount = 0.05;
data.params.grayOption = 1;
guidata(fig,data);

% ================= MAIN PANEL ==================
panel = uipanel('Parent',fig,...
    'Title','Controls',...
    'FontSize',11,...
    'BackgroundColor',[1 0.88 0.92],...
    'Position',[0.05 0.05 0.9 0.35]);

% ================= MAIN BUTTONS (LEFT SIDE) =================
uicontrol(panel,'Style','pushbutton','String','Load Image',...
    'FontSize',10,...
    'Position',[30 220 180 40],...
    'Callback',@loadImage);

uicontrol(panel,'Style','pushbutton','String','Apply',...
    'FontSize',11,'FontWeight','bold',...
    'Position',[30 160 180 45],...
    'Callback',@applyFilter);

% === ???? Reset ?????? ===
uicontrol(panel,'Style','pushbutton','String','Reset',...
    'FontSize',10,'FontWeight','bold',...
    'Position',[30 110 180 40],...
    'Callback',@resetImage);

uicontrol(panel,'Style','pushbutton','String','Save',...
    'FontSize',10,...
    'Position',[30 60 180 40],...
    'Callback',@saveImage);

uicontrol(panel,'Style','pushbutton','String','Exit',...
    'FontSize',10,...
    'Position',[30 10 180 40],...
    'Callback',@(~,~) close(fig));

% ================= PARAMETERS PANEL (MIDDLE - 2 columns) =================
paramPanel = uipanel('Parent',panel,...
    'Title','Parameters',...
    'FontSize',10,...
    'BackgroundColor',[1 0.95 0.98],...
    'Position',[0.25 0.1 0.35 0.8]);

% Row 1
uicontrol(paramPanel,'Style','text','String','Threshold (0-1):',...
    'Position',[20 130 120 20],'HorizontalAlignment','left');
hThreshold = uicontrol(paramPanel,'Style','edit','String','0.5',...
    'Position',[150 130 100 25],'Callback',@saveParams);

uicontrol(paramPanel,'Style','text','String','Gamma:',...
    'Position',[220 130 100 20],'HorizontalAlignment','left');
hGamma = uicontrol(paramPanel,'Style','edit','String','0.5',...
    'Position',[320 130 100 25],'Callback',@saveParams);

% Row 2
uicontrol(paramPanel,'Style','text','String','Brightness (±):',...
    'Position',[20 80 120 20],'HorizontalAlignment','left');
hBrightness = uicontrol(paramPanel,'Style','edit','String','50',...
    'Position',[150 80 100 25],'Callback',@saveParams);

uicontrol(paramPanel,'Style','text','String','Cutoff Freq (D0):',...
    'Position',[220 80 120 20],'HorizontalAlignment','left');
hD0 = uicontrol(paramPanel,'Style','edit','String','30',...
    'Position',[320 80 100 25],'Callback',@saveParams);

% Row 3
uicontrol(paramPanel,'Style','text','String','Order (n):',...
    'Position',[20 30 120 20],'HorizontalAlignment','left');
hOrder = uicontrol(paramPanel,'Style','edit','String','2',...
    'Position',[150 30 100 25],'Callback',@saveParams);

uicontrol(paramPanel,'Style','text','String','Noise Amount:',...
    'Position',[220 30 120 20],'HorizontalAlignment','left');
hNoise = uicontrol(paramPanel,'Style','edit','String','0.05',...
    'Position',[320 30 100 25],'Callback',@saveParams);

uicontrol(paramPanel,'Style','text','String','Gray Option:',...
    'Position',[20 170 120 20],'HorizontalAlignment','left');

grayPopup = uicontrol(paramPanel,'Style','popupmenu',...
    'String',{'Average','Weighted','Red','Green','Blue'},...
    'Position',[150 170 150 25],...
    'Callback',@saveParams);


% ================= FILTER LIST (RIGHT SIDE) =================
uicontrol(panel,'Style','text','String','Choose Filter:',...
    'FontSize',11,'FontWeight','bold',...
    'BackgroundColor',[1 0.88 0.92],...
    'Position',[750 250 200 25]);

filterList = uicontrol(panel,'Style','listbox',...
    'FontSize',9,...
    'Position',[750 10 300 240],...
    'String',{...
        'Negative',...
        'Histogram Equalization',...
        'Gray To Binary',...
        'RGB To Gray',...
        'RGB To Binary',...
        'Brightness',...
        'Contrast Stretching',...
        'LOG',...
        'Gamma Correction',...
        'Correlation',...
        'Mean Filter',...
        'Weighted Mean Filter',...
        'Point Detection',...
        'Line Detection - Horizontal',...
        'Line Detection - Vertical',...
        'Line Detection - Diagonal Left',...
        'Line Detection - Diagonal Right',...
        'Point Sharpening',...
        'Line Sharpening - Horizontal',...
        'Min Filter',...
        'Max Filter',...
        'Median Filter',...
        'Midpoint Filter',...
        'Fourier Transform',...
        'Inverse Fourier Transform',...
        'Ideal Low Pass',...
        'Ideal High Pass',...
        'Butterworth Low Pass',...
        'Butterworth High Pass',...
        'Gaussian Low Pass',...
        'Gaussian High Pass',...
        'Salt and Pepper Noise',...
        'Uniform Noise',...
        'Gaussian Noise',...
        'Rayleigh Noise',...
        'Exponential Noise',...
        'Gamma Noise',...
        'Erosion',...
        'Dilation',...
        'Opening',...
        'Closing'},...
    'Callback',@updateParamsVisibility);

% ??? ??? handles
data.handles = struct('threshold',hThreshold,'gamma',hGamma,'brightness',hBrightness,...
    'D0',hD0,'order',hOrder,'noise',hNoise,'gray',grayPopup);

guidata(fig,data);

updateParamsVisibility();

% ==================================================
% ================= CALLBACKS ======================
% ==================================================
    function loadImage(~,~)
        [f,p] = uigetfile({'*.jpg;*.png;*.bmp;*.tif'});
        if f==0, return; end
        img = imread(fullfile(p,f));
        data = guidata(fig);
        data.original = img;
        data.processed = img;
        guidata(fig,data);
        imshow(img,'Parent',axesOriginal);
        imshow(img,'Parent',axesProcessed);
        msgbox('Image loaded successfully ?','Done','help');
    end

    function resetImage(~,~)
        data = guidata(fig);
        if isempty(data.original)
            msgbox('No image to reset!','Info');
            return;
        end
        % ????? ?????? ???????? ???????
        data.processed = data.original;
        guidata(fig,data);
        imshow(data.original,'Parent',axesProcessed);
        msgbox('Image reset to original ?','Done','help');
    end

    function updateParamsVisibility(~,~)
        data = guidata(fig);
        if ~isfield(data,'handles'), return; end
        h = data.handles;
        choice = get(filterList,'Value');

        set([h.threshold h.gamma h.brightness h.D0 h.order h.noise],'Visible','on');

        switch choice
            case {1,2,4,7,8,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24}
                set([h.threshold h.gamma h.brightness h.D0 h.order h.noise],'Visible','off');
            case 3  % Gray To Binary
                set([h.gamma h.brightness h.D0 h.order h.noise],'Visible','off');
            case 5  % RGB To Binary
                set([h.gamma h.brightness h.D0 h.order h.noise],'Visible','off');
            case 6  % Brightness
                set([h.threshold h.gamma h.D0 h.order h.noise],'Visible','off');
            case 9  % Gamma Correction
                set([h.threshold h.brightness h.D0 h.order h.noise],'Visible','off');
            case {26,27,28,29,30,31}
                set([h.threshold h.gamma h.brightness h.noise],'Visible','off');
                if ismember(choice,[28,29])
                    set(h.order,'Visible','on');
                else
                    set(h.order,'Visible','off');
                end
            case {32:36}
                set([h.threshold h.gamma h.brightness h.D0 h.order],'Visible','off');
            otherwise
                set([h.threshold h.gamma h.brightness h.D0 h.order h.noise],'Visible','on');
        end
    end

    function saveParams(~,~)
        data = guidata(fig);
        data.params.threshold = str2double(get(hThreshold,'String'));
        data.params.gamma = str2double(get(hGamma,'String'));
        data.params.brightness = str2double(get(hBrightness,'String'));
        data.params.D0 = str2double(get(hD0,'String'));
        data.params.order = str2double(get(hOrder,'String'));
        data.params.noiseAmount = str2double(get(hNoise,'String'));
        data.params.grayOption = get(grayPopup,'Value');  % <--- ????? ??????
        guidata(fig,data);
    end

    function applyFilter(~,~)
        data = guidata(fig);
        if isempty(data.original)
            msgbox('Load an image first!','Error','error');
            return;
        end
        img = data.original;
        choice = get(filterList,'Value');
        p = data.params;

        % ????? ?? double ??????? ???? ?????? ??? ?????
        if ismember(choice,[1,8,9,13:19,24:36,26:31])  % ????? 6
            img = im2double(img);
        end

        switch choice
            case 1  % Negative
                img = imcomplement(img);

            case 2  % Histogram Equalization
                if size(img,3)==3, img = rgb2gray(img); end
            case 3  % Gray To Binary
                if size(img,3)==3
                    img = rgb2gray(img);
                end
                img = GrayToBinary(img, p.threshold);
            case 4  % RGB To Gray
    if size(img,3)==3
        img = rgbtogray(img , p.grayOption); % opt ?? GUI
    end

            case 5  % RGB To Binary
    if size(img,3)==3
        gray = rgbtogray(img , p.grayOption);
    else
        gray = img;
    end
    img = GrayToBinary(gray , p.threshold);


            case 6  % Brightness
                delta = int16(p.brightness);  % ???? + ? -
                img = uint8(max(0, min(255, int16(img) + delta)));
                        case 7  % Contrast Stretching
                            img = imadjust(img);

            case 8  % LOG (Laplacian of Gaussian)
                if size(img,3)==3, img = rgb2gray(img); end
                h = fspecial('log', [5 5], 1.0);
                img = imfilter(img, h, 'conv');

            case 9  % Gamma Correction
                img = img .^ p.gamma;

            case 10  % Correlation (?? mean filter ?????)
                h = fspecial('average', [3 3]);
                img = imfilter(img, h, 'corr');

            case 11  % Mean Filter
                img = imfilter(img, fspecial('average',[5 5]));

            case 12  % Weighted Mean Filter
                h = [1 2 1; 2 4 2; 1 2 1]/16;
                img = imfilter(img, h);

            case 13  % Point Detection
                if size(img,3)==3, img = rgb2gray(img); end
                h = [-1 -1 -1; -1 8 -1; -1 -1 -1];
                img = imfilter(img, h);

            case 14  % Line Detection - Horizontal
                if size(img,3)==3, img = rgb2gray(img); end
                h = [-1 -1 -1; 2 2 2; -1 -1 -1];
                img = imfilter(img, h);

            case 15  % Line Detection - Vertical
                if size(img,3)==3, img = rgb2gray(img); end
                h = [-1 2 -1; -1 2 -1; -1 2 -1];
                img = imfilter(img, h);

            case 16  % Line Detection - Diagonal Left
                if size(img,3)==3, img = rgb2gray(img); end
                h = [-1 -1 2; -1 2 -1; 2 -1 -1];
                img = imfilter(img, h);

            case 17  % Line Detection - Diagonal Right
                if size(img,3)==3, img = rgb2gray(img); end
                h = [2 -1 -1; -1 2 -1; -1 -1 2];
                img = imfilter(img, h);

            case 18  % Point Sharpening (Laplacian)
                h = [0 -1 0; -1 5 -1; 0 -1 0];
                img = imfilter(img, h);

            case 19  % Line Sharpening - Horizontal
                h = [0 0 0; -1 2 -1; 0 0 0];
                img = imfilter(img, h);

            case 20  % Min Filter
                img = ordfilt2(img, 1, ones(3,3));

            case 21  % Max Filter
                img = ordfilt2(img, 9, ones(3,3));

            case 22  % Median Filter
                img = medfilt2(img, [3 3]);

            case 23  % Midpoint Filter
                minf = ordfilt2(img,1,ones(3,3));
                maxf = ordfilt2(img,9,ones(3,3));
                img = (minf + maxf)/2;

            case 24 % Fourier Transform (??? ????????? + ??? ??? F)
                data = guidata(fig);  % ??? ??? data
                if size(img,3)==3, img = rgb2gray(img); end
                img_double = im2double(img);
                F = fftshift(fft2(img_double));
                % ??? ??? Fourier ??? Inverse ?????
                data.fourier = F;
                guidata(fig, data);
                % ??? ??? magnitude spectrum
                spectrum = log(1 + abs(F));
                img = mat2gray(spectrum);
                msgbox('Fourier Transform applied and saved. Now you can apply Inverse FFT.','Info');

            case 25 % Inverse Fourier Transform
                data = guidata(fig);
                if isempty(data.fourier)
                    msgbox('No Fourier Transform saved! Apply Fourier Transform first.','Error','error');
                    return;
                end
                F = data.fourier;  % ??? ??? saved Fourier
                inverse = real(ifft2(ifftshift(F)));
                img = mat2gray(inverse);
                % ???????: ???? ?????? ??????? ??? ??? inverse (??????)
                msgbox('Inverse Fourier Transform applied successfully ?','Done','help');
            case 26  % Ideal Low Pass
                if size(img,3)==3, img = rgb2gray(img); end
                [M,N] = size(img);
                [u,v] = meshgrid(-floor(N/2):floor((N-1)/2), -floor(M/2):floor((M-1)/2));
                D = sqrt(u.^2 + v.^2);
                H = double(D <= p.D0);
                F = fftshift(fft2(img));
                img = real(ifft2(ifftshift(F .* H)));
                img = mat2gray(img);

            case 27  % Ideal High Pass
                if size(img,3)==3, img = rgb2gray(img); end
                [M,N] = size(img);
                [u,v] = meshgrid(-floor(N/2):floor((N-1)/2), -floor(M/2):floor((M-1)/2));
                D = sqrt(u.^2 + v.^2);
                H = double(D > p.D0);
                F = fftshift(fft2(img));
                img = real(ifft2(ifftshift(F .* H)));
                img = mat2gray(img);

            case 28  % Butterworth Low Pass
                if size(img,3)==3, img = rgb2gray(img); end
                [M,N] = size(img);
                [u,v] = meshgrid(-floor(N/2):floor((N-1)/2), -floor(M/2):floor((M-1)/2));
                D = sqrt(u.^2 + v.^2);
                H = 1 ./ (1 + (D ./ p.D0).^(2*p.order));
                F = fftshift(fft2(img));
                img = real(ifft2(ifftshift(F .* H)));
                img = mat2gray(img);

            case 29  % Butterworth High Pass
                if size(img,3)==3, img = rgb2gray(img); end
                [M,N] = size(img);
                [u,v] = meshgrid(-floor(N/2):floor((N-1)/2), -floor(M/2):floor((M-1)/2));
                D = sqrt(u.^2 + v.^2);
                H = 1 ./ (1 + (p.D0 ./ D).^(2*p.order));
                F = fftshift(fft2(img));
                img = real(ifft2(ifftshift(F .* H)));
                img = mat2gray(img);

            case 30  % Gaussian Low Pass
                if size(img,3)==3, img = rgb2gray(img); end
                [M,N] = size(img);
                [u,v] = meshgrid(-floor(N/2):floor((N-1)/2), -floor(M/2):floor((M-1)/2));
                D = sqrt(u.^2 + v.^2);
                H = exp(-(D.^2) ./ (2*(p.D0^2)));
                F = fftshift(fft2(img));
                img = real(ifft2(ifftshift(F .* H)));
                img = mat2gray(img);

            case 31  % Gaussian High Pass
                if size(img,3)==3, img = rgb2gray(img); end
                [M,N] = size(img);
                [u,v] = meshgrid(-floor(N/2):floor((N-1)/2), -floor(M/2):floor((M-1)/2));
                D = sqrt(u.^2 + v.^2);
                H = 1 - exp(-(D.^2) ./ (2*(p.D0^2)));
                F = fftshift(fft2(img));
                img = real(ifft2(ifftshift(F .* H)));
                img = mat2gray(img);

            case 32  % Salt and Pepper Noise
                img = imnoise(img, 'salt & pepper', p.noiseAmount);

            case 33  % Uniform Noise
                img = imnoise(img, 'localvar', p.noiseAmount * ones(size(img)));

            case 34  % Gaussian Noise
                img = imnoise(img, 'gaussian', 0, p.noiseAmount);

            case 35  % Rayleigh Noise
                sigma = p.noiseAmount * 100;  % ?????? ???? ??????? ????
                img_double = im2double(img);
                [rows, cols, ch] = size(img_double);
                noise = sigma * sqrt(-2 * log(1 - rand(rows, cols, ch)));
                noise = noise - mean(noise(:));  % mean-zero
                img_double = img_double + noise;
                img_double = max(0, min(1, img_double));
                img = im2uint8(img_double);

            case 36  % Exponential Noise
                img = im2double(img);
                lambda = p.noiseAmount;
                noise = -(1/lambda) * log(1 - rand(size(img)));
                img = img + noise;
                img = im2uint8(mat2gray(img));

            case 37  % Gamma Noise
                k = round(p.order);  % ??????? ??? order ?? shape (?? ????? param ????)
                theta = p.noiseAmount * 50;  % ????? ??????? ???? ??????? ????
                img = Gamma_noise(img, k, theta);

            case 38  % Erosion
                if size(img,3)==3, img = rgb2gray(img); end
                se = strel('disk', 3);
                img = imerode(im2uint8(img), se);

            case 39  % Dilation
                if size(img,3)==3, img = rgb2gray(img); end
                se = strel('disk', 3);
                img = imdilate(im2uint8(img), se);

            case 40  % Opening
                if size(img,3)==3, img = rgb2gray(img); end
                se = strel('disk', 3);
                img = imopen(im2uint8(img), se);

            case 41  % Closing
                if size(img,3)==3, img = rgb2gray(img); end
                se = strel('disk', 3);
                img = imclose(im2uint8(img), se);

            otherwise
                msgbox('Filter not implemented yet','Info');
                return;
        end

        data.processed = img;
        guidata(fig,data);
        imshow(img, 'Parent', axesProcessed);
        msgbox('Filter applied successfully ?','Done','help');
    end

    function saveImage(~,~)
        data = guidata(fig);
        if isempty(data.processed), return; end
        [f,p] = uiputfile({'*.png';'*.jpg';'*.bmp'});
        if f==0, return; end
        imwrite(data.processed,fullfile(p,f));
        msgbox('Image saved successfully ?','Done','help');
    end
end