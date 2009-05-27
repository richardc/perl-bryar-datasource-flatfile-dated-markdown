package Bryar::DataSource::FlatFile::Dated::Markdown;
use strict;
use warnings;
use base qw( Bryar::DataSource::FlatFile );
use Text::Markdown;
use Date::Parse qw( str2time );
use File::Basename qw( dirname );
our $VERSION = '1.0';

# liberally ripped off from Bryar::DataSource::FlatFile::Dated
*_read_comments = \&Bryar::DataSource::FlatFile::_read_comments; 

sub make_document {
    my ($self, $file) = @_;
    return unless $file;
    open(my($in), $file) or return;
    local $/ = "\n";
    my $who = getpwuid((stat $file)[4]);

    $file =~ s/\.txt$//;
    my $when  = <$in>;
    $when = str2time( $when );
    my $title = <$in>;
    chomp $title;
    local $/;
    my $content = <$in>;
    close $in;

    $content = Text::Markdown->new->markdown( $content );

    my $comments = [];
    $comments = [_read_comments($file, $file.".comments") ]
        if -e $file.".comments";

    my $dir = dirname($file);
    $dir =~ s{^\./?}{};
    my $category = $dir || "main";
    return Bryar::Document->new(
        title    => $title,
        content  => $content,
        epoch    => $when,
        author   => $who,
        id       => $file,
        category => $category,
        comments => $comments
    );
}

1;
