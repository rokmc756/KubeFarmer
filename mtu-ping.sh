# [ MacOS ]
# On Mac OSX (that I run) it’s:
# ping -D -s 8184 [destinationIP]
#
# Note: Some commenters have noted that in newer versions of macOS (unknown from what version - but effective in 11.x and 12.x at least) that the max frame size for the ping should be as follows:


# ping -D -s 8164 [destinationIP]
#
# [ Linux ]
# On Linux it’s:

for i in `echo 1 71 72 73 74 75 76 77`
do
    sudo ping -M do -s 8972 192.168.1.$i
done


# [ Windows ]
# On Windows it’s:
# sudo ping -f -l 9000 192.168.1.$i
#
#
# [ References ]
# https://blah.cloud/networks/test-jumbo-frames-working/
#

