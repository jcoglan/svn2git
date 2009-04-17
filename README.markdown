svn2git
=======

_svn2git_ is a tiny utility for migrating projects from Subversion to Git
while keeping the trunk, branches and tags where they should be. It uses
git-svn to clone an svn repository and does some clean-up to make sure
branches and tags are imported in a meaningful way, and that the code checked
into master ends up being what's currently in your svn trunk rather than
whichever svn branch your last commit was in.

Examples
--------

Say I have this code in svn:

  trunk
    ...
  branches
    1.x
    2.x
  tags
    1.0.0
    1.0.1
    1.0.2
    1.1.0
    2.0.0

git-svn will go through the commit history to build a new git repo. It will
import all branches and tags as remote svn branches, whereas what you really
want is git-native local branches and git tag objects. So after importing this
project I'll get:

  $ git branch
  * master
  $ git branch -a
  * master
    1.x
    2.x
    tags/1.0.0
    tags/1.0.1
    tags/1.0.2
    tags/1.1.0
    tags/2.0.0
    trunk
  $ git tag -l
  [ empty ]

After svn2git is done with your project, you'll get this instead:

  $ git branch
  * master
    1.x
    2.x
  $ git tag -l
    1.0.0
    1.0.1
    1.0.2
    1.1.0
    2.0.0

Finally, it makes sure the HEAD of master is the same as the current trunk of
the svn repo.

Installation
------------

Make sure you have git installed, then install the gem:

    $ sudo apt-get install git-core git-svn
    $ sudo gem install nirvdrum-svn2git

Usage
-----

There are a number of ways in which you can create a git repo from an existing
svn repo. The differentiating factor is the svn repo layout. Below is an
enumerated listing of the varying supported layouts and the proper way to
create a git repo from a svn repo in the specified layout.

1. The svn repo is in the standard layout of (trunk, branches, tags) at the
root level of the repo.

    $ svn2git http://svn.yoursite.com/path/to/repo --trunk trunk --branches branches --tags tags

2. The svn repo is NOT in standard layout and has only a trunk and tags at the
root level of the repo.

    $ svn2git http://svn.yoursite.com/path/to/repo --trunk trunk --tags tags

3. The svn repo is NOT in standard layout and has only a trunk and branches at
the root level of the repo.

    $ svn2git http://svn.yoursite.com/path/to/repo --trunk trunk --branches branches

4. The svn repo is NOT in standard layout and has only a trunk at the root
level of the repo.

    $ svn2git http://svn.yoursite.com/path/to/repo --trunk trunk

5. The svn repo is NOT in standard layout and has no trunk, branches, or tags
at the root level of the repo. Instead the root level of the repo is
equivalent to the trunk and there are no tags or branches.

    $ svn2git http://svn.yoursite.com/path/to/repo --rootistrunk

The above will create a git repository in the current directory with the git
version of the svn repository. Hence, you need to make a directory that you
want your new git repo to exist in, change into it and then run one of the
above commands. Note that in the above cases the trunk, branches, tags options
are simply folder names relative to the provided repo path. For example if you
specified trunk=foo branches=bar and tags=foobar it would be referencing
http://svn.yoursite.com/path/to/repo/foo as your trunk, and so on. However, in
case 5 it references the root of the repo as trunk.

Authors
-------

To convert all your svn authors to git format, create a file somewhere on your
system with the list of conversions to make, one per line, for example:

  jcoglan = James Coglan <jcoglan@never-you-mind.com>
  stnick = Santa Claus <nicholas@lapland.com>

Then pass an +authors+ option to +svn2git+ pointing to your file:

  svn2git http://repos.com/myproject --authors ~/authors.txt

Alternatively, you can place the authors file into ~/.svn2git/authors and
svn2git will load it out of there. This allows you to build up one authors
file for all your projects and have it loaded for each repository that you
migrate.

Debugging
---------

If you're having problems with converting your repository and you're not sure why,
try turning on verbose logging.  This will print out more information from the
underlying git-svn process.

You can turn on verbose logging with the '-v' or '--verbose' flags, like so:

  $ svn2git http://svn.yoursite.com/path/to/repo --verbose