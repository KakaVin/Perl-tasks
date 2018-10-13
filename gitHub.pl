use 5.016;
use LWP::Simple;
use Time::Piece;
my $user = "kraih";
my $localDate = localtime;
my $rangeDate = $localDate->add_years(-1);
my @Repos;
my $getRepos = get("https://api.github.com/users/$user/repos");
my $marking;
while ($getRepos =~ /(?:"commits_url":")(?=(\N+?)\{)/g){
	push (@Repos, $1);
}
say "User \"$user\" repositories:   ", scalar @Repos;
say "Date ", $rangeDate->ymd,"  -  ",$localDate->ymd;

foreach my $i(0..$#Repos){
	my @dateCommit = ();
	$getRepos = get(@Repos[$i]);
	while ($getRepos =~ /(?:"date":")(?=(\N+?):)/g)
	{
		push (@dateCommit, $1);
	}
$marking = 0;
ShowRepos(@Repos[$i], @dateCommit);
if ($marking == 0){say "no commits last year\n"}
}
#####################################################################
sub ShowRepos{
say "Name:   ", @_[0] =~ /(?:$user\/)(?=(\N+?)\/)/g;
my @date_Piece;
for (my $i = 1; $i < scalar @_; $i++){
	my $date_Piece = Time::Piece->strptime(@_[$i], '%Y-%m-%dT%H');
	if($date_Piece >= $rangeDate ){	
	push(@date_Piece, $date_Piece); 
	if ($marking == 0){$marking =1}
	}
	if ($marking == 1 ){
		print "   ";
		for (my $line = 0; $line < 24; $line++){
		if($line<10){print "  ",$line}else{print " ",$line}
		if($line == 23){print "\n"}
		$marking = 2;
		}
	}
};
foreach my $i(1..7){getLine($i ,@date_Piece)}
if ($marking == 2){say;}
}
#####################################################################
sub getLine{
my @hour = (0) x 24;
my @day;
for (my $i = 1; $i < scalar @_; $i++){
	if (@_[$i]->wday == @_[0]){@hour[(@_[$i]->hour)]++; @day = @_[$i]->day} 
}
my $returLine = "";
my $print = 0;
for (my $i = 0; $i < scalar @hour; $i++){
	if (@hour[$i] == 0 ){$returLine = $returLine."   "}
	if (@hour[$i] >10 ){$returLine = $returLine." @hour[$i]";$print++} 
	if (@hour[$i] <10 and @hour[$i] >0 ){$returLine = $returLine."  @hour[$i]";$print++} 	
}
if ($print){
	print @day, $returLine, "\n";
}
}