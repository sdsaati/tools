#!/bin/bash

# ---------------------------------------
homedir="/home/user"
localprj="${homedir}/projects/bababadi/"
#excludeRootDir="e/user/projects/bababadi" # this path doesn't have /home/
excludes=".env, *.sh, .git/*"
# ---------------------------------------
remotedir="/home/momoradi"
# ---------------------------------------


function sendThis(){
    #(e.g. for directories 755 and files 644) --chmod=Du=rwx,Dg=rx,Do=rx,Fu=rw,Fg=r,Fo=r, rather than the "D755,F644" format.
    rsync -arvzh --no-owner --no-group --chmod=Du=rwx,Dg=rwx,Do=rx,Fu=rwx,Fg=rw,Fo=r  --exclude={.env,*.sh,*.sql,*.vim,*.zip,.git/*} --progress "${localprj}" root@136.243.160.136:${remotedir}
}
function recvThis(){
    echo "recv"
}

echo -e "What do you want to do now? (1/2)\n[\n\t1: Send the files to the remote server\n\t2: Get the files from remote server\n]"
read enteredNumber
if [ "${enteredNumber}" == 1 ]; then
    sendThis
elif [ "${enteredNumber}" == 2 ]; then
    recvThis
else
    echo 'do nothing'
fi
