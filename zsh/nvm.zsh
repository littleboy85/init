export NVM_DIR="$HOME/.nvm"
if [[ ! -d $NVM_DIR ]]; then
    curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.32.0/install.sh | bash
fi
[ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh" --no-use

