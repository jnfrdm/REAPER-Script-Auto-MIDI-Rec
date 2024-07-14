import mido
from mido import MidiFile
import os

# Input and output paths
midi_path = ""
output_path = ""

# Load Midi file
mid = MidiFile(midi_path)

# Understand if is a single BPM MIDI 
repetition = False
is_single_BPM = True
for msg in mid:
    if msg.type == 'time_signature':
        numerator = msg.numerator # Get numerator time signature
        denominator = msg.denominator # Get denominator time signature
    if repetition:
        if msg.type == 'set_tempo':
            is_single_BPM = False
            break
    if msg.type == 'set_tempo':
        repetition = True
        BPM = 60000000/msg.tempo # Get BPM

if(is_single_BPM):

    length = mid.length # Get Length

    # Print and save BPM
    print("BPM : " + str(BPM))
    with open(output_path+"/tempo.txt", "w") as file:
        file.write(str(BPM))

    # Print and save Length
    print("Length " + str(length))
    with open(output_path+"/length.txt", "w") as file:
        file.write(str(length))

    # Print and save Time Signature
    print("Numerator : " + str(numerator))
    print("Denominator : " + str(denominator))
    with open(output_path+"/numerator.txt", "w") as file:
        file.write(str(numerator))
    with open(output_path+"/denominator.txt", "w") as file:
        file.write(str(denominator))
else:
    print("The MIDI file has multiple BPM, convert it to a single BPM version")
        
