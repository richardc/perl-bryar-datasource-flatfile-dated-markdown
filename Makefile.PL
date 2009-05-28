use strict;
use ExtUtils::MakeMaker;
WriteMakefile(
    'NAME'         => 'Bryar::DataSource::FlatFile::Dated::Markdown',
    'VERSION_FROM' => 'lib/Bryar/DataSource/FlatFile/Dated/Markdown.pm',
    'PREREQ_PM'    => {
        'Date::Parse'                        => 0,
        'Text::Markdown'                     => 0,
        'Bryar::DataSource::FlatFile::Dated' => 0,
    },
);
