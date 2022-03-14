#!/bin/sh

curl https://raw.githubusercontent.com/MacrinaLLC/MacrinaSites/setup/setup.swift --output setup.swift
chmod +x setup.swift
./setup.swift
rm setup.swift
