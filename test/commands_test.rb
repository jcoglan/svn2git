require File.expand_path(File.join(__FILE__, '..', 'test_helper'))

class CommandsTest < Minitest::Test
  def test_checkout_svn_branch
    actual = Svn2Git::Migration.checkout_svn_branch('blah')

    assert_equal 'git checkout -b "blah" "remotes/svn/blah"', actual
  end
end