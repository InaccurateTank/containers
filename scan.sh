function scan () {
  for ctuser in $(ps ho user p $(pgrep conmon) 2>/dev/null | sort -u); do
    tput smso
    printf "%s\n" "$ctuser"
    tput rmso
    su - "$ctuser" -c "podman ps"
  done
}