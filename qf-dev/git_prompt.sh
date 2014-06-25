_custom_git_ps1() {
    local none='\[\033[00m\]'
    local g='\[\033[0;32m\]'
    local c='\[\033[0;36m\]'
    local emy='\[\033[1;33m\]'
    local br='\[\033[1;41m\]'

    local uc=$none
    local p='$'
    if [ $UID -eq "0" ] ; then
        uc=$CBR
        p='#'
    fi
    local u="${uc}${debian_chroot:+($debian_chroot)}\u${none}"
    local h="${c}\h${none}:${g}\W${none}"
    echo "$u@$h\$(__git_ps1 '[${emy}%s${none}]')${uc}${p}${none} "
}

export PS1=$(_custom_git_ps1)