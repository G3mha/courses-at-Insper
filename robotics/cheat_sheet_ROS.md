# ROS Cheat Sheet

## Quick Reference

1. Workflow: URDF, joint axis test, plugins addition (sensors in Rviz), simulations set (create physical elements Gazebo)

2. ROS Resource and Tutorials: [ROS Wiki](http://wiki.ros.org/ROS/Tutorials)

3. Check what version of ROS you are using: `rosversion -d`

4. If you change the ROS version (between 1 and 2) in the bashrc file, you need to run `source ~/.bashrc` to update the changes.

5. Suggested VSCode Extensions:
    - ROS
    - ROS Snippets
    - Python
    - XML
    - XML Tools

## ROS Publisher and Subscriber (PubSub)

While the Publisher sends data, the Subscriber receives data. The Publisher and Subscriber are connected through a topic. The topic is a channel where the data is sent and received. Meanwhile, the message is the data that is sent and received. The message types can be the following (depending on the topic): String, Int, Float, Bool, etc.

- Checking a topic: `rostopic list`
- Checking a topic type: `rostopic type <topic_name>`
- Checking a topic publisher: `rostopic info <topic_name>`
- Checking a topic messages: `rostopic echo <topic_name>`
- Checking a message type: `rosmsg show <message_type>`
- Checking a message fields: `rosmsg info <message_type>`
- Control the robot: `roslaunch teleop_twist_keyboard teleop_twist_keyboard.launch`

### cmd_vel

The cmd_vel topic is used to send velocity commands to the robot. The message type is Twist.
*Twist is an array of 2 vectors, linear and angular, both with coordinates in 3D (x,y,z)*

Tip: Stop the robot instantly (via terminal)
`rostopic pub -1 /cmd_vel geometry_msgs/Twist -- '[0.0, 0.0, 0.0]' '[0.0, 0.0, 0.0]'`

## Rviz

Rviz is a 3D visualization tool for ROS. It is used to visualize the robot model, the robot state, and sensor data. Basically, it is limited to the robot's knowledge.

## Gazebo

Gazebo is a 3D dynamic simulator with the ability to accurately and efficiently simulate populations of robots in complex indoor and outdoor environments. It is used to simulate the robot's behavior in the real world.

## File Structure

-  Workspace: a directory containing all the ROS packages that you are currently working on. *You can have multiple workspaces on the same computer*.

- Package: a directory containing all the files related to a specific task. There a several types of packages available for download (developed by the open-source community): executable, libraries, messages, services, etc. *You can share packages between workspaces*.

### Create a workspace

Open up the terminal and type the following command:

```bash
ls -a
code .bashrc
```

Paste the following lines at the end of the file:

```bash
source /opt/ros/noetic/setup.bash
```

Go back to the terminal and type the following command:

```bash
mkdir -p ~/catkin_ws/src
cd ~/catkin_ws/
catkin_make
```

### Create a package

Go to the source folder of your workspace and type the following command (replace `<package_name>` with the name of your package and `[depend1] [depend2] [depend3]` with the dependencies of your package):

```bash
cd ~/catkin_ws/src
catkin_create_pkg <package_name> [depend1] [depend2] [depend3]
```

## Making a robot

### URDF

Universal Robot Description Format (URDF) is an XML file format used in ROS to describe all elements of a robot. It is used by robot_state_publisher to publish the state of the robot to tf, and by the robot_model and robot_state to represent the robot.

### Customizing robot design in URDF

Questions to ask yourself:

1. What is the robot type? (e.g. mobile, manipulator, etc.)

2. What are the joint types? (e.g. revolute, prismatic, continuous, fixed, etc.) - *Joints are not apperent since they are imaginary*.

3. What are the link lenghts (parts that compose the robot)? (geometrical, physical and color properties) - *Links are apperent since they are physical*.

4. What is the total footprint of the robot? (e.g. box size, cylinder size, mesh size, etc.)


## Lauching Rviz with robot model

1. You should source your ws setup.sh file

```bash
roslaunch explorer_bot rviz_explorer_bot.launch
rosrun joint_state_publisher joint_state_publisher
```

or 

```bash
roscore
rosrun rviz rviz
```

### ROS Commands Insights

The difference between `rosrun` and `roslaunch` is that `rosrun` runs a single node, while `roslaunch` runs multiple nodes.
