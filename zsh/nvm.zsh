export NVM_DIR="$HOME/.nvm"
if [[ ! -d $NVM_DIR ]]; then
    curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.9/install.sh | bash
fi
[ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"
NVM_VERSION=nvm version
export PATH=$HOME/.composer/vendor/bin:$NVM_DIR/versions/node/$NVM_VERSION/bin:$HOME/bin:/usr/local/bin:/usr/local/sbin:$PATH


