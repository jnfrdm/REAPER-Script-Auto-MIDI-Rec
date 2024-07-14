# REAPER Script Auto MIDI Rec
# Software Requirements
REAPER 7.18

# Preliminary MIDI Manipulation

**Attention : the system will not work properly with MIDI songs that have
multiple tempo_changes messages!**

If you have MIDI files with multiple tempo_changes, please convert them to a single BPM version. As a reference you can use this python script for understanding which songs has multiple BPM, while this python script for converting them into a single BPM version. Every MIDI file needs to have a consistent name. In addition, for each MIDI file, a
numbered folder must be created with, inside the MIDI file itself, a tempo.txt containing the BPM of the song and a num.txt and den.txt containing the numerator and denominator of the time signature of the song. You can get this information directly from the MIDI file. You can use this script as a reference. In the case of multiple BPM songs, retrieve those data from the single BPM converted version. In the following fis represented a possible organization of the files considering a number k of songs.

<p align="center">
  <img width="auto" height="auto" alt="Folders Organization" src="/assets/Folders Organization.png">
</p>

## REAPER script installation
Open REAPER. Go to "Options -> Show REAPER resource path in explorer/finder...". A window should be opened. Go to folder "Scripts", create a new folder "Custom Scripts" and put inside the script.
Come back to REAPER and go to "Actions -> Show action list...". A window should be opened. Go to "New action... -> Load ReaScript..." and then selects the script inside "Custom Scripts". Now the script is installed.
It's needed a shortcut to call it. Still in the same "Actions" window, in "Filter" search for the script, click on it, go to "Add..." and then press the key you want associate to the script, the press "Ok". Pay attention that many keys are already linked to other built-in scripts. In our case letter "q" , that is usually free, has been used.
Finally, still in "Actions" window, select the script and click on "Edit Action". An editor should be opened. Fill "song_path" with the absolute path of songs folder while set "n_of_recordings" with the number of songs in the folder.

## Start Script
Open a new empty project in REAPER, make sure that the play marker (the vertical green line) is exactly at zero (you can press the "Previous Track" button or also use the associated shortcut pressing "w") and press "q" (or the key you chose for the script). The tracks should have been created, the MIDI file should have been played and the recording should have been started.

**Attention : don’t close or hide the media explorer during the recording
process!**

Since you cannot close the media explorer, if you want more space in the project and you don’t need the mixer, you may close mixer tab.
If you need to start the script in an already existing project, also make sure that you are not selecting any track before running the script.

## Stop Script 
You can stop the system simply pressing again "q" (or the key you chose for the script). REAPER will ask you if you prefer to open a new instance or exit, just exit. Then stop the recording by the red recording button (alternatively you can use "cmnd+R" shortcut) and stop the playback (alternatively you can press the space).

## Adding/removing tracks on REAPER script
Taking as example the Far microphone, each track in the REAPER script is created with these lines of code :

In the third argument of the function *reaper.SetMediaTrackInfo_Value()* is indicated the number of the recording input at which the track will be associated. In the third argument of the function *reaper.GetSetMediaTrackInfo_String()* is instead indicated the name of the track.
Only one track, the Back one, has an additional line of code :

<p align="center">
  <img width="auto" height="auto" alt="REAPER track code" src="/assets/REAPER track code.png">
</p>

In fact, there is an additional *reaper.SetMediaTrackInfo_Value()* with second argument "I_MIDIHWOUT". This function sets the MIDI hardware output to which this track will be connected. This means that only this track will receive MIDI information from the file read in the Media Explorer and will send it to the Disklavier. You can add/remove a track by adding/removing the associated lines but make sure that there is only and only one track with the additional line as in the Back track case.

<p align="center">
  <img width="auto" height="auto" alt="REAPER last track code" src="/assets/REAPER last track code.png">
</p>

## Possible Improvements : Alternative Version

A further version of the script has been developed. The key distinction between this version and the previous one is that the MIDI file is imported into the timeline as a new track. This approach avoids the need to obtain the BPM and song length from external files and to convert multiple BPM songs to single BPM ones. However, when a new MIDI file is inserted into the timeline in REAPER, a "MIDI File Import" window is prompted , which restricts the possibility of developing an autonomous system. Despite efforts to identify an optimal solution to this problem, no viable approach was found. Consequently, this version of the script was ultimately abandoned.

<p align="center">
  <img width="auto" height="auto" alt="MIDI File Import REAPER Window" src="/assets/MIDI File Import REAPER Window.png">
</p>

