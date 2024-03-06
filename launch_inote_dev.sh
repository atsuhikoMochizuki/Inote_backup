#!/bin/bash

cat <<EOF
  ___ _  _  ___ _____ ___ 
 |_ _| \| |/ _ \_   _| __|
  | || .`` | (_) || | | _| 
 |___|_|\_|\___/ |_| |___| 
 OpenSource Notes Manager
 ====================================================
EOF

gnome-terminal -x bash -c -- "echo 'Lancement du serveur SMTP de développement...' && sudo ./smtp-dev/Rnwood.Smtp4dev && exit"


# echo Ouverture du navigateur
# gnome-terminal -x bash -c -- "brave-browser http://localhost:5000 && exit"

echo "Lancement de l'API REST"
cd inote_API
java -jar ./target/inote_API-0.0.1-SNAPSHOT.jar
