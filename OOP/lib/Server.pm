package Server;

sub new {
    my $proto = shift;
    my $class = ref($proto) || $proto;
    my $self  = {};
    bless( $self, $class );
    $self->{owner}    = shift || undef;
    $self->{name_net} = shift || undef;
    $self->{IP}       = shift || undef;
    $self->{domain}   = shift || undef;
    $self->{hosts}    = [];

    $self->{owner}->owns($self);
    return $self;
}

sub close {
    my ($self) = shift;
    my $delhost = shift;
    if ($delhost) {
        for ( my $var = 0 ; $var <= $#{ $self->{hosts} } ; $var++ ) {
            if ( @{ $self->{hosts} }[$var] == $delhost ) {
                @{ $self->{hosts} }[$var]->close();
                splice @{ $self->{hosts} }, $var, 1;
            }
        }
    }
    else {
        $self->{owner}->dell($self);
        for ( my $var = 0 ; $var <= $#{ $self->{hosts} } ; $var++ ) {
            @{ $self->{hosts} }[$var]->close();
        }
    }
}

sub owner {
    my ($self) = shift;
    if (@_) { $self->{owner} = shift }
    $self->{owner}->owns($self);
    return $self->{owner};
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
    if (@_) {
        @{ $self->{hosts} } = @_;
    }
    return $self->{hosts};
}

sub DESTROY {
    my ($self) = shift;
    print "$self dying ", scalar localtime, "\n";
}
1;
