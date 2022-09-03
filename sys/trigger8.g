; /sys/trigger8.g
; Blue Button only when NOT printing
; 24V LED ON/OFF

if fans[3].actualValue < 0.5
	M106 P3 S1
else 
	M106 P3 S0