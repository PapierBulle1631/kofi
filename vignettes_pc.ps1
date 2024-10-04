
#Required modules
Add-Type -AssemblyName System.Windows.Forms



#Function to call a left click
Add-Type -TypeDefinition @"
using System;
using System.Runtime.InteropServices;

public class Mouse {
    [DllImport("user32.dll", CharSet = CharSet.Auto, CallingConvention = CallingConvention.StdCall)]
    public static extern void mouse_event(long dwFlags, long dx, long dy, long cButtons, long dwExtraInfo);

    public const int MOUSEEVENTF_LEFTDOWN = 0x02;
    public const int MOUSEEVENTF_LEFTUP = 0x04;

    public static void LeftClick() {
        mouse_event(MOUSEEVENTF_LEFTDOWN | MOUSEEVENTF_LEFTUP, 0, 0, 0, 0);
    }
}
"@





# Function to click thumbnails
function Click-Thumbnail {
    param (
        [float]$x_pos = 0,
        [float]$y_pos = 0
    )

    # Move mouse and click on thumbnail
    $position = [System.Windows.Forms.Cursor]::Position
    [System.Windows.Forms.Cursor]::Position = [System.Drawing.Point]::new($x_pos, $y_pos)
    Start-Sleep -Milliseconds 1000
    [Mouse]::LeftClick()
    Start-Sleep -Seconds 4
    [System.Windows.Forms.SendKeys]::SendWait("^w")  # Ctrl+w to close tab
}


#get your screen size to know where the thumbnails are
Add-Type -AssemblyName System.Windows.Forms
$screenSize = [System.Windows.Forms.Screen]::PrimaryScreen.Bounds.Size

$width = $screenSize.Width
$height = $screenSize.Height


# Thumbnails navigation function
function Thumbnail-Task {
    Start-Process "https://rewards.microsoft.com/"
    Start-Sleep -Seconds 6
    Click-Thumbnail (45*$width/100) ($height)  # Left thumbnail
    Start-Sleep -Seconds 2
    Click-Thumbnail (70*$width/100) ($height)  # Middle thumbnail
    Start-Sleep -Seconds 2
    Click-Thumbnail (110*$width/100) ($height)  # Right thumbnail
    Start-Sleep -Seconds 2

    Stop-Process -Name "msedge" -Force
}

# Combine both tasks
function Run-All {
    Thumbnail-Task
}

# Run the combined task
Run-All
