require "formula"

# Documentation: https://github.com/Homebrew/homebrew/wiki/Formula-Cookbook
#                /usr/local/Library/Contributions/example-formula.rb
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!

class Sermon < Formula
  homepage "http://github.com/dbridges/sermon"
  url "https://github.com/dbridges/sermon/archive/v0.0.6.tar.gz"
  sha1 "100b15ce3c9bd4d363b58935602c105f137b6312"

  depends_on :python

  resource "pyserial" do
    url "https://pypi.python.org/packages/source/p/pyserial/pyserial-2.7.tar.gz"
    md5 "794506184df83ef2290de0d18803dd11"
  end

  resource "urwid" do
    url "https://pypi.python.org/packages/source/u/urwid/urwid-1.2.1.tar.gz"
    md5 "6a05ada11b87e7b026b01fc5150855b0"
  end

  def install
    ENV.prepend_create_path 'PYTHONPATH', libexec+'lib/python2.7/site-packages'
    ENV.prepend_create_path 'PYTHONPATH', prefix+'lib/python2.7/site-packages'
    install_args = [ "setup.py", "install", "--prefix=#{libexec}" ]

    resource('pyserial').stage { system "python", *install_args }
    resource('urwid').stage { system "python", *install_args }
    system "python", "setup.py", "install", "--prefix=#{prefix}", "--record=installed.txt", "--single-version-externally-managed"
    bin.env_script_all_files(libexec+'bin', :PYTHONPATH => ENV['PYTHONPATH'])
  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! It's enough to just replace
    # "false" with the main program this formula installs, but it'd be nice if you
    # were more thorough. Run the test with `brew test sermon`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system "#{bin}/program", "do", "something"`.
    system "false"
  end
end
