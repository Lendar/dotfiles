encfs:
  pkg.installed:
    - name: encfs
    - taps: homebrew/fuse
    - require:
      - cask-osxfuse
