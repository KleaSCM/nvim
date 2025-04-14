#!/bin/bash
# coding_ui.sh
# A cute and colorful Bash UI for coding setup scripts.

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# ASCII Art Header
echo -e "${CYAN}"
echo "   _____          _   _   _            _     "
echo "  / ____|        | | | | (_)          | |    "
echo " | |     ___   __| | | |_ _  ___ _ __ | |_   "
echo " | |    / _ \ / _\` | | __| |/ _ \ '_ \| __|  "
echo " | |___| (_) | (_| | | |_| |  __/ | | | |_   "
echo "  \_____\___/ \__,_|  \__|_|\___|_| |_|\__|  "
echo -e "${NC}"

# Main Menu Loop
while true; do
    echo -e "${YELLOW}=== Coding Setup Menu ===${NC}"
    echo -e "${GREEN}1. ${CYAN}Set Up a C++ Project${NC}"
    echo -e "${GREEN}2. ${CYAN}Set Up a Go Project${NC}"
    echo -e "${GREEN}3. ${CYAN}Set Up a Python Project${NC}"
    echo -e "${GREEN}4. ${CYAN}Set Up a Flask Project${NC}"
    echo -e "${GREEN}5. ${CYAN}Set Up a SQLite Database${NC}"
    echo -e "${GREEN}6. ${CYAN}Set Up a Simple HTML Project${NC}"
    echo -e "${RED}7. Exit${NC}"
    echo

    # Prompt for Choice
    read -p "Choose an option: " CHOICE

    case $CHOICE in
        1)
            echo -e "${CYAN}Running C++ Setup...${NC}"
            ./CPP.sh
            ;;
        2)
            echo -e "${CYAN}Running Go Setup...${NC}"
            ./GoSetUp.sh
            ;;
        3)
            echo -e "${CYAN}Running Python Setup...${NC}"
            ./Python_setup.sh
            ;;
        4)
            echo -e "${CYAN}Running Flask Setup...${NC}"
            ./Python_flask.sh
            ;;
        5)
            echo -e "${CYAN}Running SQLite Database Setup...${NC}"
            ./SQLiteDB.sh
            ;;
        6)
            echo -e "${CYAN}Running Simple HTML Setup...${NC}"
            ./Simple_html.sh
            ;;
        7)
            echo -e "${RED}Exiting Coding Setup Menu. Goodbye!${NC}"
            exit 0
            ;;
        *)
            echo -e "${RED}Invalid option. Please try again.${NC}"
            ;;
    esac
done
