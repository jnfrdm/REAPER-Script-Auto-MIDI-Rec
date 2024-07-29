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
    Create a folder and put inside the .mid files you want to extract structure information.
    Fill "midi_folder_path" with the path of that folder.
    Fill instead "output_path" with the path of the desired output folder.

'''

import mido
from mido import MidiFile
import os

# Input and output paths
midi_folder_path = ""
output_folder_path = ""

for filename in os.listdir(midi_folder_path):
    if filename.endswith('.mid'):
        
        print("Extracting structure information from " + filename + "...")

        # Input/Output paths
        input_file_path = os.path.join(midi_folder_path, filename)

        # Load Midi file
        mid = MidiFile(input_file_path)

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
            with open(output_folder_path+"/"+filename+"_tempo.txt", "w") as file:
                file.write(str(BPM))

            # Print and save Length
            print("Length " + str(length))
            with open(output_folder_path+"/"+filename+"_length.txt", "w") as file:
                file.write(str(length))

            # Print and save Time Signature
            print("Numerator : " + str(numerator))
            print("Denominator : " + str(denominator))
            with open(output_folder_path+"/"+filename+"_numerator.txt", "w") as file:
                file.write(str(numerator))
            with open(output_folder_path+"/"+filename+"_denominator.txt", "w") as file:
                file.write(str(denominator))
        else:
            print("The MIDI file has multiple BPM, convert it to a single BPM version")
        
