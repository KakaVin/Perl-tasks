package Server;

sub new {
    my $proto = shift;
    my $class = ref($proto) || $proto;
    my $self  = {};
    bless( $self, $class );
    $self->{name_net} = shift || "undef";
    $self->{IP}       = shift || "undef";
    $self->{domain}   = shift || "undef";
    $self->{hosts}    = [];
    return $self;
}

sub name_net {
    my ($self) = shift;
    if (@_) { $self->{name_net} = shift }
    return $self->{name_net};
}

sub IP {
    my ($self) = shift;
    if (@_) { $self->{IP} = shift }
    return $self->{IP};
}

sub domain {
    my ($self) = shift;
    if (@_) { $self->{domain} = shift }
    return $self->{domain};
}

sub hosts {
    my ($self) = shift;
    if (@_) { @{ $self->{hosts} } = @_ }
    return $self->{hosts};
}

1;
