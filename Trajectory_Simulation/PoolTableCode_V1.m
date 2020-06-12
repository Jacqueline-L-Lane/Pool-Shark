clc;
clear all;

rng('shuffle')
%% plot table
%Location and size of pool table
x=0;
y=0;
% standard 8 feet pool table has playing surface of 88 inches by 44 inches
% convert all dimensions to SI units
l=2.2352;
% l=4;
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
p1 = circle(0,w,r_pocket,(1/255)*[152,191,100]);
p2=  circle(w,w,r_pocket,(1/255)*[152,191,100]);
p3=  circle(l,w,r_pocket,(1/255)*[152,191,100]);
p4=  circle(0,0,r_pocket,(1/255)*[152,191,100]);
p5=  circle(w,0,r_pocket,(1/255)*[152,191,100]);
p6=  circle(l,0,r_pocket,(1/255)*[152,191,100]);

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

% stable points consolidated
pocket=[s1;s2;s3;s4;s5;s6];

% x and y coordinates of stable points
x_of_stable=[s1(1),s2(1),s3(1),s4(1),s5(1),s6(1)];
y_of_stable=[s1(2),s2(2),s3(2),s4(2),s5(2),s6(2)];

% % draw region 2 and 5 for side pockets 
% 
% x_region2=[1,1+2*r_pocket,w+0.5,w-0.5];
% y_region2=[0,0,w/2,w/2];
% x_region5=[1,1+2*r_pocket,w+0.5,w-0.5];
% y_region5=[w,w,w/2,w/2];


% plot table, pockets, stable points
figure(1);
rectangle('Position',pos,'Facecolor','#98BF64');
hold on
% region2=patch(x_region2,y_region2,'r');
% region5=patch(x_region5,y_region5,'y');
plot(x_of_stable,y_of_stable,'*','MarkerSize', 5,'Color','black');
axis equal
grid on


%% generate random positions of 16 balls (7 stripes, 7 solid, black, and cue)
tic
spacing=1; %balls are interfering with each other 

while spacing==1

ball=zeros(16,2);
x_ball=(0+r) + ((l-r)-(0+r)).*rand(16,1);
y_ball=(0+r) + (((l/2)-r)-(0+r)).*rand(16,1);

for j=1:16-1
    overlap_x= abs(x_ball(j)-x_ball(j+1:end))<1.1*r; % check if they overlap by 1.15r but it should be 2r but code takes too long to run
    overlap_y= abs(y_ball(j)-y_ball(j+1:end))<1.1*r;
    if (ismember(1,overlap_x) || ismember(1,overlap_y))
        spacing=1;
        break
    else
        spacing=0;
    end
     
end

end

for j=1:16
    
ball(j,1)=x_ball(j);
ball(j,2)=y_ball(j);
end

plot(ball(:,1),ball(:,2),'.')

cue=[ball(1,:)];
black=[ball(2,:)];
ball_minus_cue=[ball(2:16,:)];
stripe= [ball(3:9,:)];
solid= [ball(10:16,:)];

toc 
t=toc


%% plot balls on pool table

cue_ball=circle(cue(1),cue(2),r,'white');
hold on
black_ball=circle(black(1),black(2),r,'black');
%striped balls
stripe_ball_1=circle(stripe(1,1),stripe(1,2),r,'red');
stripe_ball_2=circle(stripe(2,1),stripe(2,2),r,'yellow');
stripe_ball_3=circle(stripe(3,1),stripe(3,2),r,'blue');
stripe_ball_4=circle(stripe(4,1),stripe(4,2),r,(1/255)*[128,0,128]);
stripe_ball_5=circle(stripe(5,1),stripe(5,2),r,(1/255)*[255,165,0]);
stripe_ball_6=circle(stripe(6,1),stripe(6,2),r,'green');
stripe_ball_7=circle(stripe(7,1),stripe(7,2),r,(1/255)*[128,0,32]);
plot(ball(:,1),ball(:,2),'.','MarkerSize', 5,'Color','white')

%solid balls
solid_ball_1=circle(solid(1,1),solid(1,2),r,'red');
solid_ball_2=circle(solid(2,1),solid(2,2),r,'yellow');
solid_ball_3=circle(solid(3,1),solid(3,2),r,'blue');
solid_ball_4=circle(solid(4,1),solid(4,2),r,(1/255)*[128,0,128]);
solid_ball_5=circle(solid(5,1),solid(5,2),r,(1/255)*[255,165,0]);
solid_ball_6=circle(solid(6,1),solid(6,2),r,'green');
solid_ball_7=circle(solid(7,1),solid(7,2),r,(1/255)*[128,0,32]);

%% Measure distances between cue to ball 
friend=solid;

cue_to_ball_dist=zeros(7,1);

%check for ball interference and measure distance

for i=1:7
    
    P1 = cue;  % Point 1 of the line
    P2 = [solid(i,1), solid(i,2)];    % Point 2 of the line
    R  = r;         % Radius of circle
    P12 = P2 - P1;
    N   = P12 / norm(P12);  % Normalized vector in direction of the line
    
    for j=1:15
        
        C  = [ball_minus_cue(j,1), ball_minus_cue(j,2)]; % Center of circle
        if C~=P2
            
            %analysis for intersection with infinite line
            P1C = C - P1;           % Line from one point to center
            v   = abs(N(1) * P1C(2) - N(2) * P1C(1));  % Norm of the 2D cross-product
            doIntersect = (v <= 2*R);
            
            %analysis for lying within the 2 points of line segment
            length_line_segment=norm(P12);
            dist_cue2testBall=norm(cue-(ball_minus_cue(j,:)));
            dist_solid2testBall=norm((solid(i,:))-(ball_minus_cue(j,:)));
            withinSegment= (dist_cue2testBall<length_line_segment) && (dist_solid2testBall<length_line_segment)
            
            if (doIntersect==1 && withinSegment==1) ;
                cue_to_ball_dist(i,:)=9999;
                break
            else
                cue_to_ball_dist(i,:)= norm(cue-(solid(i,:)));
            end
            
            
        end
    end
end


%% Measure distances between each solid ball to pocket
ball_to_pocket_dist=zeros(7,6);
%reset counter 
doIntersect=0;


%check for ball interference and measure distance

for i=1:7
    for j=1:6


    P1 = [solid(i,1), solid(i,2)];  % Point 1 of the line
    P2 = [pocket(j,1), pocket(j,2)];    % Point 2 of the line
    R  = r;         % Radius of circle
    P12 = P2 - P1;
    N   = P12 / norm(P12);  % Normalized vector in direction of the line
    
    for m=1:16
        
        C  = [ball(m,1), ball(m,2)]; % Center of circle
        if C~=P1
            
            %analysis for intersection with infinite line
            P1C = C - P1;           % Line from one point to center
            v   = abs(N(1) * P1C(2) - N(2) * P1C(1));  % Norm of the 2D cross-product
            doIntersect = (v <= 2*R);
            
            %analysis for lying within the 2 points of line segment
            length_line_segment=norm(P12);
            dist_pocket2testBall=norm(pocket(j,:)-(ball(m,:)));
            dist_solid2testBall=norm((solid(i,:))-(ball(m,:)));
            withinSegment= (dist_pocket2testBall<length_line_segment) && (dist_solid2testBall<length_line_segment)
            
            if (doIntersect==1 && withinSegment==1) 
                   ball_to_pocket_dist(i,j)= 9999;
                   break
            else
                   ball_to_pocket_dist(i,j)= norm((solid(i,:))-pocket(j,:));
            end
            
            
        end
    end
        end
    
end

%% Optimization 
%calculate total travelling distance and choose minimum distance 

total_dist=zeros(7,6);

for i=1:6
   
    total_dist(:,i)=ball_to_pocket_dist(:,i) + cue_to_ball_dist(:,1);
    
end

   %test how many shots are avaiable now 
   count_f1=0;
   for i=1:7
       for j=1:6
           
           if total_dist(i,j)< 9999
               count_f1=count_f1+1;
           end
       end
   end
   
   %% Filter 2: remove pockets within angle spectrum of shooting (-45 to 45)
   
   
   for i=1:7
       for j=1:6
           
           
           if total_dist(i,j)< 9999
               %Analysis 
               P1=cue;
               P2=solid(i,:);
               

x = [P1(1),P2(1)];
y = [P1(2),P2(2)];

% create a matrix of these points
v = [x;y];
% choose solid ball to be the center of rotation
x_center = x(2);
y_center = y(2);
% create a matrix which will be used later in calculations
center = repmat([x_center; y_center], 1, length(x));


% define a -135 degree counter-clockwise rotation matrix
theta = -(180-48.6)*pi/180 ;     
R = [cos(theta) -sin(theta); sin(theta) cos(theta)];
% do the rotation...
% s = v - center;     % shift points in the plane so that the center of rotation is at the origin
% so = R*s;           % apply the rotation about the origin
% vo = so + center;   % shift again so the origin goes back to the desired center of rotation
% this can be done in one line as:
vo = R*(v - center) + center;
% extend line twice as long 
vo(:,1)= vo(:,1) + (vo(:,1)-[x_center;y_center])*4;
line_a=vo;
% pick out the vectors of rotated x- and y-data
% x_rotated1 = vo(1,:);
% y_rotated1 = vo(2,:);
% % make a plot
% plot(x, y, 'k-', x_rotated1, y_rotated1, 'r-', x_center, y_center, 'bo');



% define a 135 degree counter-clockwise rotation matrix
theta = (180-48.6)*pi/180 ;     
R = [cos(theta) -sin(theta); sin(theta) cos(theta)];
% do the rotation...
% s = v - center;     % shift points in the plane so that the center of rotation is at the origin
% so = R*s;           % apply the rotation about the origin
% vo = so + center;   % shift again so the origin goes back to the desired center of rotation
% this can be done in one line as:
vo = R*(v - center) + center;
% extend line twice as long 
vo(:,1)= vo(:,1) + (vo(:,1)-[x_center;y_center])*4;
line_b=vo;
% pick out the vectors of rotated x- and y-data
% x_rotated2 = vo(1,:);
% y_rotated2 = vo(2,:);
% % make a plot
% plot(x, y, 'k-', x_rotated2, y_rotated2, 'r-', x_center, y_center, 'bo');
            
               
% form a polygon to define search area 
polygonx = [line_a(1,:),line_b(1,:)];
polygony = [line_a(2,:),line_b(2,:)];
k = convhull(polygonx,polygony); 
% plot(polygonx(k),polygony(k),'r-','linewidth',3)



% Find stable points of pockets inside the polygon: 
x_stable=pocket(j,1);
y_stable=pocket(j,2);
in = inpolygon(x_stable,y_stable,polygonx(k),polygony(k)); 

if in ~=1
    total_dist(i,j)=9999;
    
end

% plot(randx(in),randy(in),'ro')



               
           end
           
           
           
           
       end
   end
   
      %test how many shots are avaiable now 
   count_f2=0;
   for i=1:7
       for j=1:6
           
           if total_dist(i,j)< 9999
               count_f2=count_f2+1;
           end
       end
   end
   
   %% filter 3 : choose the minimum distance shot 
   
minimum = min(min((total_dist)));
   [hitBall,hitPocket]=find(total_dist==minimum)
   
   count_f1
   count_f2
   
   
