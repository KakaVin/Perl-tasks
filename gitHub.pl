use 5.016;
use LWP::Simple;
use Time::Piece;
use JSON::PP;
my $user = "kraih";
my $rangeDate = localtime->add_years(-1);
my @nameRepos;
my $marking;
my $getJson = get("https://api.github.com/users/$user/repos") or die;
my $json = decode_json( $getJson );
for (my $i = 0; $i != 100; $i++){
	if ( $json->[$i]{'name'} ne '' ){
		@nameRepos[$i] = $json->[$i]{'name'};
		} else { last }
}
say "User \"$user\" repositories: ", scalar @nameRepos;
say "Date ", $rangeDate->ymd,"  -  ",localtime->ymd,"\n";
for my $i( 0..$#nameRepos ){
	my @dateCommit;
	$getJson = get( "https://api.github.com/repos/$user/@nameRepos[$i]/commits" );
	$json = decode_json( $getJson );
	for (my $i = 0; $i != 100; $i++){
		if ( $json->[$i]{'commit'}{'author'}{'date'} ne '' ){
			@dateCommit[$i] = $json->[$i]{'commit'}{'author'}{'date'};
		} else { last }
	}
	$marking = 0;
	ShowRepos( @nameRepos[$i], @dateCommit );
	if ( $marking == 0 ){ say "no commits last year\n" }
}
sub ShowRepos{
	say "Name:   ", @_[0];
	my @datePiece;
	for (my $i = 1; $i < scalar @_; $i++){
		my $datePiece = Time::Piece->strptime( @_[$i], '%Y-%m-%dT%H:%M:%SZ' );
		if ( $datePiece >= $rangeDate ){ 
			push @datePiece, $datePiece;
			if ( $marking == 0 ){ 
				$marking = 1;
				print "   ";
				for (my $line = 0; $line < 24; $line++){
					if ( $line < 10 ){
						print "  ", $line } 
						else {
						print " ", $line }
					if ( $line == 23 ){ print "\n" }
				}
			}
		}
	}
	for my $i(1..7){ PrintLine($i, @datePiece) }
	if ( $marking == 1 ){ say; }
}	
sub PrintLine{
	my @hour = (0) x 24;
	my @day;
	for (my $i = 1; $i < scalar @_; $i++){
		if ( @_[$i]->wday == @_[0] ){ 
			@hour[ ( @_[$i]->hour ) ]++;
			@day = @_[$i]->day;
		} 
	}
	my $returLine = "";
	my $print = 0;
	for (my $i = 0; $i < scalar @hour; $i++){
		if ( @hour[$i] ){ $returLine .="   " }
		if ( @hour[$i] >= 10 ){
			$returLine .= " @hour[$i]";
			$print++;
		} 
		if ( @hour[$i] < 10 and @hour[$i] > 0 ){
			$returLine .= "  @hour[$i]";
			$print++;
		} 	
	}
	if ( $print ){ print @day, $returLine, "\n" }
}