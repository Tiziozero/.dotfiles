# #!/bin/bash
# res=$( find $HOME/Documents/projects/ -type d -maxdepth 1 | grep -v "^$HOME/Documents/projects$" | fzf )

# tmux new -s proj -c $HOME/Documents/projects/$res

#!/bin/bash

# res=$(find "$HOME/Documents/projects/" -maxdepth 1 -type d  | grep -v "^$HOME/Documents/projects$" | fzf)
res=$(find "/mnt/c/Users/kleid/OneDrive/Documents/code" -maxdepth 1 -type d  | grep -v "/mnt/c/Users/kleid/OneDrive/Documents/code/$" | fzf)

echo "selected dirrectory: $res"
if [ -z "$res" ]; then
  echo "No selection made. Exiting..."
  exit 1
fi
tmux new -s "{res: -3}" -c "$res"
# Assuming $res contains a path relative to $HOME/Documents/projects/
# and removing the leading $HOME/Documents/projects/ part for tmux -c
# selected_dir="${res#/mnt/c/Users/kleid/OneDrive/Documents/code/}"

# tmux new -s proj -c "$res"
