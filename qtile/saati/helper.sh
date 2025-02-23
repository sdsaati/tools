#!/usr/bin/env bash
# =========== Variables ===============
folder_of_script=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
main_folder="$folder_of_script/../.."
# ========== Applications =============
log_path=""
if [[ "$(basename "$0")" == "startup" ]]; then
  log_path="$folder_of_script/startup.log"
elif [[ "$(basename "$0")" == "startup_once" ]]; then
  log_path="$folder_of_script/startup_once.log"
else
  log_path="$folder_of_script/startup_tests.log"
  echo "You are running this script outside of startup or startup.once"
fi
# ============ Startup ================
function msg {
  $(which notify-send) "$*" 2>/dev/null
}
function clearLog
{
  rm "$log_path" 2>/dev/null
}
function runAsRoot
{ 
  if ! pgrep -f "$1" ; then
    # Get the path of the first argument using 'which'
    command_path=$(which "$1") 
    # If the command exists, reorder the arguments
    if [[ -n "$command_path" ]]; then
      # Shift the arguments so the second argument becomes the first
      shift
      # Reconstruct the command with the full path of the first argument
      echo -en "\n===========\n \
        running command \"$(which pkexec) --keep-cwd $command_path \"$@\" 2>>$log_path\" \
        \n===========\n" >> "$log_path"
      eval "$(which pkexec) --keep-cwd $command_path \"\"$@\"\"" 2>>$log_path & # disown
    else
      echo "(ERROR) Command '$1' not found." >> $log_path
    fi
  fi
}
function run
{
  if ! pgrep -f "$1" ; then
    # Get the path of the first argument using 'which'
    command_path=$(which "$1")
    
    # If the command exists, reorder the arguments
    if [[ -n "$command_path" ]]; then
      # Shift the arguments so the second argument becomes the first
      shift
      # Reconstruct the command with the full path of the first argument
      echo -en "\n===========\n \
        running command \"$command_path $* 2>>$log_path & \"\
        \n===========\n" >> "$log_path"
      eval "$command_path $* 2>>$log_path & " #disown
    else
      echo "(ERROR) Command '$1' not found." >> $log_path
    fi
  fi
}
