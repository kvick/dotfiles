alias reload!='. ~/.zshrc'

alias cls='clear' # Good 'ol Clear Screen command

alias copy_key='pbcopy < ~/.ssh/id_rsa.pub'
#alias ssp='ssh-copy-id -i ~/.ssh/id_rsa.pub nfsuper@<remote-id> -f'
alias date='/usr/local/bin/gdate'

# DayOne alias
alias dlog="ruby ~/bin/logtodayone.rb"

# edda
# test us-west-1
alias eddatw='edda -t -w $*'

# test us-west-2
alias eddatW='edda -t -W $*'
alias eddate='edda -t -e $*'

# stupid tar
alias tar='/usr/local/bin/gtar'

# Filesystem
alias ..='cd ..'            # Go up one directory
alias ...='cd ../..'        # Go up two directories
alias ....='cd ../../..'    # And for good measure
alias l='ls -lah'           # Long view, show hidden
alias lla='ls -lAF'         # Compact view, show hidden
alias ll='ls -lFh'          # Long view, no hidden
alias artsn="./art.py --verbose search -r npm-local -s 'artifacts.netflix.com' $*"

# Unstable
alias goau='ssh %artifactory,us-west-2,awsmanagementtest,unstable-v,0'
alias goaup='ssh %artifactory,us-west-2,awsmanagementtest,unstable-primary-v,0'

# Stable
alias goap='ssh %artifactory,us-west-2,awsmanagement,-stable,primary'
alias goam='ssh %artifactory,us-west-2,awsmanagement,metrics-stable,0'
alias goamu='ssh %artifactory,us-west-2,awsmanagementtest,metrics,0'

# Bastions
alias bt='ssh aws.test.netflix.net'
alias bp='ssh aws.prod.netflix.net'
alias bm='ssh aws.mgmt.netflix.net'
alias bmt='ssh aws.mgmttest.netflix.net'
alias bbp='ssh awsbuild.prod.netflix.net'
alias bbt='ssh awsbuild.test.netflix.net'

# spotify
alias spause='spotify pause'
alias splay='spotify play'

# newt
alias nbc='newt build --cache'
alias newtp="newt --app-type adhoc-debian-publisher publish $@"

alias vi='/usr/local/bin/vim'

# this is needed for zsh
alias scp='noglob scp'
alias rsync='noglob /usr/local/bin/rsync'

# Python
alias venv='source venv/bin/activate'

alias shrug='echo "¯\_(ツ)_/¯" | pbcopy'

function gojm {
  ssh -t awstest oq-ssh -r us-west-1 jenkins-${1:-opseng}-v,0
}

function getes {
  curl -XGET http://es-buildtools.us-west-1.dyntest.netflix.net:7104/${1}
}

function getet {
  curl -XGET http://es_engtools.us-west-2.dynprod.netflix.net:7104/${1}
}

sshauth() {
    if [ -z "$1" ]
    then
        echo "Missing target IP address"
    else
        ssh-copy-id -i ~/.ssh/id_rsa.pub "nfsuper@$1" -f
        cat <<EOF > /Users/kvick/.unison/default.prf
# default.prf
root = ssh://nfsuper@$1//home/nfsuper/
root = /Users/kvick/Projects/stash/artifactory
perms=0o0000
EOF
    fi
}

# calculon
alias gocalc='ssh 192.168.1.54'

# howdoi
alias h='function hdi(){ /Users/kvick/GoogleDrive/Projects/github/howdoi/venv/bin/howdoi $* -c -n 3; }; hdi'

