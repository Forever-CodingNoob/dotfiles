# Default OMZ theme for Archcraft

if [[ "$USER" == "root" ]]; then
  PROMPT="%(?:%{$fg_bold[red]%}%{$fg_bold[yellow]%}%{$fg_bold[red]%} :%{$fg_bold[red]%} )"
  PROMPT+='%{$fg[cyan]%}  %~%{$reset_color%} $(virtualenv_prompt_info)$(git_prompt_info)'
else
  PROMPT="%(?:%{$fg_bold[red]%}%{$fg_bold[green]%}%{$fg_bold[yellow]%} :%{$fg_bold[red]%} )"
  PROMPT+='%{$fg[cyan]%}  %~%{$reset_color%} $(virtualenv_prompt_info)$(git_prompt_info)'
fi

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[blue]%} git:(%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}) %{$fg[yellow]%}✗"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%})"

ZSH_THEME_VIRTUALENV_PREFIX="%{$fg_bold[green]%} ["
ZSH_THEME_VIRTUALENV_SUFFIX="]%{$reset_color%} "
