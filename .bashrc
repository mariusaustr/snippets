# PS1 in colour with git branch name
parse_git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\[\033[01;33m\]$(__git_ps1 " (%s)") \[\033[00m\]\$ '

# some ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Set up ssh-agent
SSH_ENV="$HOME/.ssh/environment"
 
function start_agent {
    echo "Initializing new SSH agent..."
    touch $SSH_ENV
    chmod 600 "${SSH_ENV}"
    /usr/bin/ssh-agent | sed 's/^echo/#echo/' >> "${SSH_ENV}"
    . "${SSH_ENV}" > /dev/null
    /usr/bin/ssh-add ~/.ssh/id_rsa
}
 
# Source SSH settings, if applicable
if [ -f "${SSH_ENV}" ]; then
    . "${SSH_ENV}" > /dev/null
     kill -0 $SSH_AGENT_PID 2>/dev/null || {
        start_agent
    }
else
     start_agent
fi

# Various aliases
alias php7='/usr/bin/php7.4'
alias php8='/usr/bin/php8.0'
alias usephp7='sudo update-alternatives --set php /usr/bin/php7.4 && php -v'
alias usephp8='sudo update-alternatives --set php /usr/bin/php8.0 && php -v'

alias a="php artisan"

alias csfix='vendor/bin/php-cs-fixer fix --config=.php_cs.php --verbose --diff'
alias test-coverage='php artisan test --parallel --coverage-html public/php-unit-coverage-report/'
alias phpunit-coverage='php artisan test --parallel --coverage-html public/php-unit-coverage-report/'
alias phpunit='php artisan test --parallel'

alias expose-api='expose share http://localhost:8081 --subdomain=tc-api-covid-marius'
alias ngrok-api='ngrok http localhost:8081'

alias dc='docker compose'
alias dcu='dc up -d'
alias dcd='dc down'
alias dcr='dcd; dcu'

alias dcphp='dc run --rm php -d memory_limit=4096M'
alias dca='dcphp artisan'
alias dcnpm='dc run --rm --service-ports npm'
alias dcnpmw='dcnpm run watch'
alias dcnpmd='dcnpm run dev'
alias dcnpmfix='dcnpm run eslint:fix'
alias dcnpmi='dcnpm install'
alias dcc='dc run --rm composer'
alias dcci='dcc install'
alias dccu='dcc u'
alias dccr='dcc require'
alias dccrm='dcc remove'

alias dcanalyse='dcphp vendor/bin/phpstan analyse'
alias dccs='dcphp vendor/bin/php-cs-fixer fix --verbose --diff'
alias dcpint='dcphp vendor/bin/pint'
alias dccrowdin='dc run --rm crowdin'

alias dctest='dca test --parallel --recreate-databases'
alias dctestcov='dctest --coverage-html public/reports'
alias dcphpunit='dcphp vendor/bin/phpunit'
alias sail='bash vendor/bin/sail'

# Please make sure you have the following export set in your .bashrc / .zshrc file so that the composer / npm containers create things with the correct permissions locally.
export CURRENT_UID=$(id -u):$(id -g)

alias awsdev='aws sso login --profile testcard'
alias awsprod='aws sso login --profile testcard-production'

alias clear_ram_cache='sudo sync; sudo sh -c "/usr/bin/echo 3 > /proc/sys/vm/drop_caches"'

alias try_docker_image='docker run -it --rm -v $PWD:/var/www/html -w /var/www/html '

# DBeaver mysqdump options to export data:
# --protocol=TCP --set-gtid-purged=OFF --lock-tables=false
