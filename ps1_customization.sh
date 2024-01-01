# put this code instead of ps1 logic in your ~/.bashrc
# use ~/.motivational_quotes to keep youself motivated

# Color Prompt Setup
if [ "$color_prompt" = yes ]; then
    PS1="${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]"
    PS1+=" \$(if git rev-parse --git-dir > /dev/null 2>&1; then echo -ne \"\[\033[01;33m\]\$(__git_ps1 ' (%s)')\[\033[00m\]\"; fi)"
    PS1+=" \[\033[01;36m\]\A\[\033[00m\]"
    PS1+=" \$(if [ -f ~/.motivational_quotes ]; then shuf -n 1 ~/.motivational_quotes; else echo 'Stay motivated!'; fi)"
    PS1+="\n🚀 Sir!> "
else
    PS1="${debian_chroot:+($debian_chroot)}\u@\h:\w"
    PS1+=" \$(if git rev-parse --git-dir > /dev/null 2>&1; then echo \"\$(__git_ps1 ' (%s)')\"; fi)"
    PS1+=" \A"
    PS1+=" \$(if [ -f ~/.motivational_quotes ]; then shuf -n 1 ~/.motivational_quotes; else echo 'Stay motivated!'; fi)"
    PS1+="\n🚀 Sir!> "
fi
