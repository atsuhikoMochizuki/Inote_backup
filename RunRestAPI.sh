# Run INOTE REST API
# AtsuhikoMochizuki 12/04/2024
#===================================================================================
cat <<EOF
  _____ _   _  ____ _______ ______ 
 |_   _| \ | |/ __ \__   __|  ____|
   | | |  \| | |  | | | |  | |__   
   | | | . \` | |  | | | |  |  __|  
  _| |_| |\  | |__| | | |  | |____ 
 |_____|_| \_|\____/  |_|  |______|
 User-friendly personal notes manager
 ==============================================================================
  INOTE REST API - DEV TOOL
  By @AtsuhikoMochizuki
  2024
 ==============================================================================                                 
EOF
clear
-- Search Rest api package
apiPackage="./Inote_RestAPI/target/InoteApi-0.0.1-SNAPSHOT.jar"
if [ -e "$apiPackage" ]; then
    echo '  -- OK'
    echo -- Search Smtp-dev   
    if [ -f ./smtpServer_simul_run.sh ]; then
        echo '  -- OK'
        echo -- Launch Smtp-dev in new terminal
        gnome-terminal -- /bin/bash -c "echo 'Starting Smtp-dev (Smtp server simulation)...' && sudo ./smtp-dev/Rnwood.Smtp4dev"
        echo -- Launch Inote Rest api
        java -jar ./Inote_RestAPI/target/InoteApi-0.0.1-SNAPSHOT.jar
    else
        echo '  [!] Not Found : Smtp-dev is not present'
    fi
else
    echo '  [!] Not Found : have you build the package ?'
fi
