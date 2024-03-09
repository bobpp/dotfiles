# iTerm ssh colors
if [ "${TERM_PROGRAM}" = "iTerm.app" ]; then
  function ssh-profile-change () {
    # set profile
    echo -ne "\033]1337;SetProfile=remote\a"

    # ssh login
    /usr/bin/ssh "$@"

    # set profile(default)
    echo -ne "\033]1337;SetProfile=Default\a"
  }
  alias ssh=ssh-profile-change
fi
