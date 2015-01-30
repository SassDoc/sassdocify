SassDocify
==========

> Make a SassDoc branch.

Description
-----------

See [SassDocify page on SassDoc website](http://sassdoc.com/sassdocify/).

Development
-----------

Compile the ronn man page:

```sh
bundle install # Need to do this at least once
make man
```

Propagate version to `bin/sassdocify` and `package.json` after bumping
in `Makefile`:

```sh
make version
```

Set `sassdocify`'s `bin` directory directly in your `PATH`:

```sh
export PATH="$PWD/bin:$PATH"
```

Or more persistent version (need logout):

```sh
echo "export PATH='$PWD/bin:\$PATH'" >> ~/.profile
```
