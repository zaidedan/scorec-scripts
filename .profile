
export PATH=/users/zaided/bin:$PATH


#setenv PRINTER p1

if [ "$HOSTNAME" != jumpgate ]; then

	module load cmake/latest \
	mpich3/3.1.2-thread-multiple \
	parmetis/mpich3.1.2/4.0.3 \
	zoltan/mpich3.1.2/3.8 \
	git
	export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/lore/zaided/nektar++-3.4.0/ThirdParty/dist/lib
	alias lore='cd /lore/zaided'
fi

eval "$(ssh-agent -s)" > /dev/null 2>&1
ssh-add .ssh/id_rsa_github > /dev/null 2>&1

if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

alias emacs='emacs 2>/dev/null'
alias rm='rm -I'
alias cd..='cd ..'

function makelog {
    make "$@" 2>&1 | tee "make-$(date +"%H-%M-%S-%F").log"
}

alias make='makelog'
#export SCOREC_COMPUTERS="(romulus remus catan othello monopoly clue stratego risk mastermind balderdash diplomacy)"
export SCOREC_COMPUTERS="romulus remus catan othello monopoly clue mastermind balderdash"

