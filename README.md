# pgpfinger - a tool to retrieve PGP keys

## SYNOPSIS

    pgpfinger [-?q] [long options...] <uid> <more uids ...>
      -? --usage --help  Prints this usage information.
      -q --query         sources to query (default: dns,keyserver)

## OPTIONS

    -q --query <methods>
      Select sources to query for PGP keys. Values must be comma
      seperated.

      Currently supported: dns,keyserver

## EXAMPLE
      $ pgpfinger --query DNS ich@markusbenning.de
      # source: DNS
      # domain: markusbenning.de
      # Version: gpgfinger (head)
      # dnssec: ok
      -----BEGIN PGP PUBLIC KEY BLOCK-----
      mQENBFKVnLsBCADZVXXPLaVRUVaaGBxtmBNWAlHSiJPhdC8SPgSB/idpX5XBUKD31IBO6oisixb3
      tLaQsSsz/tP+8x+ynzS3Gi9NyHXassy+8k5eqxiyzn9aXqAOIT2yIaDyVQb9F37z2jBRFGMwugU8
      AtQBiDyQuc5+MIxbJqG23+iTO7JVaENIZZFFHlt9chFg9V8Psfojmw046eIG/CK/JbphyfceXeRn
      qXszG7ZjGQa1IWlFuzQ0rBmqIx2x/sI2wCv85nUIbbubvz4lRfiafgzV0vtfk6NOI2pay3pr9tvT
      fz8jtroBe9zFcsdxMSSD18sXwlXlQHKB0YoNlkuiI3oSNse5Hqo5ABEBAAG0JU1hcmt1cyBCZW5u
      aW5nIDxpY2hAbWFya3VzYmVubmluZy5kZT6JATgEEwECACIFAlKVnLsCGwMGCwkIBwMCBhUIAgkK
      CwQWAgMBAh4BAheAAAoJEAJYWDndCqpiC3wH/iplFRYMqTfIifWTpYWk/ovVKY2eYttZ8sjFjn2w
      hCvvwB8Uy3N2eh/1P2TK3eYCNSbfg2pfokGPjvZyubv9/UNdsT7lK1PlqMw89yRPfHkZevTnISSH
      FxSavurVOEeK68buGGC/TzRfLJKhNZXFixl57Zn7Iv7oOmXJCM79k3Hz3Vmd+xt/3ViEBTLDVfWr
      JzSB561jb4/b4mb1x40gM4+YJElY9XFn0hKtVDHvjFhyFsNCs1L+Q7vXzdghyZS0Uf+ws7QDg64K
      KJfQmLGKMtVdDtQJ3Jx1f4Z1t9vvDiltkkHgw3NlEryqyWM03bEVn6zOSfHqlDnh4wtYGZzBsWG5
      AQ0EUpWcuwEIAME7cwib9mAIbU4DfRf6nXIfDEL1CrjOLaLz2VSPKrD22y0UWIxOl4qeGKhFQ8LL
      RzreUsPQ+t0h1QkR1CmxtpYNgGsNZaxOEzpkvAGTl9qvRrb7i9fBBQz6orxtPnBfAOvwsZZss6Ot
      k7DnhkxRK6etynithXmQs5bzfmEt+kpnv7sPITxUxajL0FxKgO88fJxhzyz9p/3pxcbqBIOiZVHa
      IRFQEtO0gPp/uzCVribMmDs5IhzMP7xzVFSJAZs+/P++cti1PeY2eiHyKOPfINwHAuIJl7LBVc42
      mKEbyE5oj1FQdklR5nwdbCNi+amlh9pRboFS71KEMoDQWWiA0PUAEQEAAYkBHwQYAQIACQUCUpWc
      uwIbDAAKCRACWFg53QqqYjGAB/43IVL2tWl5lhY9n9Cua3u8/YC3bSL8D+VDG7WgnGv9tLRGrO/x
      phdgK4JhWPcYtPLXpdkYxtSrlt/Wty20pitAoaoz+OdeIBz+Rw+9pWp5p4JiyOfe+8p8ZZdj3CAN
      DsmxJ1pk4R2Re1+ZHsLhSCBTPsOYbJal89RmREDWf0bwnT4DG6shXn2gWhXQAPEADiNoA6M0ptNU
      Z31tSW8JhRLw/Itjq3n27uTdJ5ERcSuhrHe8lpkA95iRICJ/3Pix0fZ/q7cZEkYbKfzmh98b7KWV
      s+viGXLqvWEBiBsksAfWnA4irE8RQqEhgKmIxHzQ7p3j8Eui2+FDaFZosVqDyJjX
      -----END PGP PUBLIC KEY BLOCK-----

## AUTHOR

Markus Benning <ich@markusbenning.de>

## COPYRIGHT AND LICENSE
    This software is Copyright (c) 2015 by Markus Benning.

    This is free software, licensed under:

      The GNU General Public License, Version 2 or later
