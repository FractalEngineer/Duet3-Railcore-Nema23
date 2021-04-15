; Startup Routing
; Homes all axes and true levels the bed for that sweet first layer goodness

G29 S2				; Unloads Mesh Map
G828					; Homes all axes
G832					; True Level 1
;G28	Z				; Home Z
; G32					; True Level 2 just to be sure
; G28 Z				; Home Z
G1 X-30 Y100 F3000		; move to purge bucket
G29 S1				; Load Mesh Map
