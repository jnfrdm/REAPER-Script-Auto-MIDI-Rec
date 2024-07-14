import mido
from mido import MidiFile
import os

# Input paths
midi_path = ""

# Load Midi file
mid = MidiFile(midi_path)

# Understand if is a single BPM MIDI 
repetition = False
is_single_BPM = True
for msg in mid:
    if repetition:
        if msg.type == 'set_tempo':
            is_single_BPM = False
            break
    if msg.type == 'set_tempo':
        repetition = True

if(is_single_BPM):
    print("The MIDI file has a single BPM")
else:
    print("The MIDI file has multiple BPM")
        
