; /sys/print/start.g
; Perform all steps to prepare printing, including
; home, prepare bed, prime nozzle, etc.
; M98 in slicer to invoke
;
G90								; use absolute coordinates
M83								; extruder relative mode

G828							; home if not homed
G832							; if not already leveled, level bed and re-home Z

M116							; Wait for all temps to reach set point

;prime nozzle
G1 X0 Y100						; Move right off the purge bucket
G1 X0 Y0 F6000.0				; Go home
G1 Z0.15						; lower extruder
G92 E0.0						; Reset Extrusion Distance
G1 X60.0 E9.0 F1000.0			; intro line 1
G1 X100.0 E12.5 F1000.0			; intro line 2
G92 E0.0						; Reset Extrusion Distance
