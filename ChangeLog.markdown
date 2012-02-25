# 2.2.1

  This is a critical bugfix release if your repository has tags.  Thanks to David Zülke (dzuelke) for the patches making up this release.

  * Added the ability to specify an end revision for migration (thanks dzuelke).
  * Fixed an issue with initial conversion if the repo had tags (thanks dzuelke).

# 2.2.0 - 2012-01-25

  Thanks to Craig Hobbs (craigahobbs) and Simon Chiang (thinkerbot) for the patches making up this release.
  It rounds out our tag support by handling tags with special characters and preserving original tag author info.

  * Fixed an issue with not quoting tag names (thanks craigahobbs and thinkerbot)
  * Fixed an issue whereby the person running the svn2git conversion became the author of every tag (i.e., we lost the
  original tag committer info) (thanks thinkerbot)

# 2.1.2 - 2011-12-28

  * Fixed a regression in improperly quoting branch names (thanks ziangsong).

# 2.1.1 - 2011-12-27

  * Fixed SVN branch detection (thanks thinkerbot).
  * Stop processing when a git subprocess fails (thanks thinkerbot).
  * Fixed an issue with SVN branches containing shell special characters (thanks sleicht).

# 2.1.0 - 2011-04-03

  Thanks to Francois Rey (fmjrey), Sven Axelsson (svenax), and Julian Taylor (juliantaylor) for submitting all the patches
  that comprise this release.  svn2git now works with a much wider array SVN repositories because of their efforts.
  
  * Added --no-minimize-url option for migrating specific subprojects from an SVN repo containing several projects (thanks fmjrey).
  * Added --username option for migrating password-protected repositories (thanks svenax).
  * Added --revision option for specifying the revision to start importing from (thanks svenax).
  * Fixed compatibility with older versions of git (thanks juliantaylor).

# 2.0.0 - 2010-05-29

  This release adds the oft requested incremental SVN update support.  If you run svn2git with the `--rebase` option on an existing
  repository that you've converted with svn2git, it will fetch new branches & tags from SVN and update existing ones.  There are
  two important things to note:

  * This will not work on already converted repositories because the tracking information isn't set up correctly.  You could do that
  yourself, but it's probably a lot easier to do the conversion over.
  * svn2git now maintains remote tracking information.  If this is a problem for you because you don't want any links to the SVN server
  you can either stick with a 1.x release of svn2git or simply clone the repo created with svn2git, which will lose the tracking information.

  A great deal of thanks to Nathaniel McCallum (npmccallum) for coming up with an elegant solution and then providing the patch for this release.

# 1.3.3 - 2010-03-31

  Thanks to Jeff Ramnani (jramnani) for finding a problem with with the --excludes tag and providing a patch.

  * Fix error when using '--exclude' option.

# 1.3.2 - 2010-03-12

  Thanks to Rajit Singh (rajit) for finding a problem with quoting in tag comments that were causing issues with svn2git's internal
  quoting and providing a patch.

  * Deal cleanly with any single quotes found in tag comments so that the 'git tag' commands run correctly.

# 1.3.1 - 2009-06-09

  Thanks to KUBO Atsuhiro (iteman) for finding a problem with the tagging process and providing a patch.
  
  * Fixed a problem with creating actual git tags when the SVN tags path was named anything other than 'tags.'

# 1.3.0 - 2009-06-09

  Many thanks to Malte S. Stretz (mss) for the patches making up most of this release.

  * Fixed a problem where tags didn't get the original date and time.
  * New switch --exclude which can be used to specify a PCRE pattern to exclude paths from the import.
  * New switches --no{trunk,branches,tags} to skip import of those.
  * Improved docs.

# 1.2.4 - 2009-05-04

  * No changes.  I ran the jeweler command twice inadvertently.  Tearing down the release would be more harmful than helpful.

# 1.2.3 - 2009-05-04

  * Yanked out the code referencing the gem by name.  This shouldn't be necessary at all.

# 1.2.2 - 2009-05-04

  * Updated the reference gem in the binary to use this one and not the one on RubyForge.

# 1.2.1 - 2009-04-19

  * Fixed a problem with the svn2git binary not loading command-line args properly.

# 1.2.0 - 2009-04-17

  * Reworked command-line options so they work similarly to every other app in the world.
  * Better error messaging when no URL provided.
  * Improved docs.

# 1.1.1 - 2009-04-15
  
  * Started using Jeweler for gem management.
  * Fixed issue with not loading up RubyGems appropriately.

# 1.1.0 - 2009-01-02

  * First release since nirvdrum fork.
  
  * Fixed issues with handling of tags and branches.
  * Added better logging of output from git-svn.
  * Wrap external command processing to capture failures.

# 1.0.0 - 2008-07-19

  * Forked version from jcoglan.
