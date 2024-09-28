subnet="172.17"
(
for i in {0..255}; do
  for j in {1..254}; do
    ip="$subnet.$i.$j"
    (ping -c 1 -W 1 $ip >/dev/null 2>&1 && echo "Host $ip is up") &
  done
done
wait
)
