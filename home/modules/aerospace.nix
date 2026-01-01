{ ... }:

{
  home.file.".config/aerospace/aerospace.toml".text = ''
    start-at-login = true

    [mode.main.binding]
    cmd-ctrl-t = 'exec-and-forget open -a /Applications/Alacritty.app'
    cmd-ctrl-b = 'exec-and-forget open -a /Applications/Zen.app'

    alt-h = 'focus left'
    alt-j = 'focus down'
    alt-k = 'focus up'
    alt-l = 'focus right'

    alt-shift-h = 'move left'
    alt-shift-j = 'move down'
    alt-shift-k = 'move up'
    alt-shift-l = 'move right'

    alt-1 = 'workspace 1'
    alt-2 = 'workspace 2'
    alt-3 = 'workspace 3'
    alt-4 = 'workspace 4'
    alt-5 = 'workspace 5'

    [[on-window-detected]]
    if.app-id = 'io.zen-browser.zen'
    run = 'move-node-to-workspace 1'

    [[on-window-detected]]
    if.app-id = 'org.alacritty'
    run = 'move-node-to-workspace 1'

    [[on-window-detected]]
    if.app-id = 'com.apple.mail'
    run = 'layout floating'

    [[on-window-detected]]
    if.app-id = 'com.apple.systempreference'
    run = 'layout floating'
  '';
}
