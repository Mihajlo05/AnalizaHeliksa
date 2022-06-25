%For applying quaternions for rotation
%Use rotatepoint function that exists in MatLab
%instead of manually applying q * vec * q^-1

function quater = rot_quat(axis, angle)
%ROT_QUAT returns quaternion based on axis of rotation
%and angle

half_angle = angle / 2;

cosine = cos(half_angle);
sine = sin(half_angle);

quater = quaternion(cosine, sine * axis(1), sine * axis(2), sine * axis(3));

end

