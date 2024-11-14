function EsRecibo = clasificaImagen(I)
    % Esta funcion preprocesa imagenes
    % Devuelve verdadero si es un recibo
    
    % PreProcesamiento
    gs = im2gray(I);
    gs = imadjust(gs);
    
    mask = fspecial("average",3);
    gsSmooth = imfilter(gs,mask,"replicate");
    
    SE = strel("disk",8);  
    Ibg = imclose(gsSmooth, SE);
    Ibgsub =  Ibg - gsSmooth;
    Ibw = ~imbinarize(Ibgsub);
    
    SE = strel("rectangle",[3 25]);
    stripes = imopen(Ibw, SE);
    montage({I, stripes})
    
    signal = sum(stripes,2);  

    % Clasificacion
    minIndices = islocalmin(signal,"MinProminence",70,"ProminenceWindow",25); 
    Nmin = nnz(minIndices);
    EsRecibo = Nmin >= 9;

    
    
end
