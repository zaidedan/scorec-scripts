# Get idle CPU
CPU=$(top -bn1 | grep "Cpu(s)" | \
           sed "s/.*, *\([0-9.]*\)%*id.*/\1/" | \
           awk '{print $1}')
# Get free memory
MEM=$(top -bn1 | grep "Mem" | \
           sed "s/.*, *\([0-9.]*\)%*k\sfree.*/\1/" | \
           awk '{print $1}')
# If less than the minimum acceptable free memory, return negative
if [[ $MEM -lt $1 ]]; then
	CPU=-100.0
fi
# This is needed to pass into the find_computer function
echo $CPU
