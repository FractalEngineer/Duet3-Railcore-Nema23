; General Setup - RailCore RRF on a SBC for Duet3

; General
G21										; Work in millimetres
G90										; Send absolute coordinates...
M83										; ...but relative extruder moves

; Debugging
M111 S0									; Debug (S0 is off; S1 is on)
M929 P"eventlog.txt" S1					; start logging to file eventlog.txt
M915 X Y S10 F0 R1						; log motor stalls (added 5/4/2019)


; Srepper Configuration and Trinamic Drive Tuning
M569 P0 S1 D3  V5 H5					; X / Rear - LDO-57STH56-2804MACRC
M569 P1 S0 D3  V5 H5					; Y / Front - LDO-57STH56-2804MACRC
M569 P2 S1 D3  V5 H5					; Z / FL - LDO-42STH47-1684MAC
M569 P3 S1 D3  V5 H5					; Z / RL - LDO-42STH47-1684MAC
M569 P4 S1 D3  V5 H5					; Z / MR - LDO-42STH47-1684MAC
M569 P5 S0 D3  V5 H5					; E / Extruder - LDO-42STH25-1004AC


; Stealthchop parameters
M915 P0:1	S3 F1 H153 T20000 R0				
M915 P2:3:4 S3 F1 H1652 T1 R0
M915 P5 	S3 F1 H3037 T20000 R0


; Steps/mm (for the default 1/16 microstepping)
M92 X160 Y160 Z1600 E4130				; Steps/mm


; Microstepping (independant of M92 above)
M350 X64 Y64 Z16 I1						; Set 32x microstepping for axes with interpolation
M350 E16 I0								; Set 16x microstepping for Flex3Drive extruder interpolation OFF


; Motor current
M906 X{2800 * 0.65} Y{2800 * 0.65} Z{1680 * 0.65} E420 I30			; Set motor currents (mA) and motor idle factor (%)
M84 S30 								; Idle timeout 30s


; Speeds
M203 X15000 Y15000 Z600 E2400			; Maximum speeds (mm/min) // XY15000(250mm/s), Z600(10mm/s))


; Accelerations and Jerk
M201 X2500 Y2500 Z100 E120				; Accelerations (mm/s^2)
M566 X800 Y800 Z100 E6					; Maximum jerk speeds (mm/min) 


; Axis configuration
M669 K1									; Corexy mode
M584 X0 Y1 Z2:3:4 E5					; Map X to drive 0 Y to drive 1, Z to drives 2, 3, 4, and E to drive 5
M208 X290 Y303 Z325						; Set axis maxima and high homing switch positions (adjust to suit your machine)
M208 X-27 Y0 Z0 S1						; Set axis minima and low homing switch positions (adjust to make X=0 and Y=0 the edges of the bed)


; Leadscrew locations
M671 X-10:-10:333  Y22.5:277.5:150 S7.5


; End Stops
M574 X1 S1 P"io0.in"					; Map the X endstop to io1.in
M574 Y1 S1 P"io3.in"					; May the Y endstop to io2.in
 

; BLTouch
M558 P9 C"io7.in" H5 R1 F120 T6000 A5 S0.02 B1			; Define the bltouch input on io7.in
M950 S0 C"io7.out"										; Define the bltouch servo on io7.out
G31 X Y25 Z1.90 P25 									; Set the offsets for the bltouch


; Define Bed
M140 H0
M557 X5:290 Y30:300 P8:8 				; Probe from X=5 to 290, Y=30 to 300mm with 8x8 points


; Thermistors
M308 S0 P"temp0" Y"thermistor" A"Keenovo" T100000 B4240 H0 L0 						; Bed thermistor - connected to temp0
M308 S1 P"temp1" Y"thermistor" A"Mosquito" T4606017 B5848 C5.548428e-8 H0 L0			; Dyze 500c thermistor - connected to e0_heat


; Define Heaters
M950 H0 C"out0" T0						; Bed heater is on out0
M950 H1 C"out1" T1						; Hotend heater is on out1


; Heater model parameters
M307 H0 A158.5 C366.7 D2.1 S1.0 V24.0 B0 	; Keenovo duet 3 configuration
;M307 H1 A324.0 C114.3 D4.4 S1.0 V23.9 B0   ; Mosquito 24V
M307 H1 A458.2 C108.7 D4.5 S1.0 V29.3 B0 	; Mosquito 260deg 29V


; Heater Fault Parameters
M570 H1 P10 T15 S180					; Hotend allows 10sec for anomaly, permits 15deg excursion, abandons print after 180s
M143 S350								; Set max hotend temperature			


; Fans
M950 F0 C"out5"							; Hotend fan on "out5" connector
M106 P0  H1 S0.8 T75 					; Enable thermostatic mode for hotend fan (S225)
M950 F1 C"out4"							; Layer fan on "out4" connector
M106 P1 S0 								; Layer Fan


; Tool definitions
M563 P0 D0 H1 F1                       	; Define tool 0
G10 P0 S0 R0                        	; Set tool 0 operating and standby temperatures


; Duet3 Cooling
M308 S2 Y"drivers" A"DRIVERS"  			; Configure sensor 2 as temperature warning and overheat flags on the TMC2660 on Duet
M308 S3 Y"mcu-temp" A"MCU"				; Configure sensor 3 as thermistor on pin e1temp for left stepper
M950 F2 C"out6" Q100 					; Create fan 2 on pin fan2 and set its frequency                        
M106 P2 C"ElectroBox" H1 S0.8 T75		; Set fan 2 value


; Filament Sensor
M591 D0 P7 C"io6.in" S0 E50 L1.25 R25:175 A1


; Mesh Bed Compensation
G29 S1 									; Load height map from SD card
M376 H3									; Set taper height 3mm


; Dynamic Acceleration Adjustment
;M593 F52


; Logging
M929 P"eventlog.txt" S1 				; start logging to file eventlog.txt

T0										; Select first hot end

