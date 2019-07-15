package SQL_API;

use DBI;

sub new {
    my $class = shift;
    my $self = {
        username => shift,
        password => shift,
        dbname => shift,
        host => shift,
    };

    bless $self, $class;

    $self->{driver} = "mysql";
    $self->{dsn} = "DBI:$self->{driver}:database=$self->{dbname}:$self->{host}";
    $self->{dbh} = DBI->connect($self->{dsn}, $self->{username}, $self->{password}) or die $DBI::errstr;

    return $self;
}

my $make_hash = sub {
    my $arr1_ref = shift;
    my $arr2_ref = shift;

    my %hash = ();
    
    for (my $i = 0; $i < scalar @$arr1_ref; $i++) {
        $hash{@$arr1_ref[$i]} = @$arr2_ref[$i];
    };

    return %hash;
};

sub read_db {
    my $self = shift;
    my $statement = shift;
    my @fields = @_;

    my $sth = $self->{dbh}->prepare($statement) or return undef;
    $sth->execute() or return undef;

    my @data = ();
    while (my @row = $sth->fetchrow_array()) {
        my %hash = $make_hash->(\@fields, \@row);
        push @data, (!@fields) ? \@row : \%hash;
    };

    return @data;
}

sub modify_db {
    my $self = shift;
    my $statement = shift;

    $self->{dbh}->do($statement) or die DBI::errstr;
}

sub terminate {
    my $self = shift;
    $self->{dbh}->disconnect;
}

1;
