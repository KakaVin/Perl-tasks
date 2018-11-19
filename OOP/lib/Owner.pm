package Owner;

sub new {
    my $proto = shift;
    my $class = ref($proto) || $proto;
    my $self  = {};
    bless( $self, $class );
    $self->{Login}    = shift || "undef";
    $self->{Password} = shift || "undef";
    $self->{age}      = shift || "undef";
    $self->{owns}     = [];
    return $self;
}

sub Login {
    my ($self) = shift;
    if (@_) { $self->{Login} = shift }
    return $self->{Login};
}

sub Password {
    my ($self) = shift;
    if (@_) { $self->{Password} = shift }
    return $self->{Password};
}

sub age {
    my ($self) = shift;
    if (@_) { $self->{age} = shift }
    return $self->{age};
}

sub NET {
    my ($self) = shift;
    if (@_) { $self->{NET} = shift }
    return $self->{NET};
}

sub owns {
    my ($self) = shift;
    if (@_) { @{ $self->{owns} } = @_ }
    return $self->{owns};
}

1;
