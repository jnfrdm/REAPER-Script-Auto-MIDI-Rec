# This is a python script
# You can run it by :
# 1) Typing "python Understand if a MIDI file has multiple BPM.py" on the terminal. Be sure that the script is present in the currect directory!
# 2) Using and IDE like Visual Studio code or PyCharm

import mido
from mido import MidiFile
import os

# Input paths
midi_path = "" # <- Put here the path of the midi song you want to know if is multiple BPM

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
        
