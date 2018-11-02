use 5.016;
use Getopt::Std;
use Cwd;

our ( $opt_p, $opt_c );
getopts("p:c:");
my $pattern = $opt_p || die "-p pattern undifinded $!";
my $catalog = $opt_c || Cwd::abs_path();
show_dir( $catalog, 'lol' );

sub show_dir($) {
    my $dir = $_[0];
    opendir( my $d, "$dir" ) or die "$dir $!";
    for ( readdir($d) ) {
        if ( -T "$dir/$_" && -R "$dir/$_" ) {
            open( my $in, "$dir/$_" ) or die $!;
            my $num_line = 0;
            while ( my $line = <$in> ) {
                chomp $line;
                $num_line++;
                say "$dir/$_:$num_line:# $line" if $line =~ /$pattern/i;
            }
            close($in) or warn $!;
        }
        if ( -d "$dir/$_" && -R "$dir/$_" ) {
            next if $_ =~ /\.\.?$/;
            show_dir("$dir/$_");
        }
    }
    closedir($d) or warn $!;
}
