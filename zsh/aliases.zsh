alias reload!='. ~/.zshrc'

alias cls='clear' # Good 'ol Clear Screen command

alias copy_key='pbcopy < ~/.ssh/id_rsa.pub'
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
alias la='ls -AF'           # Compact view, show hidden
alias lla='ls -lAF'           # Compact view, show hidden
alias ll='ls -lFh'          # Long view, no hidden
alias artsn="./art.py --verbose search -r npm-local -s 'artifacts.netflix.com' $*"

alias gok='ssh -t aws.mgmttest.netflix.net oq-ssh -r us-west-2 kvick-unstable,0'
alias gojus='ssh -t aws.test.netflix.net oq-ssh -r us-west-1 jenkins-unstable-slave,0'
alias goju='ssh -t aws.test.netflix.net oq-ssh -r us-west-1 jenkins-unstable-v,0'
alias goau='ssh -t aws.mgmttest.netflix.net oq-ssh -r us-west-2 artifactory-artifacts-unstable-v,0'
alias goaup='ssh -t aws.mgmttest.netflix.net oq-ssh -r us-west-2 artifactory-artifacts-unstable-primary-v,0'
alias goap='ssh -t aws.mgmt.netflix.net oq-ssh -r us-west-2 artifactory-artifacts-stable-primary-v,0'
alias goams='ssh -t aws.mgmt.netflix.net oq-ssh -r us-west-2 artifactory-metrics-stable-v,0'
alias goamu='ssh -t aws.mgmttest.netflix.net oq-ssh -r us-west-2 artifactory-metrics-unstable-v,0'
alias gofart='ssh -t aws.mgmttest.netflix.net oq-ssh -r us-west-2 kvick-unstable-fart,0'

alias bt='ssh aws.test.netflix.net'
alias bp='ssh aws.prod.netflix.net'
alias bm='ssh aws.mgmt.netflix.net'
alias bmt='ssh aws.mgmttest.netflix.net'
alias delart="curl -vvv -uartipipe:artipipe -X DELETE https://artifacts-unstable.mgmt.netflix.net/$1"

# spotify
alias spause='spotify pause'
alias splay='spotify play'

# newt
alias nbc='newt build --cache'

alias vi='/usr/local/bin/vim'

# this is needed for zsh
alias scp='noglob scp'
alias rsync='noglob /usr/local/bin/rsync'

alias oqu='ssh -t aws.test.netflix.net oq-ssh -r us-west-1'
alias oqu2='ssh -t aws.unstable.test.netflix.net oq-ssh -r us-west-2'

alias vart='source ~/Projects/stash/artifactory-archive/venv/bin/activate'
#alias jira='/usr/local/Cellar/go-jira/0.0.17/bin/jira'
alias spin='/Users/kvick/bin/spin-darwin-amd64'

alias shrug='echo "¯\_(ツ)_/¯" | pbcopy'

function gojm {
  ssh -t awstest oq-ssh -r us-west-1 jenkins-${1:-opseng}-v,0
}

function getes2 {
  curl -XGET http://es-buildtools2.us-west-1.dyntest.netflix.net:7104/${1}
}

function getet {
  curl -XGET http://es_engtools.us-west-2.dynprod.netflix.net:7104/${1}
}

get-cass-creds() {
  curl https://casserole.itp.netflix.net/keys/$1_user/$(whoami)\?export\=true
}

get-cass-list() {
  curl https://casserole.itp.netflix.net/list/$(whoami)
}

# jupyter notebooks
alias jn='/anaconda/bin/jupyter_mac.command'
alias cdnewt='cd $GOPATH/src/stash.corp.netflix.com/engtools/newt/newtlib'

alias newtp="newt --app-type adhoc-debian-publisher publish $@"
