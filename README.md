# Env::ShellWords [![Build Status](https://secure.travis-ci.org/plicease/Env-ShellWords.png)](http://travis-ci.org/plicease/Env-ShellWords)

Environment variables for arguments as array

# SYNOPSIS

    # Tie Interface
    use Env::ShellWords;
    tie my @CFLAGS,   'CFLAGS';
    tie my @LDFLAGS,  'LDFLAGS';

    # same thing with import interface:
    use Env::ShellWords qw( @CFLAGS @LDFLAGS );
    
    # usage:
    $ENV{CFLAGS} = '-DBAR=1';
    unshift @CFLAGS, '-I/foo/include';
    push @CFLAGS, '-DFOO=Define With Spaces';
    
    # now:
    # $ENV{CFLAGS} = '-I/foo/include -DBAR=1 -DFOO=Define\\ With\\ Spaces';
    
    unshift @LDFLAGS, '-L/foo/lib';
    push @LDFLAGS, '-lfoo';

# DESCRIPTION

This module provides an array like interface to environment variables
that contain flags.  For example Autoconf can uses the environment
variables like `CFLAGS` or `LDFLAGS`, and this allows you to manipulate
those variables without doing space quoting and other messy mucky stuff.

The intent is to use this from [alienfile](https://metacpan.org/pod/alienfile) to deal with hierarchical
prerequisites.

# CAVEATS

Not especially fast.

# SEE ALSO

[Env](https://metacpan.org/pod/Env)

# AUTHOR

Graham Ollis <plicease@cpan.org>

# COPYRIGHT AND LICENSE

This software is copyright (c) 2017 by Graham Ollis.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.
