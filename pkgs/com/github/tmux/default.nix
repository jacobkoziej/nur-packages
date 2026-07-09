{
  pkgs,
  ...
}:

{
  tmux = import ./tmux { inherit (pkgs) tmux; };
}
