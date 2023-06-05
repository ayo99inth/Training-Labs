#!/bin/bash

# Step 1: Create User Accounts
USERNAMES=("sophie" "nathaniel" "lauren" "christopher" "seth" "connor" "beverly" "craig" "debra" "sandra" "alice" "roberto" "ivan" "gloria" "nicole" "johnny" "juliana" "amanda" "jerry" "joe" "gilbert" "riley" "stephanie" "troy" "liam" "hector" "nick" "clark" "danna" "perry" "alexis" "stuart" "daisy" "joey" "ron" "janet" "albert" "ben" "ashley" "dan" "shane" "scott" "sandy" "paul" "terry" "marion" "isabel")

for user in "${USERNAMES[@]}"; do
    sudo useradd "$user"
    password=$(shuf -n 1 /usr/share/wordlists/fasttrack.txt)
    echo "$user:$password" | sudo chpasswd
    echo "Creating user '$user'..."
done

echo "All done!"

# Step 2: Copy Linux Password and Shadow Files
sudo cp /etc/passwd /tmp/passwd
sudo cp /etc/shadow /tmp/shadow

# Step 3: Unshadow Password Hashes
sudo unshadow /tmp/passwd /tmp/shadow | grep '$y' | tee /tmp/hashes

# Step 4: Crack Passwords with John The Ripper
sudo john /tmp/hashes --wordlist /usr/share/wordlists/fasttrack.txt --format=crypt

# Cleanup
for user in "${USERNAMES[@]}"; do
    sudo userdel "$user"
    echo "Removing user '$user'..."
done

echo "All done!"

sudo rm /tmp/passwd /tmp/shadow /tmp/hashes

