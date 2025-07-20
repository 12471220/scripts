#!/bin/sh
# This script is used to start the foot terminal server.

pgrep -f "foot --server" || foot --server
