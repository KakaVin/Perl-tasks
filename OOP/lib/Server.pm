package Server;
use Host;

sub new {
    my $proto = shift;
    my $class = ref($proto) || $proto;
    my $self  = {};
    bless( $self, $class );
    $self->{name_net} = shift || "undef";
    $self->{IP}       = shift || "undef";
    $self->{domain}   = shift || "undef";
    return $self;
}

sub new_Host($$$$) {
    my ($self) = shift;
    return new Host( $self, @_ );
}

sub get_name_net {
    my ($self) = @_;
    return $self->{name_net};
}

sub get_IP {
    my ($self) = @_;
    return $self->{IP};
}

sub get_domain {
    my ($self) = @_;
    return $self->{domain};
}

sub print_all_info($$) {
    my ($self) = shift;
    print "\nTotal info: " . shift . "\n";
    while ( my ( $key, $value ) = each(%$self) ) {
        print "$key => $value\n";
    }
    print "\n";
}

1;
