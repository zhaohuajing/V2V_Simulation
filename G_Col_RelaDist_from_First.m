load('Trajectory_50_vehicles_HeadingSpeed.mat');
FirstP = Position{1}(1,:);
for i=1:length(Position)
    disp(['i= ' num2str(i)]);
    NorthDist = zeros( height(Position{i}),1 );
    EastDist = zeros( height(Position{i}),1 );
    %Calculate the distance from the first point
    C_Position = Position{i};
    for j=1:length(NorthDist)
        NorthDist(j) = sign(C_Position.LatitudeWsu(j)-FirstP.LatitudeWsu)*...
            lldistkm([FirstP.LatitudeWsu,FirstP.LongitudeWsu],...
            [C_Position.LatitudeWsu(j),FirstP.LongitudeWsu])*1000;
        EastDist(j) = sign(C_Position.LongitudeWsu(j)-FirstP.LongitudeWsu)*...
            lldistkm([FirstP.LatitudeWsu,FirstP.LongitudeWsu],...
            [FirstP.LatitudeWsu,C_Position.LongitudeWsu(j)])*1000;
    end
    Position{i}.NorthDist = NorthDist;
    Position{i}.EastDist = EastDist;
end

%Check by ploting
close all;
figure(1); %The lalo
idx=1;
plot(Position{idx}.LongitudeWsu,Position{idx}.LatitudeWsu,'.');

figure(2); % The North East Dist
plot(Position{idx}.EastDist,Position{idx}.NorthDist);

