; /sys/cancel.g
; Clean up and shut down after a print
; M25 in slicer to invoke

M400                                        ; wait for moves to finish
;M104 S0                                     ; turn off temperature
;M140 S0                                     ; turn off heatbed
M107                                        ; turn off fan
G1 E-3 F300									; retract 3 mm to reduce pressure in the nozzle
G91
G1 X2 Y2									; Wipe nozzle 
G90

; Drop Z, being careful near the max
if move.axes[2].machinePosition + 10 < move.axes[2].max
    G1 Z{ move.axes[2].machinePosition + 10 }
else
    G1 Z{ move.axes[2].max }

G0 X-30 Y100 F3000								; move to purge bucket