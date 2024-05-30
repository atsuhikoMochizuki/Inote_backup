# Run INOTE REST API
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
  INOTE REST API - DEV TOOL
  By @AtsuhikoMochizuki
  2024
 ==============================================================================                                 
"
echo -e -n "\033[93m -- Search Rest api package...\033[0m"
apiPackage="./Inote_RestAPI/target/InoteApi-0.0.1-SNAPSHOT.jar"
if [ -e "$apiPackage" ]; then
    echo -e "\033[32mOK\033[0m"
    
    echo -e -n "\033[93m -- Search Smtp4dev (smtp server mocking)...\033[0m"
    if [ -f ../smtp-dev/Rnwood.Smtp4dev ]; then
        echo -e "\033[32mOK\033[0m"
        
        echo -e "\033[93m -- Launch Smtp-dev in new terminal\033[0m"
        gnome-terminal --title=SMTP4DEV --command "../smtp-dev/Rnwood.Smtp4dev"
        xdotool windowminimize $(xdotool search --name SMTP4DEV|head -1)
        echo -e -n "\033[93m -- \033[0m"
        echo -e "\033[32mOK\033[0m"
        
        echo -e -n "\033[34m -- Launch API\033[0m"
        cd ./Inote_RestAPI
        java -jar ./target/InoteApi-0.0.1-SNAPSHOT.jar
        cd ..
    else
        echo -e "\033[31mNot Found : This script expects to find a ‘smtp-dev’ folder in the folder containing the super project folder, which contains the Smtp4dev simulation smtp server. Please download Smtp4Dev and install it in the same folder as the Inote root superproject.\033[0m"
    fi
else
    echo -e "\033[31mNot Found : have you build the package ?\033[0m"
fi
