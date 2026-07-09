{
  tmux,
}:

tmux.overrideAttrs (previousAttrs: {
  patches = [
    ./empty-window-names.patch
  ];
})
