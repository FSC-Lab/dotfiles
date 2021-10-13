alias rosmaster="roscore"

alias rlch="roslaunch"
alias xlch="xterm -e roslaunch"
alias rrun="rosrun"

alias rn='rosnode list'
alias rni='rosnode info'

alias rpl='rospack list'
alias rpf='rospack find'

alias rte='rostopic echo'
alias rtf='rostopic find'
alias rti='rostopic info'
alias rtl='rostopic list'
alias rtt='rostopic type'

alias rsarg='rosservice args'
alias rsf='rosservice find'
alias rsi='rosservice info'
alias rsl='rosservice list'
alias rsc='rosservice call'
alias rst='rosservice type'

alias rkill='killall rosmaster roscore'
alias gkill='killall gzserver gzclient'
# alias simkill = 'rkill && gkill'

if command -v colcon >/dev/null 2>&1; then
  buildtool='colcon'
  alias rhome='echo $CMAKE_PREFIX_PATH | cut -d ':' -f 1 | sed "s/\/install.*//; s/\/opt\/ros\/.*//g"'
  alias rsource='unset CMAKE_PREFIX_PATH && source ./install/local_setup.zsh'
elif command -v catkin >/dev/null 2>&1; then
  buildtool='catkin'
  alias rhome='echo $CMAKE_PREFIX_PATH | cut -d ':' -f 1 | sed "s/\/devel.*//; s/\/opt\/ros\/.*//g"'
  alias rsource='unset CMAKE_PREFIX_PATH && source ./devel/setup.zsh'
fi

if [ -n "${buildtool+x}" ]; then
  # If the path that remains after cut is /opt/ros/distro, sed will wipe out that path, preventing the user from cd-ing into the system ROS installation

  cbld() {
    cd "$(rhome)" && "$buildtool" build "$@" && cd -
  }
  
  ctst() {
    cd "$(rhome)" && "$buildtool" test "$@" && cd -
  }

  ccln() {
    cd "$(rhome)" && rm -r build devel install log && cd -
  }

  if [ "$buildtool" = 'colcon' ] ; then
  alias cbldm='cbld --merge-install'
  alias cblds='cbld --symlink-install'
  alias cbldms='cbld --merge-install --symlink-install'
  fi
fi

if [ -f "/etc/debian_version" ]; then
  rinstall() {
    if [ "$(lsb_release -sc)" = 'focal' ]; then
      sudo apt-get install ros-noetic-"$*"
    elif [ "$(lsb_release -sc)" = 'bionic' ]; then
      sudo apt-get install ros-melodic-"$*"
    elif [ "$(lsb_release -sc)" = 'xenial' ]; then
      sudo apt-get install ros-kinetic-"$*"
    fi
  }

  rremove() {
    if [ "$(lsb_release -sc)" = 'focal' ]; then
      sudo apt-get remove ros-noetic-"$*"
    elif [ "$(lsb_release -sc)" = 'bionic' ]; then
      sudo apt-get remove ros-melodic-"$*"
    elif [ "$(lsb_release -sc)" = 'xenial' ]; then
      sudo apt-get remove ros-kinetic-"$*"
    fi
  }
fi
