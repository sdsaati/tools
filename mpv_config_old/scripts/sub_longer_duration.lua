DELAY = 0

-- Define a function to get the fps using ffmpeg
function get_fps(video_file)
    -- Create a temporary file to store the output
    local tmp_file = os.tmpname()

    -- Run a shell command that calls ffmpeg and writes the output to the temporary file
    local cmd = "ffmpeg -i \"" .. video_file .. "\" 2>&1 | sed -n 's/.*, \\(.*\\) tbr.*/\\1/p' > " .. tmp_file

    os.execute(cmd)

    -- Open the temporary file and read the output
    local tmp = io.open(tmp_file, "r")
    local output = tmp:read("*all")
    -- Close and delete the temporary file
    tmp:close()
    os.remove(tmp_file)

    -- Return the output as a string
    return output
end

function run()
    -- Get the video file name from mpv
    local video_file = mp.get_property("path")
    --=============================================
    -- Get the fps using ffmpeg
    local fps = get_fps(video_file)
    --=============================================
    if fps then
        mp.set_property("sub-fps", (fps-DELAY))
    end
    -- Print or display the fps
    mp.msg.warn("The fps is ",mp.get_property("estimated-vf-fps"))
    mp.msg.warn("sub-fps is ",mp.get_property("sub-fps"))
    -- mp.osd_message("The fps is " .. fps)
end
mp.register_event("start-file", run)
--mp.register_event("file-loaded", run)
