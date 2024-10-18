#!/bin/bash

# List of search words
search_words=(
    "robot" "plan" "objet" "theme" "chaud" "froid" "vente" "cours"
    "theorie" "tard" "tot" "mur" "image" "ecran" "pierre" "feu"
    "air" "poussiere" "fer" "metal" "herbe" "jungle" "desert" "vent" "hurlement" "machine" "esprit" "espace" "temps" "horloge" "livre" "page" "parole" "son" "musique" "rythme" "morceau" "note" "invention"
    # Add more words as needed...
)

# Function to get a random search term
get_random_word() {
    echo "${search_words[RANDOM % ${#search_words[@]}]}"
}

# Function to search on Bing
search_bing() {
    local query=$(get_random_word)
    xdg-open "https://www.bing.com/search?q=$query" &  # Open in default browser
    sleep 1  # Brief pause
}

xdg-open "https://rewards.bing.com/"
sleep 5

# Perform multiple searches
for i in {1..34}; do
    search_bing
    sleep 3  # Pause between searches
done
