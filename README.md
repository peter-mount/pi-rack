# PI Rack
PI-Rack is a 3D printed racking system for mounting Raspberry PI's, Arduino's and other projects.

## Slicing settings

These are the settings I used in Cura:

Printer: GeeeTech A20M

| Setting | Value | Notes |
| ------- | ----- | ----- |
| Initial Layer Height | 0.3 mm | Advised value for the A20M |
| Print Speed | 100 mm/s | Set this to what you want |
| Infill Speed | 100 mm/s | |
| Wall Speed | 50 mm/s | |
| Outer Wall Speed | 50 mm/s | |
| Inner Wall Speed | 100 mm/s | |
| Initial Layer Speed | 100 mm/s | |
| Skirt/Brim Speed | 50 mm/s | |
| Brim Width | 8.0 mm | Set if you want a brim |
| Brim Line Count | 20 | Set if you want a brim |
| Brim Only on Outside | True | Set if you want a brim |

### Infill

Normally I have the following:

| Setting | Value | Notes |
| ------- | ----- | ----- |
| Infill Density | 20% | |
| Infill Pattern | Grid | |

However for the RackEar I use this instead:

| Setting | Value | Notes |
| ------- | ----- | ----- |
| Infill Density | 60% | |
| Infill Pattern | Gyroid | |

This is to give that component extra strength as it has to hold the entire weight of the rack.
