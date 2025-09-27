# Custom Aliases
# Ecccube
alias console='php bin/console'
alias copy-svg='cp -r app/Plugin/Designer/Resource/assets/* html/plugin/Designer/assets/'


# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# GIT

function update_staging() {
  git checkout staging &&
  git pull origin staging &&
  git merge --no-ff $1 &&
  git push origin staging &&
  git checkout $1
}

function install_plugin(){
  php bin/console eccube:plugin:install --code=$1 &&
  php bin/console eccube:plugin:enable --code=$1 &&
  php bin/console eccube:plugin:update $1 &&
  php bin/console cache:clear --no-warmup

  echo "Plugin $1 installed and enabled successfully."
}
