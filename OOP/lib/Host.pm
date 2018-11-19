package Host;

sub new {
    my $proto = shift;
    my $class = ref($proto) || $proto;
    my $self  = {};
    bless( $self, $class );
    $self->{CPU}  = shift || "undef";
    $self->{RAM}  = shift || "undef";
    $self->{DISK} = shift || "undef";
    $self->{NET}  = shift || "undef";
    $self->{programs} = [];
    return $self;
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
    if (@_) {
        for ( my $var = 0 ; $var <= $#_ ; $var++ ) {
            die "run out of licenses in $_[$var]->{name} $!"
              if $_[$var]->count_license - 1 < 0;

            $_[$var]->count_license( $_[$var]->count_license - 1 );
        }
        @{ $self->{programs} } = @_;
    }
    return $self->{programs};
}
1;
