-- Song folder path
song_folder_path = ""

-- Number of recordings
n_of_recordings = 10

-- Output Index of Disklavier 
n_MIDI_device_index = 1
MIDI_output = n_MIDI_device_index << 5

-- Name that have midi files
song_name = "song"

-- Recording function
function newRecording()
  if song_index < n_of_recordings+1 then
  
    -- Initialize wait time
    wait_time_in_seconds = 0
    
    -- To be sure that recording will happen only on the new track
    reaper.ClearAllRecArmed()
    reaper.MuteAllTracks(true)
    reaper.CSurf_OnStop()
    
    -- Get Song ID
    song = string.format("%03d", song_index)
      
    -- Get BPM
    local file = io.open(song_folder_path .. "/" .. song .. "/tempo.txt", "r")
    
    -- Get Time Signature 
    local file1 = io.open(song_folder_path .. "/" .. song .. "/numerator.txt", "r")
    local file2 = io.open(song_folder_path .. "/" .. song .. "/denominator.txt", "r")
    
    if file then
  
      -- Set BPM
      bpm = tonumber(file:read("*all"))
      reaper.SetCurrentBPM(reaper.GetCurrentProjectInLoadSave(),bpm, false)
      
      -- Set Time Signature
      num = tonumber(file1:read("*all"))
      den = tonumber(file2:read("*all"))
      reaper.SetTempoTimeSigMarker(reaper.GetCurrentProjectInLoadSave(),-1,0,-1,-1,bpm,num,den,false)
      
      -- 1) Create a Mono track
      reaper.Main_OnCommand(40001, 0) -- Insert track
      
      -- Set for the AB Vertical Left track
      local lastTrackIndex = reaper.CountTracks(0) - 1
      local lastTrack = reaper.GetTrack(0, lastTrackIndex)
      reaper.SetMediaTrackInfo_Value(lastTrack, "I_RECARM", 1)
      reaper.GetSetMediaTrackInfo_String(lastTrack, "P_NAME", song .. "Mono", true) -- to set track name
      reaper.SetMediaTrackInfo_Value(lastTrack, "I_RECINPUT", 1 - 1) -- to set recording input
      reaper.SetOnlyTrackSelected(lastTrack)
      
      -- 3) Create a AB Horizontal Left track
      reaper.Main_OnCommand(40001, 0) -- Insert track
      
      -- Set for the AB Horizontal Left track
      local lastTrackIndex = reaper.CountTracks(0) - 1
      local lastTrack = reaper.GetTrack(0, lastTrackIndex)
      reaper.SetMediaTrackInfo_Value(lastTrack, "I_RECARM", 1) -- to set track name
      reaper.GetSetMediaTrackInfo_String(lastTrack, "P_NAME", song .. "ABHorizontalLeft", true)
      reaper.SetMediaTrackInfo_Value(lastTrack, "I_RECINPUT", 3 - 1) -- to set recording input
      reaper.SetOnlyTrackSelected(lastTrack)
      
      -- 4) Create a AB Horizontal Right track
      reaper.Main_OnCommand(40001, 0) -- Insert track
      
      -- Set for the AB Horizontal Right track
      local lastTrackIndex = reaper.CountTracks(0) - 1
      local lastTrack = reaper.GetTrack(0, lastTrackIndex)
      reaper.SetMediaTrackInfo_Value(lastTrack, "I_RECARM", 1) -- to set track name
      reaper.GetSetMediaTrackInfo_String(lastTrack, "P_NAME", song .. "ABHorizontalRight", true)
      reaper.SetMediaTrackInfo_Value(lastTrack, "I_RECINPUT", 4 - 1) -- to set recording input
      reaper.SetOnlyTrackSelected(lastTrack)
      
      -- 5) Create a XY Left track
      reaper.Main_OnCommand(40001, 0) -- Insert track
      
      -- Set for the XY Left track
      local lastTrackIndex = reaper.CountTracks(0) - 1
      local lastTrack = reaper.GetTrack(0, lastTrackIndex)
      reaper.SetMediaTrackInfo_Value(lastTrack, "I_RECARM", 1) -- to set track name
      reaper.GetSetMediaTrackInfo_String(lastTrack, "P_NAME", song .. "XYLeft", true)
      reaper.SetMediaTrackInfo_Value(lastTrack, "I_RECINPUT", 5 - 1) -- to set recording input
      reaper.SetOnlyTrackSelected(lastTrack)
      
      -- 6) Create a XY Right track
      reaper.Main_OnCommand(40001, 0) -- Insert track
      
      -- Set for the XY Right track
      local lastTrackIndex = reaper.CountTracks(0) - 1
      local lastTrack = reaper.GetTrack(0, lastTrackIndex)
      reaper.SetMediaTrackInfo_Value(lastTrack, "I_RECARM", 1) -- to set track name
      reaper.GetSetMediaTrackInfo_String(lastTrack, "P_NAME", song .. "XYRight", true)
      reaper.SetMediaTrackInfo_Value(lastTrack, "I_RECINPUT", 6 - 1) -- to set recording input
      reaper.SetOnlyTrackSelected(lastTrack)
      
      
      -- 8) Create a Far track
      reaper.Main_OnCommand(40001, 0) -- Insert track
      
      -- Set for the Far track
      local lastTrackIndex = reaper.CountTracks(0) - 1
      local lastTrack = reaper.GetTrack(0, lastTrackIndex)
      reaper.SetMediaTrackInfo_Value(lastTrack, "I_RECARM", 1) -- to set track name
      reaper.GetSetMediaTrackInfo_String(lastTrack, "P_NAME", song .. "Far", true)
      reaper.SetMediaTrackInfo_Value(lastTrack, "I_RECINPUT", 8 - 1) -- to set recording input
      reaper.SetOnlyTrackSelected(lastTrack)
      
      -- 9) Create a Back track
      reaper.Main_OnCommand(40001, 0) -- Insert track
      
      -- Set for the Back track
      local lastTrackIndex = reaper.CountTracks(0) - 1
      local lastTrack = reaper.GetTrack(0, lastTrackIndex)
      reaper.SetMediaTrackInfo_Value(lastTrack, "I_RECARM", 1)
      reaper.GetSetMediaTrackInfo_String(lastTrack, "P_NAME", song .. "Back", true) -- to set track name
      reaper.SetMediaTrackInfo_Value(lastTrack, "I_RECINPUT", 7 - 1) -- to set recording input
      reaper.SetMediaTrackInfo_Value(lastTrack, "I_MIDIHWOUT", n_MIDI_device_index) -- to set MIDI Hardware output
      reaper.SetOnlyTrackSelected(lastTrack)
      
      -- Load MIDI track
      song_path = song_folder_path .. "/" .. song .. "/" .. song_name .. ".mid" -- <- COMMENT IN Audio909 CASE  
      --  song_path = song_folder_path .. "/" .. song .. "/" .. song .. song_name .. ".mid" -- <- UN-COMMENT IN Audio909 CASE  
      reaper.OpenMediaExplorer(song_path, true)
      
      -- Get media length
      local file = io.open(song_folder_path .. "/" .. song .. "/length.txt", "r")
      local length_seconds = tonumber(file:read("*all"))
      
      -- Update wait time
      wait_time_in_seconds = length_seconds + 5
      
      -- Start global recording
      reaper.CSurf_OnRecord()
      
      -- Update graphics
      reaper.UpdateArrange()
      
    end
    
    -- waiting code variables
    lasttime=os.time()
    loopcount=0
      
    -- run loop
    reaper.defer(runloop)
  end
end 

-- Waiting time loop recursive function
function runloop()
  local newtime=os.time()
  if (song_index < n_of_recordings+1) then
    if (loopcount < 1) then
      if reaper.GetPlayPosition() >= wait_time_in_seconds then
        lasttime=newtime
        -- do whatever you want to do every x seconds
        loopcount = loopcount+1
      end
    else
      -- Ending recording actions
      song = string.format("%03d", song_index)
      song_path = song_folder_path .. "/" .. song .. "/song.mid" -- <- COMMENT IN Audio909 CASE 
      --  song_path = song_folder_path .. "/" .. song .. "/" .. song .. song_name .. ".mid" -- <- UN-COMMENT IN Audio909 CASE  
      reaper.OpenMediaExplorer(song_path, false)
      reaper.CSurf_OnStop()
      song_index = song_index + 1
      
      -- New recording
      reaper.defer(newRecording)
      return
    end
    if 
      (loopcount < 2) then reaper.defer(runloop) 
    end
  else
    song = string.format("%03d", song_index)
    song_path = song_folder_path .. "/" .. song .. "/song.mid" -- <- COMMENT IN Audio909 CASE
    --  song_path = song_folder_path .. "/" .. song .. "/" .. song .. song_name .. ".mid" -- <- UN-COMMENT IN Audio909 CASE  
    reaper.OpenMediaExplorer(song_path, false)
    reaper.CSurf_OnStop()
    return
  end
end

-- main 
song_index = 1
reaper.defer(newRecording)
