function q = convertangle(theta_x,theta_y,theta_z)

%convert from degree to radian
theta_x = degtorad(theta_x);
theta_y = degtorad(theta_y);
theta_z = degtorad(theta_z);

q_original = [0,0,1,0]; %the initial quaternion for the end effector
q_rotation = angle2quat(theta_x,theta_y,theta_z,'XYZ'); %convert rotation angle to quaternion in x,y,z order

q = quatmultiply(q_rotation,q_original); %multiply q_rotation and q_original to get the final orientation