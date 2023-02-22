#!/bin/zsh

# Use this as an audit script when you want a script to
# only run if Liftoff is running
# Configure your script as the remediation script

if pgrep -q "Liftoff"; then
 echo "Liftoff is running, the remediation script will run next"
 exit 1
else
 echo "Liftoff is not running, no remediation needed"
 exit 0
fi