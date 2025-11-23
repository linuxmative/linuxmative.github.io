#!/bin/bash

# ==============================================================================
# Script Name: purge_default_games.sh
# Description: A utility to detect and remove pre-installed games on Debian/Ubuntu
#              systems. It uses a combination of known package lists, repository
#              sections (metadata), and heuristic keyword matching.
# Author:      Maksym Titenko
# License:     MIT (Optional)
# ==============================================================================

# Color definitions for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Ensure the script is run as root
if [ "$EUID" -ne 0 ]; then
  echo -e "${RED}Error: This script must be run as root. Please use sudo.${NC}"
  exit 1
fi

echo -e "${BLUE}=======================================================${NC}"
echo -e "${BLUE}   SYSTEM GAME CLEANUP UTILITY (DEBIAN/UBUNTU)   ${NC}"
echo -e "${BLUE}=======================================================${NC}"
echo "This script will analyze the system to identify and remove standard game packages."
echo "Methods used: Known package lists, DPKG category filtering, and keyword heuristics."

# Create a temporary file to store the package list
TMP_LIST=$(mktemp)

# --- STEP 1: Search by Known Package Names (Hardcoded List) ---
echo -e "\n${YELLOW}[1/3] Scanning for known standard game packages (GNOME/KDE/Common)...${NC}"

# List of common pre-installed games (Solitaire, Mines, Sudoku, etc.)
KNOWN_GAMES=(
    "aisleriot" "gnome-mahjongg" "gnome-mines" "gnome-sudoku" "gnome-chess"
    "gnome-nibbles" "gnome-robots" "gnome-taquin" "gnome-tetravex" "gnome-klotski"
    "four-in-a-row" "hitori" "iagno" "lightsoff" "quadrapassel" "swell-foop" "tali"
    "five-or-more" "hoichess" "kmahjongg" "kmines" "kpat" "ksudoku" "lskat"
    "bovo" "granatier" "kapman" "katomic" "kblackbox" "kblocks" "kbounce"
    "kbreakout" "kdiamond" "kfourinline" "kgoldrunner" "kigo" "killbots"
    "kiriki" "kjumpingcube" "klickety" "klines" "knetwalk" "knights"
    "kolf" "kollision" "konquest" "kreversi" "kshisen" "ksirk" "ksnake"
    "kspaceduel" "ksquares" "ktuberling" "kubrick" "palapeli" "picmi"
    "bsdgames" "nethack-console" "solitaire" "mahjong" "sudoku" "transitive"
)

# Check which of these are currently installed
for game in "${KNOWN_GAMES[@]}"; do
    if dpkg -l | grep -qE "^ii  $game "; then
        echo "$game" >> "$TMP_LIST"
    fi
done

# --- STEP 2: Search by Repository Sections (Metadata) ---
echo -e "${YELLOW}[2/3] Scanning DPKG categories ('games', 'gnome/games', 'kde/games')...${NC}"

# Query installed packages where the Section field explicitly mentions 'games'
# Using awk to extract just the package name
dpkg-query -W -f='${Package} ${Section}\n' | grep -E ' games|gnome/games|kde/games' | awk '{print $1}' >> "$TMP_LIST"

# --- STEP 3: Heuristic Search by Keywords ---
echo -e "${YELLOW}[3/3] Performing heuristic search by keywords...${NC}"

# Search for installed packages containing specific keywords in their names
dpkg -l | grep -E "^ii" | awk '{print $2}' | grep -E "solitaire|sudoku|mahjong|minesweeper|tetris" >> "$TMP_LIST"

# --- PROCESS THE LIST ---
# Sort unique entries and remove empty lines
SORTED_LIST=$(sort -u "$TMP_LIST" | sed '/^$/d')
rm "$TMP_LIST"

if [ -z "$SORTED_LIST" ]; then
    echo -e "\n${GREEN}No game packages found. The system appears to be clean.${NC}"
    exit 0
fi

echo -e "\n${RED}!!! THE FOLLOWING PACKAGES HAVE BEEN IDENTIFIED FOR REMOVAL !!!${NC}"
echo "---------------------------------------------------------------"
echo "$SORTED_LIST"
echo "---------------------------------------------------------------"
echo "Total packages found: $(echo "$SORTED_LIST" | wc -l)"

echo -e "\n${YELLOW}Do you want to remove these packages and their configuration files?${NC}"
read -p "Type 'yes' to confirm removal: " confirm

if [[ "$confirm" == "yes" ]]; then
    echo -e "\n${RED}Starting removal process...${NC}"
    
    # Convert newline-separated list to space-separated string for apt
    PACKAGES_TO_REMOVE=$(echo "$SORTED_LIST" | tr '\n' ' ')
    
    # Remove packages and purge configs
    sudo apt-get remove --purge -y $PACKAGES_TO_REMOVE
    
    echo -e "\n${YELLOW}Cleaning up unused dependencies (autoremove)...${NC}"
    sudo apt-get autoremove -y
    sudo apt-get clean
    
    echo -e "\n${GREEN}Cleanup complete. All identified games have been removed.${NC}"
else
    echo "Operation cancelled by user."
    exit 0
fi
