# PS1 in colour with git branch name
parse_git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\[\033[01;33m\]$(__git_ps1 " (%s)") \[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi

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

alias csfix='vendor/bin/php-cs-fixer fix --config=.php_cs.php --verbose --diff'
alias phpunit='php artisan test --parallel --recreate-databases'
alias phpunit-coverage='phpunit --coverage-html public/php-unit-coverage-report/'

alias expose-api='expose share http://localhost:8081 --subdomain=custom-domain'
alias ngrok-api='ngrok http localhost:8081'

alias dc='docker-compose'
alias dcu='dc up -d'
alias dcd='dc down'
alias dcr='dcd; dcu'

alias dcphp='dc run --rm php -d memory_limit=4096M'
alias dca='dcphp artisan'
alias dcnpm='dc run --rm npm'
alias dcnpmw='dcnpm run watch'
alias dcnpmd='dcnpm run dev'
alias dcnpmfix='dcnpm run eslint:fix'
alias dcnpmi='dcnpm install'
alias dcc='dc run --rm composer install'
alias dccu='dc run --rm composer u'

alias dcanalyse='dcphp vendor/bin/phpstan analyse'
alias dccs='dcphp vendor/bin/php-cs-fixer fix --config=.php-cs-fixer.php --verbose --diff'

alias dctest='dca test --parallel --recreate-databases'
alias dctestcov='dctest --coverage-html public/reports'
alias dcphpunit='dcphp vendor/bin/phpunit'
alias sail='bash vendor/bin/sail'

alias awsdev='aws sso login --profile testcard'
alias awsprod='aws sso login --profile testcard-production'

# When ubuntu starts consuming a lot of ram for no reason
alias clear_ram_cache='sudo sync; sudo sh -c "/usr/bin/echo 3 > /proc/sys/vm/drop_caches"'

# try_docker_image php:8.0 php --version
alias try_docker_image='docker run -it --rm -v $PWD:/var/www/html'

