width  = 960
height = 600
recording_options = %W[-f x11grab -s #{width}x#{height} -i 0:0+800,300 -r 30]
misc_options      = %W[-sameq -threads 6]
output_options    = %W[screencast.mp4]

ffmpeg_flags =
    recording_options +
    misc_options +
    output_options

system "ffmpeg", *ffmpeg_flags
