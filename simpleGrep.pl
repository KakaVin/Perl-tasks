use 5.016;
use Getopt::Std;

getopts("p:c:");
our($opt_p, $opt_c);
my $pattern = $opt_p;
show_dir($opt_c);

sub show_dir($){
my $dir = $_[0];
opendir(my $d, "$dir") or die "$dir $!";
for ( readdir($d) ) { 
	next if $_=~ /\.\.?$/;
	if (-T "$dir/$_" && -R "$dir/$_") { 
		open (InFile, "$dir/$_") or die $!;
		my $num_line = 0;
		while ( my $line = <InFile> )
		{
			$num_line++;
			print "$dir/$_:$num_line:# $line" if $line =~ /$pattern/i;
		}
		close (InFile);
	} 
	if (-d "$dir/$_" && -R "$dir/$_") {
		show_dir("$dir/$_");
	};
};
closedir($d) or warn $!;
}