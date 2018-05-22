#!/opt/local/bin/perl

# download and process an array of arrays of artist playlists.
# in other words, the discographies of all the artists in a genre - 
# or any set of artists you want.
# google search parameters: 
#  " albumName " "inurl:playlist" ["artistName - topic"] [+inurl:("/channel/")] site:youtube.com

# 4-dimensional array for defining the collection of artists. 
# bash doesn't support lists, objects, or multidimensional arrays, 
# so I implemented this in perl.
# the scalar function gives the true length of the array; the $#AoA expression gives the last index of the array.
# scalar won't evaluate properly inside a print string, but it will evaluate properly in a loop.

# how to dynamically reference the albums collection for an artist
# https://stackoverflow.com/questions/16793937/size-of-2d-array-in-perl
#  ?utm_medium=organic&utm_source=google_rich_qa&utm_campaign=google_rich_qa

# this line is critical; the arrays won't work without it
use 5.010;

# the array.
@AoA =
(
	 [ "Snap", 
    [
      ["WorldPower","https://www.youtube.com/playlist?list=PLZ5aAqezopeP7Hl722KqodPkPQ7JU5ryh"],
      ["TheMadmansReturn","https://www.youtube.com/playlist?list=PL-jJxriTHjenZhOPcfl4XNhZpyKCUStjK"],
      ["WelcomeToTomorrow","https://www.youtube.com/playlist?list=PLnOzkbFUO3VXh_6bet8LMks-6m9zf9Nmi"]
    ]
  ]
);
# the length of the array.
$artistCount = scalar(@AoA);

# artists collection loop
for ($l=0; $l<=scalar(@AoA)-1; $l++)
{
  # create the artists' directory and cd into it
  mkdir $AoA[$l][0];
  chdir $AoA[$l][0];
  # loop through the artist's discography
  for ($k=0; $k<=scalar(@{$AoA[$l][1]})-1; $k++)
  {
    # create a directory for the album and cd into it
    mkdir $AoA[$l][1][$k][0];
    chdir $AoA[$l][1][$k][0];
    # download the songs for the album
    system("youtube-dl","-ci", "$AoA[$l][1][$k][1]") == 0;
    
    # process each song for the album. First, convert to mp3 44x128.
    # then, normalize the volume.
    @files = glob("*.mkv *.mp4 *.webm");
		  foreach $file (@files)
		  {
      # if the file exists
      if ( -f $file )
			   {
        # remove its extension (sub supports multiple periods)
        $thefilename = remove_extension($file);
				    # build the ffmpeg - sox command line
        $thepipingcommand = "ffmpeg -i '$file' -ar 44100 -b:a 128k -f mp3 pipe:1 |
				                         sox --type mp3 --norm - '$thefilename.mp3'";
				    # run it then delete the video file
        system($thepipingcommand) == 0;
        unlink($file);
			   }
		  }
    # cd out and move on to the next album
    chdir "..";
  }
  # cd out and move on to the next artist
  chdir "..";
}

# sub (void function) to properly remove a filespecs' extension
sub remove_extension
{
my $filename = shift @_;
$filename =~ s/
						 (.)             # matches any character
						 \.              # the literal dot starting an extension
						 [^.]+           # one or more NON-dots
						 $               # end of the string
						 /$1/x;
return $filename;
}
