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

__END__
=head1 NAME

Bryar::DataSource::FlatFile::Dated::Markdown

=head1 SYNOPSIS

Add this to your C<bryar.conf>

 source: Bryar::DataSource::FlatFile::Dated::Markdown
 
And then you can format your entries using Markdown for the bodies, like so:

 2009-01-01Z00:00:01
 Happy New Year
 
 This blog is using [Markdown][] formatting as provided by [Text::Markdown][].
 
 [Markdown]: http://daringfireball.net/projects/markdown/
 [Text::Markdown]: http://search.cpan.org/dist/Text-Markdown/

=head1 DESCRIPTION

This is a simple datasource module that allows you to compose posts on your
Bryar powered blog using Markdown.

=head1 AUTHOR

Richard Clamp <richardc@unixbeard.net>

=head1 SEE ALSO

L<Bryar> L<Text::Markdown>

=cut
