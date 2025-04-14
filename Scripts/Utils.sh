#!/bin/bash
# utils_ui.sh
# A cute and colorful Bash UI for utility scripts.

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
MAGENTA='\033[0;35m'
NC='\033[0m' # No Color

# ASCII Art Header
echo -e "${MAGENTA}"
echo "   _    _ _   _ _ _        "
echo "  | |  | | | (_) (_)       "
echo "  | |  | | |_ _| |_  __ _  "
echo "  | |  | | __| | | |/ _\` | "
echo "  | |__| | |_| | | | (_| | "
echo "   \____/ \__|_|_|_|\__,_| "
echo -e "${NC}"

# Main Menu Loop
while true; do
    echo -e "${YELLOW}=== Utils Menu ===${NC}"
    echo -e "${GREEN}1. ${CYAN}Clean Temporary Files${NC} (Run CleanT.sh)"
    echo -e "${GREEN}2. ${CYAN}Clipboard Helper${NC} (Run ClipH.sh)"
    echo -e "${GREEN}3. ${CYAN}Launch Terminals${NC} (Run LaunchT.sh)"
    echo -e "${GREEN}4. ${CYAN}Session Manager${NC} (Run SessionM.sh)"
    echo -e "${GREEN}5. ${CYAN}Simple Tab Manager${NC} (Run TabM.sh)"
    echo -e "${GREEN}6. ${CYAN}Window Helper${NC} (Run WH.sh)"
    echo -e "${GREEN}7. ${CYAN}Save/Restore Terminal Layout${NC} (Run SvTLayout.sh)"
    echo -e "${RED}8. Exit${NC}"
    echo

    # Prompt for Choice
    read -p "Choose an option: " CHOICE

    case $CHOICE in
        1)
            echo -e "${CYAN}Running Clean Temporary Files...${NC}"
            ./CleanT.sh
            ;;
        2)
            echo -e "${CYAN}Running Clipboard Helper...${NC}"
            ./ClipH.sh
            ;;
        3)
            echo -e "${CYAN}Launching Terminals...${NC}"
            ./LaunchT.sh
            ;;
        4)
            echo -e "${CYAN}Running Session Manager...${NC}"
            ./SessionM.sh
            ;;
        5)
            echo -e "${CYAN}Running Simple Tab Manager...${NC}"
            ./TabM.sh
            ;;
        6)
            echo -e "${CYAN}Running Window Helper...${NC}"
            ./WH.sh
            ;;
        7)
            echo -e "${CYAN}Running Save/Restore Terminal Layout...${NC}"
            ./SvTLayout.sh
            ;;
        8)
            echo -e "${RED}Exiting Utils Menu. Goodbye!${NC}"
            exit 0
            ;;
        *)
            echo -e "${RED}Invalid option. Please try again.${NC}"
            ;;
    esac
done
