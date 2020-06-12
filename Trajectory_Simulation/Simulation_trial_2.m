clc
clear all;

%% plot table
%Location and size of pool table
x=0;
y=0;
% standard 8 feet pool table has playing surface of 88 inches by 44 inches
% convert all dimensions to SI units
l=2.2352;
w=l/2;
% standrad ball radius (diameter of 2.25 inches)
r=0.05715/2;
% standard width of corner pocket is 11.4-11.7 cm (1.75-2.25 twice of
% standard ball size)
% standard width of side pocket is 12.7-13.3 cm
% assume side pockets have same size as corner pockets
r_pocket=r*4;
pos=[x,y,l,w];

%position of pockets 
p1 = circle(0,w,r_pocket,'g');
p2=  circle(w,w,r_pocket,'g');
p3=  circle(l,w,r_pocket,'g');
p4=  circle(0,0,r_pocket,'g');
p5=  circle(w,0,r_pocket,'g');
p6=  circle(l,0,r_pocket,'g');

%position of stable points
% stable point for corner pockets defined to lie on circimference of circle
% stable point for side pockets defined as 1/3 of radius below or above
% table perimeter
s1=[0+r_pocket*cos(pi/4),w-r_pocket*cos(pi/4)];
s2=[w,w-(1/3)*r_pocket];
s3=[l-r_pocket*cos(pi/4),w-r_pocket*cos(pi/4)];
s4=[0+r_pocket*cos(pi/4),0+r_pocket*cos(pi/4)];
s5=[w,0+(1/3)*r_pocket];
s6=[l-r_pocket*cos(pi/4),0+r_pocket*cos(pi/4)];

% x and y coordinates of stable points
x_of_stable=[s1(1),s2(1),s3(1),s4(1),s5(1),s6(1)];
y_of_stable=[s1(2),s2(2),s3(2),s4(2),s5(2),s6(2)];

% draw region 2 and 5 for side pockets 

x_region2=[1,1+2*r_pocket,w+0.5,w-0.5];
y_region2=[0,0,w/2,w/2];
x_region5=[1,1+2*r_pocket,w+0.5,w-0.5];
y_region5=[w,w,w/2,w/2];


% plot table, pockets, stable points
figure(1);
rectangle('Position',pos,'Facecolor','green');
hold on
region2=patch(x_region2,y_region2,'r');
region5=patch(x_region5,y_region5,'y');
plot(x_of_stable,y_of_stable,'.');
axis equal
grid on

%%

% draw target ball at center of table 
target_ball= circle(l/2,w/2,r,'black');

target_moving_path=zeros(100,2);
increment_target=linspace(0,(l/2)-(r),100);
target_moving_path(:,2)=[w/2];

%draw cue ball at 2/3 of length
cue=circle(2*l/3,w/2,r,'w');

cue_moving_path=zeros(100,2);
increment_cue=linspace(0,0.5,100);
cue_moving_path(:,2)=[w/2];

% cue_circum=scircle1(1,1,1);

for i=1:100
    
    cue_moving_path(i,1)=[2*l/3-increment_cue(i)];
    target_moving_path(i,1)=[1.6*l/2-increment_target(i)];

end

% animation of moving cue ball
for i = 1:size(cue_moving_path,1)
    
    if cue_moving_path(i,1)> (l/2)+(2*r)

cue=circle(cue_moving_path(i,1),cue_moving_path(i,2),r,'w'); 
      drawnow
      
    else
%         break
 target=circle(target_moving_path(i,1),target_moving_path(i,2),r,'black'); 
      drawnow
          
    end
end
fprintf('collision')

%     if cue_moving_path(i,1)> (l/2)+r 
%         
%         for i = 1:size(cue_moving_path,1)
%             cue=circle(cue_moving_path(i,1),cue_moving_path(i,2),r,'w'); 
%             drawnow
%                 
%         end
%         
%      else
%         fprintf('collision'); 
%         
%     end
    

