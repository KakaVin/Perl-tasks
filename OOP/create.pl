use 5.016;
use warnings;
use strict;
use lib 'lib';
use Server;
use Host;
use User;
use Program;

my $server1 = new Server( "Servers", "10.10.10.1/30",   "example.com" );
my $server2 = new Server( "Servers", "10.10.10.2/30",   "example.com" );
my $server3 = new Server( "Users",   "10.10.56.101/24", "example.com" );
$server1->print_all_info('$server1');

my $host1 = $server1->new_Host( "CPU1", "RAM1", "DISK1", "NET1" );
my $host2 = $server3->new_Host( "CPU2", "RAM2", "DISK2", "NET2" );
my $host3 = $host2->new_Host( "CPU3", "RAM3", "DISK3", "NET3" );

my $user1 = $host1->new_User( "Dimon",  "123", 40 );
my $user2 = $host2->new_User( "Alex",   "123", 22 );
my $user3 = $host2->new_User( "Sergey", "123", 32 );

my $program1 = new Program( "Excel",     "25d2f4242",  "12:02:2020", 20 );
my $program2 = new Program( "Photoshop", "df85df2475", "20:10:2021", 2 );

$user2->open_program($program2);
$user1->open_program($program1);
$user1->open_program($program2);
$user3->open_program($program1);
