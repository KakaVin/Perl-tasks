use 5.016;
use Test::More;
my %return;

parse_email('mail@example.com');
is $return{'Mail'}, 'mail', 'mail correct';
is $return{'Domain'}, 'example.com', 'domain correct';

parse_email('Name <mail@example.com>');
is $return{'Name'}, 'Name', 'name correct';
is $return{'Mail'}, 'mail', 'mail correct';
is $return{'Domain'}, 'example.com', 'domain correct';

parse_email('"Ather Name" <mail@example.com>');
is $return{'Name'}, 'Ather Name', 'name correct';
is $return{'Mail'}, 'mail', 'mail correct';
is $return{'Domain'}, 'example.com', 'domain correct';

parse_email('mail+ext@example.com');
is $return{'Mail'}, 'mail+ext', 'mail correct';
is $return{'Domain'}, 'example.com', 'domain correct';

parse_email('Name <mail+ext@example.com>');
is $return{'Name'}, 'Name', 'name correct';
is $return{'Mail'}, 'mail+ext', 'mail correct';
is $return{'Domain'}, 'example.com', 'domain correct';

parse_email('"login"@example.com');
is $return{'Login'}, 'login', 'login correct';
is $return{'Domain'}, 'example.com', 'domain correct';

parse_email('"l o g i n"@example.com');
is $return{'Login'}, 'l o g i n', 'login correct';
is $return{'Domain'}, 'example.com', 'domain correct';

parse_email('Name "login"@example.com');
is $return{'Name'}, 'Name', 'name correct';
is $return{'Login'}, 'login', 'login correct';
is $return{'Domain'}, 'example.com', 'domain correct';

parse_email('"Ather Name" "l o g i n"@example.com');
is $return{'Name'}, 'Ather Name', 'name correct';
is $return{'Login'}, 'l o g i n', 'login correct';
is $return{'Domain'}, 'example.com', 'domain correct';

done_testing();

sub parse_email{
	say my $mail = @_[0];
$mail =~ m{
( 	( "(?'name'\N+)" \s<* ( "(?'login'\N+)" )* )  
	| 
	( (?'name'\w+)\s<* )
	| 
	(\W*)
)
(
	(?'mail' (\w+) | (\w+\+\w+) ) 
	| 
	"(?'login'\N+)"
)
	@
	(?'domain'\w+.\w+)	
}x;
$return{'Name'} = $+{name};
$return{'Mail'} = $+{mail};
$return{'Login'} = $+{login};
$return{'Domain'} = $+{domain};
}