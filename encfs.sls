encfs:
  pkg.installed:
    - name: encfs
    - taps: homebrew/fuse
    - require:
      - cmd: cask-osxfuse
