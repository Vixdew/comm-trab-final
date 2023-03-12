function [distance] = get_absolute_distance_between_complex_points(point_one, point_two)
    distance = sqrt(...
        (imag(point_one)-imag(point_two))^2+...
        (real(point_one)-real(point_two))^2);
end