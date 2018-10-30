use 5.016;

my $catalog = "/home/alex/Рабочий стол";
my $pattern = "sub";

show_dir($catalog);

sub show_dir($){
my $dir = $_[0];
opendir(my $d, "$dir") or die "$dir $!";
for ( readdir($d) ) { 
	next if $_=~ /\.\.?$/;
	if (-T "$dir/$_") { 
		open (InFile, "$dir/$_") or die $!;
		my $num_line = 0;
		while ( my $line = <InFile> )
		{
			$num_line++;
			print "$dir/$_:$num_line:# $line" if $line =~ /$pattern/
		}
		close (InFile);
	} 
	if (-d "$dir/$_") {
		show_dir("$dir/$_");
	};
};
#closedir($d) or warn $!;
}