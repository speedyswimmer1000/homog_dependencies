function data = processTopics(topics,bagfile,t0)
clear rosbag_wrapper;
clear ros.Bag;

  if nargin < 3
    t0 = -1;
  end

addpath('./matlab_rosbag-0.4.1-linux64')
addpath('./navfn')

bag = ros.Bag.load(bagfile);
for topic = topics
    ind = find(ismember(bag.topics,topic),1);
    if isempty(ind)
        fprintf('Could not find topic: %s\n',topic{:});
        continue;
    end
    fprintf('   Processing topic: %s\n',topic{:});
    type = bag.topicType(topic{:});    
    [msgs, meta] = bag.readAll(topic);
    
    a = [msgs{:,:}];
    c = [meta{:,:}];
    d = [c.time];
    if t0 < 0
       t0 = d(1).time - 0.1;
    end
    clear struct
    switch type{:}
        case 'relative_nav_msgs/FilterState'
            b = [a.transform];
            struct.transform.translation = [b.translation];
            struct.transform.rotation = [b.rotation];
            struct.transform.euler = rollPitchYawFromQuaternion(struct.transform.rotation.')*180/pi;
            struct.velocity = [a.velocity];     
            struct.node_id = [a.node_id];
            struct.time = [d.time] - t0;
        case 'geometry_msgs/Transform'
            struct.transform.translation = [a.translation];
            struct.transform.rotation = [a.rotation];
            struct.transform.euler = rollPitchYawFromQuaternion(struct.transform.rotation.')*180/pi;
            struct.time = [d.time] - t0;
         case 'relative_nav_msgs/DesiredState'
            struct.pose = [a.pose];
            struct.velocity = [a.velocity];
            struct.acceleration = [a.acceleration];
            struct.node_id = [a.node_id];
            struct.time = [d.time] - t0;
        case 'relative_nav_msgs/Snapshot'
            struct.state = [a.state];
            struct.covariance = [a.covariance_diagonal];
            struct.node_id = [a.node_id];
            struct.time = [d.time] - t0; % This could also use the header time
        case 'geometry_msgs/PoseStamped'
            b = [a.pose];
            struct.pose.position = [b.position];
            struct.pose.orientation = [b.orientation];
            struct.time = [d.time] - t0;
        case 'sensor_msgs/Range'
            struct.range = [a.range];
            struct.time = [d.time] -t0; % This could also use the header time
        case 'relative_nav_msgs/VOUpdate'
            b = [a.transform];
            struct.current_keyframe_id = [a.current_keyframe_id];
            struct.valid_transformation = [a.valid_transformation];
            struct.transform.translation = [b.translation];
            struct.transform.rotation = [b.rotation];
            struct.transform.euler = rollPitchYawFromQuaternion(struct.transform.rotation.')*180/pi;
            struct.time = [d.time] -t0; % This could also use the header time
        case 'relative_nav_msgs/Command'
            struct.commands = [a];
            struct.time = [d.time] -t0; % This could also use the header time
        case 'evart_bridge/transform_plus'
            b = [a.transform];
            struct.transform.translation = [b.translation];
            struct.transform.rotation = [b.rotation];
            struct.transform.euler = rollPitchYawFromQuaternion(struct.transform.rotation.')*180/pi;
            struct.euler = [a.euler];
            struct.velocity = [a.velocity];
            struct.time = [d.time] -t0; % This could also use the header time
        case 'relative_nav_msgs/Edge'
            b = [a.transform];
            struct.transform.translation = [b.translation];
            struct.transform.rotation = [b.rotation];
            struct.transform.euler = rollPitchYawFromQuaternion(struct.transform.rotation.')*180/pi;
            struct.from_node_id = [a.from_node_id];
            struct.to_node_id = [a.to_node_id];
            struct.time = [d.time] -t0; % This could also use the header time    
        case 'nav_msgs/Odometry'
            b = [a.pose];
            c = [b.pose];
            struct.pose.position = [c.position];
            struct.pose.orientation = [c.orientation];
            struct.time = [d.time] -t0; % This could also use the header time    
        case 'geometry_msgs/Point'
            struct.point = a;
            struct.time = [d.time] -t0; % This could also use the header time      
        otherwise
            fprintf('     Type: %s not yet supported!\n',type{:});
            continue
    end
    
    % Split topic name into sections
    topic_parts = strsplit(topic{1},'/');
    topic_parts(cellfun('isempty', topic_parts)) = [];
    switch size(topic_parts,2)
        case 1
            data.(topic_parts{1}) = struct;
        case 2
            data.(topic_parts{1}).(topic_parts{2}) = struct;
        case 3
            data.(topic_parts{1}).(topic_parts{2}).(topic_parts{3}) = struct;
        case 4
            data.(topic_parts{1}).(topic_parts{2}).(topic_parts{3}).(topic_parts{4}) = struct;
        case 5
            data.(topic_parts{1}).(topic_parts{2}).(topic_parts{3}).(topic_parts{4}).(topic_parts{5}) = struct;
        otherwise
            fprintf('Too long');
    end     
end


end
