use 5.016;
use Test::More;

diag("\ncorrect\n");
my %parse_email = parse_email('mail@example.com');
is $parse_email{'Mail'}, 'mail', 'mail correct';
is $parse_email{'Domain'}, 'example.com', 'domain correct';
%parse_email = parse_email('Name <mail@example.com>');
is $parse_email{'Name'}, 'Name', 'name correct';
is $parse_email{'Mail'}, 'mail', 'mail correct';
is $parse_email{'Domain'}, 'example.com', 'domain correct';
%parse_email = parse_email('"Ather Name" <mail@example.com>');
is $parse_email{'Name'}, 'Ather Name', 'name correct';
is $parse_email{'Mail'}, 'mail', 'mail correct';
is $parse_email{'Domain'}, 'example.com', 'domain correct';
%parse_email = parse_email('mail+ext@example.com');
is $parse_email{'Mail'}, 'mail+ext', 'mail correct';
is $parse_email{'Domain'}, 'example.com', 'domain correct';
%parse_email = parse_email('Name <mail+ext@example.com>');
is $parse_email{'Name'}, 'Name', 'name correct';
is $parse_email{'Mail'}, 'mail+ext', 'mail correct';
is $parse_email{'Domain'}, 'example.com', 'domain correct';
%parse_email = parse_email('"login"@example.com');
is $parse_email{'Login'}, 'login', 'login correct';
is $parse_email{'Domain'}, 'example.com', 'domain correct';
%parse_email = parse_email('"l o g i n"@example.com');
is $parse_email{'Login'}, 'l o g i n', 'login correct';
is $parse_email{'Domain'}, 'example.com', 'domain correct';
%parse_email = parse_email('Name "login"@example.com');
is $parse_email{'Name'}, 'Name', 'name correct';
is $parse_email{'Login'}, 'login', 'login correct';
is $parse_email{'Domain'}, 'example.com', 'domain correct';
%parse_email = parse_email('"Ather Name" "l o g i n"@example.com');
is $parse_email{'Name'}, 'Ather Name', 'name correct';
is $parse_email{'Login'}, 'l o g i n', 'login correct';
is $parse_email{'Domain'}, 'example.com', 'domain correct';

diag("\nnot correct\n");
%parse_email = parse_email('Name <mail@example.com');
is $parse_email{'Domain'}, undef, 'no parse';
%parse_email = parse_email('"mail@example.com');
is $parse_email{'Domain'}, undef, 'no parse';
%parse_email = parse_email('ma"il@example.com');
is $parse_email{'Domain'}, undef, 'no parse';
%parse_email = parse_email('Name mail@example.com>');
is $parse_email{'Domain'}, undef, 'no parse';
%parse_email = parse_email('"l o g i n"@example com');
is $parse_email{'Domain'}, undef, 'no parse';
%parse_email = parse_email('mail+ext+undef@example.com');
is $parse_email{'Domain'}, undef, 'no parse';
%parse_email = parse_email('mail@example.com.ru');
is $parse_email{'Domain'}, undef, 'no parse';
%parse_email = parse_email('"Ather Name "l o g i n"@example.com');
is $parse_email{'Domain'}, undef, 'no parse';

done_testing();

sub parse_email($){
	say my $mail = @_[0];
	my %return;
$mail =~ m{^
( 	( "(?'name'\N+)" \s ( "(?'login'\N+)" )* )  
	| 
	( (?'name'\w+)\s )
	| 
	(\s*)
)
(
	<(?'mail' (\w+) | (\w+\+\w+) ) @ (?'domain'\w+\.\w+)>
	|
	(
		(
			(?'mail' (\w+) | (\w+\+\w+) )
			|
			"(?'login'[^"]+)"
		)
		@ (?'domain'\w+\.\w+)
	)				
) $
}x;
$return{'Name'} = $+{name};
$return{'Mail'} = $+{mail};
$return{'Login'} = $+{login};
$return{'Domain'} = $+{domain};

return %return;
}