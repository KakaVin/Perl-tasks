use 5.016;
use warnings;
use strict;
use lib 'lib';
use Server;
use Host;
use Owner;
use Program;
use Test::More;

my $admin = new Owner( "Dimon",  "123", 40 );
my $user1 = new Owner( "Alex",   "123", 22 );
my $user2 = new Owner( "Sergey", "123", 32 );

my $program1 = new Program( "Excel",     "25d2f4242",  "12:02:2020", 20 );
my $program2 = new Program( "Photoshop", "df85df2475", "20:10:2021", 2 );

my $server1 = new Server( $admin, "Servers", "10.10.10.1/30",   "example.com" );
my $server2 = new Server( $admin, "Servers", "10.10.10.2/30",   "example.com" );
my $server3 = new Server( $admin, "Users",   "10.10.56.101/24", "example.com" );

my $host1 = new Host( $admin, "CPU1", "RAM1", "DISK1", "NET1" );
my $host2 = new Host( $admin, "CPU2", "RAM2", "DISK2", "NET2" );

$server1->hosts( $host1, $host2 );

#$host1->programs( $user1, $program1, $program2 );
#$host2->programs( $user2, $program1 );

#is $server2, $admin->owns->[1];
is $host1, $server1->hosts->[0];
is $host2->programs->[0], $user2->owns->[0];
done_testing();

$server1->close();
$server1 = $host1 = $host2 = undef;

select( undef, undef, undef, 5 );
say "конец программы";
