# put this code instead of ps1 logic in your ~/.bashrc

if [ "$color_prompt" = yes ]; then
    PS1="${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\>
    PS1+=" \$(if git rev-parse --git-dir > /dev/null 2>&1; then echo -ne \"\[\0>
    PS1+=" \[\033[01;36m\]\A\[\033[00m\]"
    PS1+=" \$(if [ -f ~/.motivational_quotes ]; then shuf -n 1 ~/.motivational_>
    PS1+="\n🚀 Sir!> "
else
    PS1="${debian_chroot:+($debian_chroot)}\u@\h:\w"
    PS1+=" \$(if git rev-parse --git-dir > /dev/null 2>&1; then echo \"\$(__git>
    PS1+=" \A"
    PS1+=" \$(if [ -f ~/.motivational_quotes ]; then shuf -n 1 ~/.motivational_>
    PS1+="\n🚀 Sir!> "
fi
