# Update all project
# AtsuhikoMochizuki 23/05/2024
#===================================================================================
clear
echo "
  _____ _   _  ____ _______ ______ 
 |_   _| \ | |/ __ \__   __|  ____|
   | | |  \| | |  | | | |  | |___ 
   | | |   \ | |  | | | |  |  __|  
  _| |_| |\  | |__| | | |  | |____ 
 |_____|_| \_|\____/  |_|  |______|
 User-friendly personal notes manager
 ==============================================================================
  General Updating
  By @AtsuhikoMochizuki
  2024
 ==============================================================================                                 
"
echo -e -n "\033[93m -- Get last changes in submodules...\033[0m"
git submodule update --remote --merge
echo -e "\033[32mOK\033[0m"

echo -e -n "\033[93m -- Stagging last changes...\033[0m"
git add .
echo -e "\033[32mOK\033[0m"

echo -e "\033[93m -- Commit last changes...\033[0m"
git commit -m"$(date +'%H:%M:%S') -- Global updating..."
echo -e "\033[32m OK\033[0m"

echo -e "\033[93m -- Push last changes on default remote repository...\033[0m"
git push origin main
echo -e "\033[32m OK\033[0m"

# echo -e -n "\033[93m -- Push last changes on mochizuki repository\033[0m"
# git push mochizuki-portfolio main
# echo -e "\033[32mOK\033[0m"