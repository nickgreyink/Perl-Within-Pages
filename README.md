# Perl-Within-Pages

No. No pragma. Maybe later. Going back to a script.

The file you want is pwp.pl. Everything else is just to test it.

This is just my little script to embed Perl into webpages and be able to throw things together very quickly.

I'm trying to figure out how to turn it into a pragma before perl 7 rolls out.

I like some of the concepts of PHP to be able to include all the different elements into one file and that file is called by the user and run to use all the part in the programs. Unlike in normal perl where you mush develop templetes completly seperate from the program file.

I'm sure ther are other ways around this, but this is how I do it, anyway.

You can now use regular perl file in the includes. You must start with a .pwp as your index file though.

Ex. : <pwp pwp_include("file.pl"); pwp>

To use PWP use like:

perl.exe pwp.pl your_index_file.pwp

Here is a PHP to Perl Within Pages conversion tool:

Open with: <pwp

Close With: pwp>

Include: pwp_include("./file.pwp"); (For right now you have to use one dot to go back up to the parent folder instead of two. Working on that.)