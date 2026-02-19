alias nnn = nnn -de -P p
alias paru = paru --color=always --devel --sudoloop
alias ip = ip -c
alias grep = grep --color=always
alias rm = trash
alias rg = rg -S
alias less = less -R
alias tree = tree -C
alias hx = helix
alias playbell = paplay /usr/share/sounds/freedesktop/stereo/complete.oga
alias cdd = cd ($env.HOME | path join dev )
alias "mamba activate" = conda activate
alias "mamba deactivate" = conda deactivate

def ll [] {
    let dirs = ls -a | where type == dir | sort-by --natural name
    let others = ls -a | where type != dir | sort-by --natural name
    $dirs | append $others
}

def ssh [] {
    TERM=xterm-256color ^ssh
}

def get_git_current_branch [] {
    let branch = ^git rev-parse --abbrev-ref HEAD | sed 's/HEAD/detached/' | complete
    $branch.stdout | str trim
}

def get_git_default_branch [] {
    let branch = ^git rev-parse --abbrev-ref origin/HEAD | complete
    if $branch.exit_code == 0 {
        if $branch.stdout == "" {
            ^git remote set-head origin -a
            branch = ^git rev-parse --abbrev-ref origin/HEAD | complete
        }
        $branch.stdout | cut -c8- | str trim
    }
}

def --wrapped git [...args: string] {
    if (($args | length) != 0 and $args.0 == "log") {
        let branch = get_git_current_branch
        let default_branch = get_git_default_branch

        if $branch != "" {
            if $branch == $default_branch {
                ^git logg ...($args | skip 1)
            } else {
                ^git logg ([$default_branch, '..'] | str join) ...($args | skip 1)
            }
        }
    } else {
        ^git ...$args
    }
}
