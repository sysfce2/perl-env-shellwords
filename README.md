# Env::ShellWords ![linux](https://github.com/PerlAlien/Env-ShellWords/workflows/linux/badge.svg) ![macos](https://github.com/PerlAlien/Env-ShellWords/workflows/macos/badge.svg) ![windows](https://github.com/PerlAlien/Env-ShellWords/workflows/windows/badge.svg)

Environment variables for arguments as array

# SYNOPSIS

```perl
# Tie Interface
use Env::ShellWords;
tie my @CFLAGS,  'Env::ShellWords', 'CFLAGS';
tie my @LDFLAGS, 'Env::ShellWords', 'LDFLAGS';

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
```

# DESCRIPTION

This module provides an array like interface to environment variables
that contain flags.  For example Autoconf can uses the environment
variables like `CFLAGS` or `LDFLAGS`, and this allows you to manipulate
those variables without doing space quoting and other messy mucky stuff.

The intent is to use this from [alienfile](https://metacpan.org/pod/alienfile) to deal with hierarchical
prerequisites.

You can provide split and join callbacks when you tie:

```perl
use Env::ShellWords;
# split on any space, ignore quotes
tie my @FOO, 'Env::ShellWords',
  sub { split /\s+/, $_[0] },
  sub { join ' ', @_ };
```

Which may be useful if you have to split on words on an operating
system with a different specification.

# CAVEATS

Not especially fast.  `undef` gets mapped to the empty string `''`
since `undef` doesn't have a meaning as an argument in a string.

Writing to an environment variable using this interface is inherently
lossy.

# SEE ALSO

[Env](https://metacpan.org/pod/Env)

# AUTHOR

Graham Ollis <plicease@cpan.org>

# COPYRIGHT AND LICENSE

This software is copyright (c) 2017-2024 by Graham Ollis.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.
