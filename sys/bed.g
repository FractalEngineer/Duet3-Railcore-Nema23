M561                         ; clear any existing bed transform
G1 Z5	H2
G30 P0 X5 Y5 Z-99999
G30 P1 X5 Y290 Z-99999
G30 P2 X255 Y290 Z-99999 
G30 P3 X255 Y5 Z-99999 S3
G1 X-30 Y100 F6000               ; move the head to purge bucket