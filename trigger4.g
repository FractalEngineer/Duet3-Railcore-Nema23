; /sys/trigger4.g
; Red Button only when not printing
; Function: Unload filament

G0 E-5 F3600		; extract filament to cold end area 
G4 S3				; wait for three seconds
G0 E5 F3600			; push back the filament to smash any stringing 
G0 E-15 F3600		; Extract back fast in the cold zone 
G0 E-50 F300		; Continue extraction slowly, allow the filament time to cool solid before it 