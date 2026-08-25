#!/bin/bash

echo "Exporting VS Code extensions..."
code --list-extensions > ./data.txt
echo "Done"
