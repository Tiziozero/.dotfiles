#!/bin/bash

I3_SOCKET_PATH=$(i3 --get-socketpath)
I3_OLD_PID=$(pgrep i3)

# Paths to the config files
CONFIG_PATH="$HOME/.config/i3/config"
DEV_CONFIG_PATH="$HOME/.config/i3/config_dev"

if [ -L "$CONFIG_PATH" ]; then
    # If the current config is a symlink, check where it points
    TARGET=$(readlink "$CONFIG_PATH")
    if [ "$TARGET" == "$DEV_CONFIG_PATH" ]; then
        # Switch to main config
        ln -sf "$HOME/.config/i3/config_main" "$CONFIG_PATH"
        echo "Switched to main i3 config."
    else
        # Switch to dev config
        ln -sf "$DEV_CONFIG_PATH" "$CONFIG_PATH"
        echo "Switched to dev i3 config."
    fi
else
    # Create a symlink to main config if no symlink exists
    mv "$CONFIG_PATH" "$HOME/.config/i3/config_main"
    ln -sf "$HOME/.config/i3/config_main" "$CONFIG_PATH"
    echo "Created symlink for main config."
fi

# Restart i3 to apply the configuration change
i3-msg -s "$I3_SOCKET_PATH" restart
kill $I3_OLD_PID 
