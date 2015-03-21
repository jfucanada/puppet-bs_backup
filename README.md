# Backup Your config file

# About
This module will help you backup config files which managed by inifile or augeas and so on.

# Usage
For example, In config.pp:

    class <module_name>::config {
      file_line { 'add-limits':
        path => '/etc/pam.d/login',
        line => 'session    required     pam_limits.so',
        after => '-session   optional     pam_ck_connector.so',
        multiple => false,
      }
    }

Then, In you backup.pp 

    class <module_name>::backup {
      bs_backup { '/etc/pam.d/login':
        config_class => '<module_name>::config',
      }
    }

In your init.pp

    class <module_name> {
      contain <module_name>::install
      contain <module_name>::config
      contain <module_name>::service
      include <module_name>::backup
    }

Now, File['/etc/pam.d/login'] will backup automaticly.
