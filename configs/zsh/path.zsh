typeset -U path
path=(
  $PNPM_HOME/bin
  $BUN_INSTALL/bin
  $HOME/.local/bin
  $GOPATH/bin
  $HOME/.cargo/bin
  $HOME/.local/share/gem/ruby/3.4.0/bin
  $HOME/.npm-global/bin
  $HOME/.dotfiles/scripts/bin
  $path[@]
)
export PATH
