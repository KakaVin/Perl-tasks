package Host;

sub new {
    my $proto = shift;
    my $class = ref($proto) || $proto;
    my $self  = {};
    bless( $self, $class );
    $self->{owner} = shift || undef;
    $self->{CPU}   = shift || undef;
    $self->{RAM}   = shift || undef;
    $self->{DISK}  = shift || undef;
    $self->{NET}   = shift || undef;
    $self->{programs} = [];

    $self->{owner}->owns($self);
    return $self;
}

sub close {
    my ($self) = shift;
    $self->{owner}->dell($self);

    #print "close Host, @ program = " . ( $#{ $self->{programs} } + 1 ) . "\n";
    for ( my $var = 0 ; $var <= $#{ $self->{programs} } ; $var++ ) {
        $self->{programs}[$var]
          ->count_license( $self->{programs}[$var]->count_license + 1 );
    }
}

sub owner {
    my ($self) = shift;
    if (@_) { $self->{owner} = shift }
    return $self->{owner};
}

sub CPU {
    my ($self) = shift;
    if (@_) { $self->{CPU} = shift }
    return $self->{CPU};
}

sub RAM {
    my ($self) = shift;
    if (@_) { $self->{RAM} = shift }
    return $self->{RAM};
}

sub DISK {
    my ($self) = shift;
    if (@_) { $self->{DISK} = shift }
    return $self->{DISK};
}

sub NET {
    my ($self) = shift;
    if (@_) { $self->{NET} = shift }
    return $self->{NET};
}

sub programs {
    my ($self) = shift;
    my $own = shift;
    if (@_) {
        for ( my $var = 0 ; $var <= $#_ ; $var++ ) {
            die "run out of licenses in $_[$var]->{name} $!"
              if $_[$var]->count_license - 1 < 0;

            $_[$var]->count_license( $_[$var]->count_license - 1 );
            $own->owns( $_[$var] );
        }
        @{ $self->{programs} } = @_;
    }
    return $self->{programs};
}

sub DESTROY {
    my ($self) = shift;
    print "$self dying " . $self->CPU, ' ', scalar localtime, "\n";

}
1;
