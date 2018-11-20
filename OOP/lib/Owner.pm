package Owner;

sub new {
    my $proto = shift;
    my $class = ref($proto) || $proto;
    my $self  = {};
    bless( $self, $class );
    $self->{login}    = shift || "undef";
    $self->{password} = shift || "undef";
    $self->{age}      = shift || "undef";
    $self->{owns}     = [];
    return $self;
}

sub dell {
    my ($self) = shift;
    my $close = shift;
    for ( my $var = 0 ; $var <= $#{ $self->{owns} } ; $var++ ) {
        if ( @{ $self->{owns} }[$var] == $close ) {
            print @{ $self->{owns} }[$var]->IP;
            splice @{ $self->{owns} }, $var, 1;
        }
    }
    print "\n" . ( $#{ $self->{owns} } + 1 ) . "\n";
}

sub login {
    my ($self) = shift;
    if (@_) { $self->{login} = shift }
    return $self->{login};
}

sub password {
    my ($self) = shift;
    if (@_) { $self->{password} = shift }
    return $self->{password};
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
    if (@_) { push @{ $self->{owns} }, @_ }
    return $self->{owns};
}

1;
