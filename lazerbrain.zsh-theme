function collapse_pwd {
        echo $(pwd | sed -e "s,^$HOME,~,")
}

function prompt_char {
        git branch >/dev/null 2>/dev/null && echo '±' && return
            hg root >/dev/null 2>/dev/null && echo '☿' && return
                echo '○'
}

function battery_charge {
        echo `$BAT_CHARGE` 2>/dev/null
}

function virtualenv_info {
        [ $VIRTUAL_ENV ] && echo '('`basename $VIRTUAL_ENV`') '
}

function hg_prompt_info {
        hg prompt --angle-brackets "\
        < on %{$fg[magenta]%}<branch>%{$reset_color%}>\
        < at %{$fg[yellow]%}<tags|%{$reset_color%}, %{$fg[yellow]%}>%{$reset_color%}>\
        %{$fg[green]%}<status|modified|unknown><update>%{$reset_color%}<
        patches: <patches|join( → )|pre_applied(%{$fg[yellow]%})|post_applied(%{$reset_color%})|pre_unapplied(%{$fg_bold[black]%})|post_unapplied(%{$reset_color%})>>" 2>/dev/null
}

local ret_status="%(?:%{$fg_bold[green]%}➜ :%{$fg_bold[red]%}➜ %s)"
PROMPT='${ret_status}%{$fg_bold[green]%}%p %{$fg[cyan]%}%M %{$fg_bold[blue]%} %{$fg_bold[blue]%} % %{$reset_color%} $(collapse_pwd)%{$reset_color%}$(hg_prompt_info)$(git_prompt_info)
$(virtualenv_info) $(prompt_char) '

RPROMPT='$(battery_charge)'

ZSH_THEME_GIT_PROMPT_PREFIX="git:(%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}) %{$fg[yellow]%}✗%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[green]%}?"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%})"
