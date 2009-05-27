package Bryar::DataSource::FlatFile::Dated::Markdown;
use strict;
use warnings;
use base qw( Bryar::DataSource::FlatFile::Dated );
use Text::Markdown;
use Date::Parse qw( str2time );
our $VERSION = '1.0';

sub make_document {
    my ($self, $file) = @_;
    my $document = $self->SUPER::make_document( $file );
    return unless $document;

    # Do what we came for, invoke Markdown
    # We are bad programmers, we're violating encapsulation of Bryar::Document
    $document->{content} = Text::Markdown->new->markdown( $document->content );

    # this is probably the wrong place for this but ::Dated doesn't
    # parse the timestamp to an epoch as the documentation suggests it would
    $document->{epoch} = str2time( $document->epoch );

    return $document;
}

1;
