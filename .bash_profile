# Add `~/bin` to the `$PATH`
export PATH="$HOME/bin:$PATH";

# Load the shell dotfiles, and then some:
# * ~/.path can be used to extend `$PATH`.
# * ~/.extra can be used for other settings you don’t want to commit.
for file in ~/.{path,bash_prompt,exports,aliases,functions,extra}; do
    [ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob;

# Append to the Bash history file, rather than overwriting it
shopt -s histappend;

# Autocorrect typos in path names when using `cd`
shopt -s cdspell;

# Enable some Bash 4 features when possible:
# * `autocd`, e.g. `**/qux` will enter `./foo/bar/baz/qux`
# * Recursive globbing, e.g. `echo **/*.txt`
for option in autocd globstar; do
    shopt -s "$option" 2> /dev/null;
done;

# For performance moving bash set up (like completions) to a delayed command
# https://superuser.com/a/418112
trap 'delayed ; trap USR1' USR1
{ sleep 0.1 ; builtin kill -USR1 $$ ; } & disown

# This seems to get delayed quite a bit, so might press control+C to send signal
function delayed {
    # Add tab completion for many Bash commands
    if which brew &> /dev/null && [ -r "$(brew --prefix)/etc/profile.d/bash_completion.sh" ]; then
        # Ensure existing Homebrew v1 completions continue to work
        export BASH_COMPLETION_COMPAT_DIR="$(brew --prefix)/etc/bash_completion.d";
        source "$(brew --prefix)/etc/profile.d/bash_completion.sh";
    elif [ -f /etc/bash_completion ]; then
        source /etc/bash_completion;
    fi;

    # Enable tab completion for `g` by marking it as an alias for `git`
    if type _git &> /dev/null; then
        complete -o default -o nospace -F _git g;
    fi;
    # Above one seems to not be working anymore, alternative copy to ~/.git-completion.bash
    # from place like /opt/homebrew/Cellar/git/2.34.1/etc/bash_completion.d
    source ~/.git-completion.bash
    __git_complete g __git_main

    # Add tab completion for SSH hostnames based on ~/.ssh/config, ignoring wildcards
    [ -e "$HOME/.ssh/config" ] && complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2- | tr ' ' '\n')" scp sftp ssh;

    # Add tab completion for `defaults read|write NSGlobalDomain`
    # You could just use `-g` instead, but I like being explicit
    complete -W "NSGlobalDomain" defaults;

    # Add `killall` tab completion for common apps
    complete -o "nospace" -W "Contacts Calendar Dock Finder Mail Safari iTunes SystemUIServer Terminal Twitter" killall;

    # Add tab completion for awscli
    complete -C aws_completer aws

    # Add autojump (j)
    [[ -s $(brew --prefix)/etc/profile.d/autojump.sh ]] && . $(brew --prefix)/etc/profile.d/autojump.sh

    # Not used anymore
    # . "/usr/local/opt/nvm/nvm.sh"
}
