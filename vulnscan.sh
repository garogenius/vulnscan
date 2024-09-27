#!/bin/bash

# Author: Suleiman Yahaya Garo aka Garogenius, @garogenius
# Script: Vulnscan - A network, vulnerability scanning, and information gathering tool

# Function to install necessary tools
function install_dependencies() {
    echo "Checking and installing required tools..." | lolcat
    
    # List of tools needed for the script
    dependencies=("nmap" "nikto" "curl" "whois" "whatweb" "sqlmap" "figlet" "lolcat")

    for tool in "${dependencies[@]}"; do
        if ! command -v $tool &> /dev/null; then
            echo "$tool not found. Installing..." | lolcat
            sudo apt-get install -y $tool
        else
            echo "$tool is already installed." | lolcat
        fi
    done
}

# Run the function to install dependencies
install_dependencies

# Display banner using figlet and lolcat
figlet -c -f slant "Vulnscan" | lolcat
echo "-----------------------------------------------------------------------------" | lolcat
echo "Vulnscan - A Network, Vulnerability Scanning, and Information Gathering Tool" | lolcat
echo "-----------------------------------------------------------------------------" | lolcat

echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!" | lolcat
echo "Created By Suleiman Yahaya Garo Aka Garogenius" | lolcat
echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!" | lolcat

cat << "EOF" | lolcat
 /\_/\  
( o.o ) 
 > ^ <
EOF

function display_menu() {
    echo -e "\nChoose an option below:\n" | lolcat
    echo "1. Quick Scan (ICMP Ping)"
    echo "2. Stealth SYN Scan (-sS)"                                          
    echo "3. Full Scan (-A)"                               
    echo "4. OS Detection"
    echo "5. Scan Website for Vulnerabilities"
    echo "6. Scan Specific Ports"
    echo "7. IP Address Geolocation"
    echo "8. Mobile Number Lookup"
    echo "9. WHOIS Lookup"
    echo "10. WhatWeb Scan"
    echo "11. SQLMap Scan"
    echo "12. Exit"
    echo ""
}

function quick_scan() {
    echo -n "Enter target IP or range: "
    read target
    figlet -f small "@garogenius" | lolcat
    echo "Running Quick Scan (Ping)" | lolcat
    sudo nmap -sn $target
}

function stealth_scan() {
    echo -n "Enter target IP or range: "
    read target
    echo "Running Stealth SYN Scan (-sS)" | lolcat
    sudo nmap -sS $target
}

function full_scan() {
    echo -n "Enter target IP or range: "
    read target
    echo "Running Full Scan with OS Detection (-A)" | lolcat
    sudo nmap -A $target
}

function os_detection() {
    echo -n "Enter target IP or range: "
    read target
    echo "Detecting OS..." | lolcat
    sudo nmap -O $target
}

# Function for Web Vulnerability Scanning using Nikto
function web_scan() {
    echo -n "Enter website URL (e.g., http://example.com): "
    read website
    echo "Scanning website for vulnerabilities using Nikto..." | lolcat
    sudo nikto -h $website
}

# Function to scan specific ports
function port_scan() {
    echo -n "Enter target IP or range: "
    read target
    echo -n "Enter port range (e.g., 1-1000 or specific port 80): "
    read ports
    echo "Scanning ports $ports on $target" | lolcat
    sudo nmap -p $ports $target
}

# Function for IP Geolocation using ipinfo.io
function ip_geolocation() {
    echo -n "Enter IP Address: "
    read ip
    echo "Fetching IP Geolocation for $ip..." | lolcat
    curl -s "http://ipinfo.io/$ip" | lolcat
}

# Function to look up mobile number info using Numverify or other API
function mobile_lookup() {
    echo -n "Enter Mobile Number with country code (e.g., +234234567890): "
    read number
    echo "Looking up mobile number information for $number..." | lolcat
    curl -s "http://apilayer.net/api/validate?access_key=YOUR_API_KEY&number=$number" | lolcat
}

# Function to perform WHOIS lookup
function whois_scan() {
    echo -n "Enter domain to look up (e.g., example.com): "
    read domain
    echo "Fetching WHOIS information for $domain..." | lolcat
    whois $domain
}

# Function to perform WhatWeb scan
function whatweb_scan() {
    echo -n "Enter website URL (e.g., http://example.com): "
    read website
    echo "Running WhatWeb scan on $website..." | lolcat
    whatweb $website
}

# Function to perform SQLMap scan for SQL injection vulnerabilities
function sqlmap_scan() {
    echo -n "Enter website URL or request file (e.g., http://example.com or req.txt): "
    read website
    echo "Scanning for SQL injection vulnerabilities using SQLMap..." | lolcat
    sqlmap -u $website --batch --dbs
}

# Main loop to handle user input
while true; do
    echo "@garogenius" | lolcat
    display_menu
    echo -n "Select an option (1-12): "
    read option

    case $option in
        1) quick_scan ;;
        2) stealth_scan ;;
        3) full_scan ;;
        4) os_detection ;;
        5) web_scan ;;
        6) port_scan ;;
        7) ip_geolocation ;;
        8) mobile_lookup ;;
        9) whois_scan ;;
        10) whatweb_scan ;;
        11) sqlmap_scan ;;
        12) echo "Exiting Vulnscan... Goodbye!" | lolcat; exit 0 ;;
        *) echo "Invalid option. Please choose a valid option!" ;;
    esac
done
