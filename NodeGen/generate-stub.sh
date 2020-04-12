#!/bin/bash

projRoot="$(git rev-parse --show-toplevel)"
output="${projRoot}/output/"
swaggerFile="$1"

echo $projRoot


if [ -z "$swaggerFile" ]; then
	echo "Usage: ./generate-stub.sh <swaggerFile.yml>"
	echo "Exiting..."
	exit 1
fi

if ! command -v npm > /dev/null; then
	echo "ERROR: npm is required to run this script!"
	echo "Please install it using your package manager"
	echo "e.x. sudo apt-get instal npm"
	exit 1
fi

if ! command -v openapi-generator > /dev/null; then
	echo "This script requires an npm package 'openapi-codegen'"
	echo "  to run. I am now going to install this in your"
	echo "  system using sudo. Please enter your password when"
	echo "  prompted."
	echo "I will run exactly: $ sudo npm install -g openapi-codegen"
	sudo npm install @openapitools/openapi-generator-cli -g
fi


openapi-generator generate \
	--generator-name nodejs-express-server \
	--output "${projRoot}/output/" \
	--input-spec "$swaggerFile"
		
