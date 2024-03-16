#!/bin/bash

# Execution Nmap
output=$(sudo nmap -sn 192.168.1.0/24 | grep -E 'Nmap scan report for' | sed -E 's/Nmap scan report for ([^(]+) \(([0-9.]+)\)/\1 \2/' | awk '{if ($1 != "Nmap") print}' | sed 's/.home//g')

# Création du html
html_content="<html>
<head>
  <title>Rapport Nmap</title>
  <style>
    table {
      border-collapse: collapse;
      width: 100%;
    }
    th, td {
      border: 1px solid black;
      padding: 8px;
      text-align: left;
    }
  </style>
</head>
<body>
  <h1>Liste des hôtes</h1>
  <table>
    <tr>
      <th>Nom</th>
      <th>IP</th>
    </tr>"

# Création du tableau
while IFS= read -r line; do
  html_content+="    <tr>"
  html_content+="      <td>${line%% *}</td>"
  html_content+="      <td>${line#* }</td>"
  html_content+="    </tr>"
done <<< "$output"

html_content+="  </table>
</body>
</html>"

# Écrire le contenu HTML dans un fichier
echo "$html_content" > wifi_report.html

echo "Rapport ecrit dans wifi_report.html"
