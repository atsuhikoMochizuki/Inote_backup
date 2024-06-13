#!/bin/bash
# Update all project
# AtsuhikoMochizuki 23/05/2024
#===================================================================================
now=$(date +"%Y-%m-%d : %H:%M:%S")

echo -e -n "\033[93m -- Get last changes in submodules...\033[0m"
git submodule update --remote --merge
echo -e "\033[32mOK\033[0m"

echo -e -n "\033[93m -- Stagging last changes...\033[0m"
git add .
echo -e "\033[32mOK\033[0m"

echo -e "\033[93m -- Commit last changes...\033[0m"
NOW=$(date +"%H:%M:%S")
git commit -m"$now -- Global updating..."
echo -e "\033[32m OK\033[0m"

echo -e "\033[93m -- Push last changes on default remote repository...\033[0m"
git push origin main
echo -e "\033[32m OK\033[0m"

echo -e "\033[93m -- Push last changes on mochizuki repository...\033[0m"
git push mochizuki-portfolio main
echo -e "\033[32m OK\033[0m"