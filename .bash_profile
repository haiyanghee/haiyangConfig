
[[ -f ~/.bashrc ]] && . ~/.bashrc

#https://stackoverflow.com/questions/18880024/start-ssh-agent-on-login
SSH_ENV="$HOME/.ssh/agent-environment"

function start_agent {
     echo "Initialising new SSH agent..."
     /usr/bin/ssh-agent | sed 's/^echo/#echo/' > "${SSH_ENV}"
     echo succeeded
     chmod 600 "${SSH_ENV}"
     source "${SSH_ENV}" > /dev/null
     /usr/bin/ssh-add;
}

# Source SSH settings, if applicable

#Fun fact:
#grep "hi$" will produce process name with literal '$' at the end of the line
#so `ps -ef | grep "hi$"` will not contain the grep that is race conditioning with the actual grep
#can confirm by running `grep "hi$"` on one terminal, and running `pgrep -a -f 'hi\$'` on the other
if [ -f "${SSH_ENV}" ]; then
     source "${SSH_ENV}" > /dev/null
     pgrep ssh-agent$ > /dev/null || {
         start_agent;
     }
else
     start_agent;
fi

if test -x ~/.scripts/startNixDaemons.sh ; then sudo ~/.scripts/startNixDaemons.sh ; fi
