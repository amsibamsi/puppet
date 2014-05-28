class package::base {

  include package::git

  package::install {
    ['wget',
     'lynx',
     'dmidecode',
     'pkg_cutleaves',
     'portupgrade',
     'pkg_search',
     'bsdadminscripts',
     'rsync',
     'tmux',
     'vim-lite']:
  }

}
