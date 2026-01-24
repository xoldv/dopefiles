on open theFiles
    set nvimPath to "/opt/homebrew/bin/nvim"
    set alacrittyPath to "/Applications/Alacritty.app/Contents/MacOS/alacritty"

    repeat with f in theFiles
        set p to POSIX path of f

        do shell script alacrittyPath & " -e " & nvimPath & " " & quoted form of p & " > /dev/null 2>&1 &"
    end repeat
end open
# duti -s com.apple.ScriptEditor.id.alacrittyOpenWithNvim .log all
