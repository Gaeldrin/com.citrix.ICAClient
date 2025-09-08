#!/bin/bash

# If Workspace doesn't close cleanly it can hang the next time you try to run it, clearing out the temp directory prevents hanging in this scenario.
if [[ -d $HOME/.ICAClient/.tmp ]]; then
    rm -r $HOME/.ICAClient/.tmp
fi

# Add binaries to its path
PATH=/app/ICAClient:$PATH

# Start the Citrix logging service
/app/ICAClient/util/ctxcwalogd

if [ $# -eq 0 ]
  then
    # No arguments: start the Workspace self-service dashboard
    selfservice
  else
    first_arg="$1"

    # Handle double-click or manual file open
    # Strip "file://" prefix if present
    first_arg="${first_arg#file://}"

    if [[ "$first_arg" == *.ica && -f "$first_arg" ]]; then
        # Open ica files with wfica
        wfica "$first_arg"
    else
        # Otherwise, run given binary + params
        "$@"
    fi
fi

# This services seems to (sometimes) get started when launching Workspace. It's stubborn and requires SIGKILL to stop.
if [[ ! -z $(ps -e | grep UtilDaemon) ]]; then
    pkill --signal 9 UtilDaemon
fi

# Kill the rest of the services that were started, so the Flatpak container itself stops running once you close Workspace.
for process in AuthManagerDaem ServiceRecord ctxlogd icasessionmgr; do
    pkill $process
done

exit
