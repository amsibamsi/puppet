class package::base {

  package::install {
    [ "wget",
      "lynx",
      "dmidecode",
      "pkg_cutleaves",
      "portupgrade",
      "pkg_search",
      "bsdadminscripts",
      "rsync",
      "tmux",
      "vim-lite" ]:
  }

}
