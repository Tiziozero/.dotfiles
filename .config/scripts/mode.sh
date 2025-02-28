#!/bin/bash
i3-msg -t get_binding_modes | jq -r '.[0]' | {
    read mode
    if [ "$mode" == "" ]; then
        echo "default"  # Show "default" when not in any specific mode
    else
        echo "$mode"   # Show current mode
    fi
}
