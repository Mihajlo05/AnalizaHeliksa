function intensityOut = vec_intensity(vec)
    %calculates intensity of a vector (it's moduo)
    
    intensityOut = sqrt(sum(vec.^2));

end