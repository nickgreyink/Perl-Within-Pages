# Perl-Within-Pages

The file you want is pwp.pl. Everything else is just to test it.

This is just my little script to embed Perl into webpages and be able to throw things together very quickly.

I'm trying to get is working before Perl 7 comes out and maybe see if this can help Perl be a dominante Web force once more.

I like some of the concepts of PHP to be able to include all the different elements into one file and that file is called by the user and run to use all the part in the programs. Unlike in normal perl where you must develop templetes completly seperate from the program file.

I'm sure ther are other ways around this, but this is how I do it, anyway.

FEATURES:

1. Uses pwp_include(); to include file like PHP's include.
    a. You can use regular perl file in the pwp_includes. You must start with a .pwp as your index file though.
    b. Ex. : <pwp pwp_include("file.pl"); pwp>
    c. To go up the parent tree you have to go ./file.pl not ../file.pl.
    d. To use a file in the same folder just use file.pl not ./file.pl.
3. Can use any file as you index file like:
    perl.exe pwp.pl your_index_file.pl
    a. Will look for index.pl or default.pl automatically though.
4. PWP segments
    a. Start with: <pwp
    b. End with: pwp>

If your file is pure perl you don not need <pwp pwp> to use. You can also use pwp_include() in pure Perl. You just need <pwp pwp> if you are including regular HTML.

As far as I know all of perl can be used within the <pwp pwp> tags. Please let me know if there is something that doesn't in issues.

Notes:

Working on the security of the script to make sure it works okay. Please let me know if you find any glitches or security issues and out them in the issues tab. Thanks.

Trying to get this to work with CGI or FastCGI, but can't seem to find info about how to get an interpreter to ruin FastCGI on the server side.