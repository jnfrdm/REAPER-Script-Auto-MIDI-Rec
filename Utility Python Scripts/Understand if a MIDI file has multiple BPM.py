''' 
    This is a python script
    You can run it by :
    1) Typing "python Understand if a MIDI file has multiple BPM.py" on the terminal. Be sure that the script is present in the currect directory!
    2) Using and IDE like Visual Studio code or PyCharm
    
'''

'''
    !!! REQUIREMENTS !!!
    You need to install mido library!
    
    !!! INSTRUCTIONS !!!
    Create a folder and put inside the .mid files you want to know if they have multiple BPM.
    Fill "midi_folder_path" with the path of that folder.

'''

import mido
from mido import MidiFile
import os


# MIDI folder path
midi_folder_path = ""

for filename in os.listdir(midi_folder_path):
    if filename.endswith('.mid'):

        # Input path
        input_file_path = os.path.join(midi_folder_path, filename)

        # Load Midi file
        mid = MidiFile(input_file_path)

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
            print(filename + " file has single BPM")
        else:
            print(filename + " file has multiple BPM")
        
