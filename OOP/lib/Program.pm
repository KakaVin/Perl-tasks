package Program;

sub new {
    my $proto = shift;
    my $class = ref($proto) || $proto;
    my $self  = {};
    bless( $self, $class );
    $self->{name}          = shift || undef;
    $self->{key_license}   = shift || undef;
    $self->{date_license}  = shift || undef;
    $self->{count_license} = shift || undef;
    return $self;
}

sub name {
    my ($self) = shift;
    if (@_) { $self->{name} = shift }
    return $self->{name};
}

sub key_license {
    my ($self) = shift;
    if (@_) { $self->{key_license} = shift }
    return $self->{key_license};
}

sub date_license {
    my ($self) = shift;
    if (@_) { $self->{date_license} = shift }
    return $self->{date_license};
}

sub count_license {
    my ($self) = shift;
    if (@_) { $self->{count_license} = shift }
    return $self->{count_license};
}
1;
