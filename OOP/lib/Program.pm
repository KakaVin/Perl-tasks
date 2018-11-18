package Program;

sub new {
    my $proto = shift;
    my $class = ref($proto) || $proto;
    my $self  = {};
    bless( $self, $class );
    $self->{name}        = shift || "undef";
    $self->{key}         = shift || "undef";
    $self->{date}        = shift || "undef";
    $self->{count_users} = shift || "undef";
    return $self;
}

sub total {
    my ($self) = shift;
    print $self->{count_users} . "\n";
}

sub use {
    my ($self) = shift;
    if ( $self->{count_users} > 0 ) {
        $self->{count_users}--;
    }
    else {
        die "the keys are over";
    }

    sub get_name {
        my ($self) = @_;
        return $self->{name};
    }

    sub get_key {
        my ($self) = @_;
        return $self->{key};
    }

    sub get_date {
        my ($self) = @_;
        return $self->{date};
    }

    sub get_count_users {
        my ($self) = @_;
        return $self->{count_users};
    }
}
1;
