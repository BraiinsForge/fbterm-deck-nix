#!/bin/sh
# Test ANSI colors - RED should be red, BLUE should be blue
echo -e "\e[31mRED\e[0m \e[32mGREEN\e[0m \e[34mBLUE\e[0m"

# Color blocks
for i in 0 1 2 3 4 5 6 7; do echo -en "\e[4${i}m   \e[0m"; done; echo
for i in 0 1 2 3 4 5 6 7; do echo -en "\e[10${i}m   \e[0m"; done; echo
