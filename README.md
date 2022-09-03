# Railcore-Duet3-Nema23

RRF 3.4.0 config for my custom Railcore II ZL

Hardware:

-Duet 3 6HC mainboard

-Nema 23 stepper on X/Y

-Orbiter V2 extruder

-Mosquito Magnum Hot end

Use at your own risks





Main Features:

-X/Y Nema 23 steppers in D3 with Stealthchop deactivated through coolstep (M915 T parameter) for normal operation >>> Runs in spreadcycle mode for fast normal operation
  -Stealthchop manually enabled/disabled with the /Speed folder macro. Speed limited to 65mm/s in stealthchop

-TMC 5160 calibration sequence in the homing scripts

-Startup sequence macro to launch initial G28/32
  -start.g calling to conditional G28 (G828) and G32 (G832) only if homing and mesh hasn't been executed already
  -No disable steppers in stop.g; enables keeping the homing to launch the next print right away

-Physical front buttons for loading, unloading filament, adjusting Z offset, turning LED on/off...
