# HW4 for Reverse Engineering
This was a short homework where we tried to reverse the PwnAdventure3 binary. Currently we ended up with 3 flags, all solely through `LD_PRELOAD` injections.

# Setup

* Install PwnAdventure3 for Linux (this exploit is only tested for linux platforms)
* compile the shared library in `./exploit` with `g++ -std=c++11 -o exploit.so -Wall -fPIC -shared exploit.cpp`
* set up an environment with `LD_PRELOAD=[path to your compiled .so]`
* run PwnAdventure in the library from the "shipping" binary available in the directory structure of the linux download