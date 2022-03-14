#!/bin/sh

curl https://raw.githubusercontent.com/MacrinaLLC/MacrinaSites/master/.setup.sh --output .setup.swift
chmod +x .setup.swift
swift .setup.swift
rm .setup.swift
