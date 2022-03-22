#!/bin/sh

curl https://raw.githubusercontent.com/MacrinaLLC/MacrinaSites/master/.setup.swift --output .setup.swift
chmod +x .setup.swift
swift .setup.swift
rm .setup.swift
open Package.swift
