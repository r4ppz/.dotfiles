# deduplication first
typeset -U path PATH

# source home env vars
# see: modules/home/env.nix
if [[ -f "/etc/profiles/per-user/$USER/etc/profile.d/hm-session-vars.sh" ]]; then
  . "/etc/profiles/per-user/$USER/etc/profile.d/hm-session-vars.sh"
fi
