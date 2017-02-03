if [ -e $HOME/.android-sdk-linux ]; then
  export ANDROID_HOME=$HOME/.android-sdk-linux
  export PATH=$PATH:$ANDROID_HOME/tools
  export PATH=$PATH:$ANDROID_HOME/platform-tools  
fi

