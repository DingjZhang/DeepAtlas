configure_inputrc ()
{
sudo tee /root/.inputrc <<EOF
"\e[A": history-search-backward
"\e[B": history-search-forward
set show-all-if-ambiguous on
set completion-ignore-case on
EOF
}

configure_bashrc ()
{
sudo tee /root/.bashrc <<EOF
source <(kubectl completion bash)
alias kubectl='microk8s kubectl'
alias k=kubectl
complete -o default -F __start_kubectl k
EOF
}


# config_docker_daemon
configure_inputrc
bind -f /root/.inputrc
configure_bashrc
source /root/.bashrc
source /etc/bash_completion