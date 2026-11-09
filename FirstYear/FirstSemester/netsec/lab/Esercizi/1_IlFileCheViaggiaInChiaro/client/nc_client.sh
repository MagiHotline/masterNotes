while true; do 
    echo "Packet content" | nc -w 1 server 1234
    echo "Packet sent"
    sleep 1 
done