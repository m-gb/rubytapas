# Ruby provides a shortcut for reading a file into memory and dividing it into lines all at once. It's called File.readlines.
lines = File.readlines("mail.txt", "\r\n") # Filename and an optional delimeter string that indicates linebreaks.
lines
# => ["MIME-Version: 1.0\r\n",
#     "Received: by 10.112.223.164 with HTTP; Tue, 2 Sep 2014 15:17:21 -0700 (PDT)\r\n",
#     "Date: Tue, 2 Sep 2014 18:17:21 -0400\r\n",
#     "Delivered-To: gibbons@example.com\r\n",
#     "Message-ID: <CA+XG7-iiZQ0SAzgg+2ci==fcbCwvEQP413W8mEBdfu_t0rDAWg@mail.gmail.com>\r\n",
#     "Subject: TPS Reports\r\n",
#     "From: Bill Lumberg <lumberg@example.com>\r\n",
#     "To: Peter Gibbons <gibbons@example.com>\r\n",
#     "Content-Type: text/plain; charset=UTF-8\r\n",
#     "\r\n",
#     "Yeah... if you could just fill out your TPS reports... that'd be great...\r\n"]

lines = File.readlines("mail.txt", "\r\n")
line = lines.shift until line == "\r\n" # removes first element of the array.
lines.join
# => "Yeah... if you could just fill out your TPS reports... that'd be great...\r\n"


# In a single line of chained message sends:
# drop_while takes a block. The block receives one line at a time, and functions as a predicate.
# The method drops items, until it finds one that fails the predicate.
# By contrast, the version using #drop_while leaves the list of lines untouched
File.readlines("mail.txt", "\r\n").drop_while{|l| l != "\r\n"}
# => ["\r\n",
#     "Yeah... if you could just fill out your TPS reports... that'd be great...\r\n"]

File.readlines("mail.txt", "\r\n").drop_while{|l| l != "\r\n"}.drop(1) # #drop drops however many elements are requested.
# => ["Yeah... if you could just fill out your TPS reports... that'd be great...\r\n"]


File.readlines("mail.txt", "\r\n").drop_while{|l| l != "\r\n"}.drop(1).join
# => "Yeah... if you could just fill out your TPS reports... that'd be great...\r\n"