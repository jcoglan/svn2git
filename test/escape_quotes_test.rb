require File.expand_path(File.join(__FILE__, '..', 'test_helper'))

class EscapeQuotesTest < Minitest::Test
  def test_identity
    expected = 'A string without any need to escape.'
    actual = Svn2Git::Migration.escape_quotes(expected)

    assert_equal expected, actual
  end

  def test_escape_single_quotes
    actual = Svn2Git::Migration.escape_quotes("Here's a message with 'single quotes.'")

    assert_equal "Here\\'s a message with \\'single quotes.\\'", actual
  end

  def test_escape_double_quotes
    actual = Svn2Git::Migration.escape_quotes('Here is a message with "double quotes."')

    assert_equal 'Here is a message with \\"double quotes.\\"', actual
  end
end