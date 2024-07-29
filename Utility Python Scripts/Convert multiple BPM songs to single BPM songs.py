''' 
    This is a python script
    You can run it by :
    1) Typing "python Understand if a MIDI file has multiple BPM.py" on the terminal. Be sure that the script is present in the currect directory!
    2) Using and IDE like Visual Studio code or PyCharm
    
'''

'''
    !!! REQUIREMENTS !!!
    You need to install pretty_midi library!
    
    !!! INSTRUCTIONS !!!
    Create a folder and put inside the .mid files you want to convert into single BPM version.
    Fill "midi_folder_path" with the path of that folder.
    Fill instead "output_path" with the path of the desired output folder.

'''

import pretty_midi
import os
import numpy as np

# Output path
output_folder_path = "" 

# MIDI folder path
midi_folder_path = ""

for filename in os.listdir(midi_folder_path):
    if filename.endswith('.mid'):
        
        print("Converting " + filename + "...")

        # Input/Output paths
        input_file_path = os.path.join(midi_folder_path, filename)
        output_file_path = os.path.join(output_folder_path, filename)
        
        # Open MIDI file with pretty_midi
        midi_pretty = pretty_midi.PrettyMIDI(input_file_path)
        
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
        new_midi_pretty.write(output_file_path)

        print(filename + " converted successfully!")
    
print("All .mid files converted successfully!")            
