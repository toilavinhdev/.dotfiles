#!/bin/bash

echo "Installing VS Code extensions..."
xargs -L 1 code --install-extension < ./data.txt
echo "Done"
