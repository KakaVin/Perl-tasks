package Host;
use User;
use parent Server;

sub new {
    my $self = Server::new(shift);
    $server           = shift;
    $self->{name_net} = $server->{name_net};
    $self->{IP}       = $server->{IP};
    $self->{domain}   = $server->{domain};
    $server           = {};
    $self->{CPU}  = shift || "undef";
    $self->{RAM}  = shift || "undef";
    $self->{DISK} = shift || "undef";
    $self->{NET}  = shift || "undef";
    return $self;
}

sub new_User($$$$) {
    my ($self) = shift;
    return new User( $self, @_ );
}

sub get_CPU {
    my ($self) = @_;
    return $self->{CPU};
}

sub get_RAM {
    my ($self) = @_;
    return $self->{RAM};
}

sub get_DISK {
    my ($self) = @_;
    return $self->{DISK};
}

sub get_NET {
    my ($self) = @_;
    return $self->{NET};
}
1;
