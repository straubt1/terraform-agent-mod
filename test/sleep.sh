#!/bin/bash

# Exit if any of the intermediate steps fail
set -e

sleep_duration=$1

sleep $sleep_duration

# Output in JSON format, as required by the external data source
echo "{\"status\": \"slept for $sleep_duration seconds\"}"