import mido
from mido import MidiFile
import pretty_midi
import os
import numpy as np

# Output path
output_path = ""

# MIDI path
midi_path = ""

# Open MIDI file with pretty_midi
midi_pretty = pretty_midi.PrettyMIDI(midi_path)

# Create new midi file
new_midi_pretty = pretty_midi.PrettyMIDI()

# Copy instruments from the original MIDI to the new one
for instrument in midi_pretty.instruments:
    new_midi_pretty.instruments.append(instrument)

# Copy the key signature changes
for key_signature in midi_pretty.key_signature_changes:
    new_midi_pretty.key_signature_changes.append(key_signature)

# Copy the time signature changes
for time_signature in midi_pretty.time_signature_changes:
    new_midi_pretty.time_signature_changes.append(time_signature)

# Save the new MIDI file
output_midi_path = output_path+"/MIDI_converted.mid"
new_midi_pretty.write(output_midi_path)
                    
