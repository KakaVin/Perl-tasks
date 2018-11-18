package User;
use parent qw(Host Server);

sub new {
    my $self = Server::new(shift);
    $host             = shift;
    $self->{name_net} = $host->{name_net};
    $self->{IP}       = $host->{IP};
    $self->{domain}   = $host->{domain};
    $self->{CPU}      = $host->{CPU};
    $self->{RAM}      = $host->{RAM};
    $self->{DISK}     = $host->{DISK};
    $self->{NET}      = $host->{NET};
    $host             = {};

    $self->{Login}    = shift || "undef";
    $self->{Password} = shift || "undef";
    $self->{age}      = shift || "undef";
    return $self;
}

sub open_program {
    my ($self) = shift;
    my $program = shift;
    $program->use();
}

sub get_Login {
    my ($self) = @_;
    return $self->{Login};
}

sub get_Password {
    my ($self) = @_;
    return $self->{Password};
}

sub get_age {
    my ($self) = @_;
    return $self->{age};
}

1;
