﻿# Load the required assembly for WPF
Add-Type -AssemblyName PresentationFramework
# Required modules
Add-Type -AssemblyName System.Windows.Forms

# List of search words
$searchWords = @(
    "robot", "plan", "objet", "theme", "chaud", "froid", "vente", "cours",
    "theorie", "tard", "tot", "mur", "image", "ecran", "pierre", "feu",
    "air", "poussiere", "fer", "metal", "herbe", "jungle", "desert", "vent",
    "hurlement", "machine", "esprit", "espace", "temps", "horloge", "livre",
    "page", "parole", "son", "musique", "rythme", "morceau", "note", "invention",
    "question", "reponse", "enigme", "probleme", "chiffre", "nombre", "equation", 
    "algorithme", "logique","raison", "pensee", "idee", "concept", "mot", "lettre", 
    "symbole", "signe","formule", "calcul", "mesure", "unite", "metre", "gramme", 
    "seconde", "kilometre","millimetre", "centimetre", "gramme", "kilogramme", 
    "milligramme", "centigramme", "monde","terre", "lune", "soleil", "etoile", 
    "galaxie", "univers", "cosmos", "astronomie","physique", "chimie", "biologie", 
    "genetique", "cellule", "organisme", "plante", "animal","humain", "homme", 
    "femme", "enfant", "adulte", "vivant", "mort", "naissance","sante", "maladie", 
    "medecin", "soin", "pharmacie", "hopital", "recherche", "decouverte","experience", 
    "observation", "hypothese", "theorie", "principe", "loi", "energie", "force","gravite", 
    "electrique", "magnetique", "thermique", "chaleur", "froid", "temperature", "pression",
    "vitesse", "acceleration", "inertie", "momentum", "cinetique", "statique", "dynamique", 
    "fluides","liquide", "gaz", "solide", "fusion", "solidification", "evaporation", 
    "condensation", "sublimation","transformation", "reaction", "produit", "reactif", 
    "catalyseur", "oxydation", "reduction", "equilibre","exothermique", "endothermique", 
    "mecanique", "cinematique", "statistique", "probabilite", "variation", "evolution",
    "adaptation", "mutation", "selection", "geologie", "paleontologie", "archeologie", 
    "histoire", "prehistoire","civilisation", "culture", "langage", "communication", 
    "informatique", "programme", "code", "developpement", "logiciel","materiel", 
    "peripherique", "reseau", "internet", "site", "page", "navigateur", "lien",
    "connexion", "donnee", "information", "base", "donnees", "stockage", "sauvegarde", 
    "cryptage","securite", "virus", "malware", "hacker", "cyber", "espace", "virtuel", 
    "reel","imagination", "creation", "art", "peinture", "sculpture", "cinema", "theatre", 
    "litterature","poesie", "roman", "fiction", "realite", "reve", "cauchemar", "emotion", 
    "sentiment","amour", "haine", "joie", "tristesse", "colere", "peur", "emerveillement", 
    "surprise","couleur", "noir", "blanc", "gris", "rouge", "vert", "bleu", "jaune",
    "orange", "violet", "rose", "argent", "or", "argent", "bronze", "cuivre",
    "fer", "aluminium", "plomb", "titane", "nickel", "chrome", "argent", "zinc",
    "cuivre", "etain", "plastique", "verre", "bois", "pierre", "argile", "sable",
    "eau", "mer", "ocean", "lac", "riviere", "cascade", "torrent", "nuage",
    "pluie", "neige", "vent", "ouragan", "tempete", "ciel", "nuageux", "clair",
    "etoile", "constellation", "galaxie", "exploration", "aventure", "decouverte", 
    "voyage", "expedition","route", "chemin", "sentier", "pont", "ville", "village", 
    "maison", "batiment","rue", "place", "parc", "foret", "jardin", "plante", "fleur", 
    "arbre","fruit", "legume", "animal", "insecte", "oiseau", "poisson", "mammifere", 
    "reptile","amphibien", "insecte", "creature", "fantastique", "mythique", "magique", 
    "sortilege", "sorcellerie","magie", "enchanteur", "sorcier", "fee", "elfe", "nain", 
    "hobbit", "homme","heros", "villain", "monstre", "dragon", "bete", "fantome", "esprit",
    "spectre", "cimetiere", "tombe", "mausolee", "mort", "vie", "ame", "esprit", "corps"
    
)

# Random search function
function Search-Bing {
    $rand = Get-Random -Maximum $searchWords.Length
    $query = $searchWords[$rand]
    Start-Process "https://www.bing.com/search?q=$query"
    Start-Sleep -Seconds 1
    for ($i = 0; $i -lt 34; $i++) {
        $randomWord = $searchWords[(Get-Random -Maximum $searchWords.Length)]
        $waitTime = 5/($randomWord.Length)
        Add-Type -AssemblyName System.Windows.Forms
        [System.Windows.Forms.SendKeys]::SendWait("^e")  # Ctrl+e
        Start-Sleep -Milliseconds 500
        foreach ($char in $randomWord.ToCharArray()) {
            [System.Windows.Forms.SendKeys]::SendWait($char)
            Start-Sleep -Milliseconds ($waitTime*1000)
        }
        [System.Windows.Forms.SendKeys]::SendWait("{ENTER}")
        Start-Sleep -Seconds 3
    }
    Stop-Process -Name "msedge" -Force  # Close Edge browser
}




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





Add-Type @"
using System;
using System.Runtime.InteropServices;
public class MouseMover {
    [DllImport("user32.dll", CharSet = CharSet.Auto, CallingConvention = CallingConvention.StdCall)]
    public static extern void mouse_event(long dwFlags, long dx, long dy, long cButtons, long dwExtraInfo);
    [DllImport("user32.dll", SetLastError = true)]
    public static extern bool SetCursorPos(int X, int Y);
}
"@

function Move-MouseSmoothly {
    param (
        [int]$targetX,
        [int]$targetY,
        [int]$steps = 100,  # Number of steps to reach the position
        [int]$speed = 10    # Milliseconds to wait between steps
    )

    # Get current cursor position
    $currentPosition = [System.Windows.Forms.Cursor]::Position
    $currentX = $currentPosition.X
    $currentY = $currentPosition.Y

    # Calculate incremental steps
    $deltaX = ($targetX - $currentX) / $steps
    $deltaY = ($targetY - $currentY) / $steps

    # Move the cursor smoothly in incremental steps
    for ($i = 1; $i -le $steps; $i++) {
        $newX = [int]($currentX + ($i * $deltaX))
        $newY = [int]($currentY + ($i * $deltaY))
        [MouseMover]::SetCursorPos($newX, $newY)
        Start-Sleep -Milliseconds $speed
    }

    # Ensure the final position is exact
    [MouseMover]::SetCursorPos($targetX, $targetY)
}









# Function to click thumbnails
function Click-Thumbnail {
    param (
        [float]$x_pos = 0,
        [float]$y_pos = 0
    )

    # Move mouse and click on thumbnail
    $position = [System.Windows.Forms.Cursor]::Position
    Move-MouseSmoothly -targetX $x_pos -targetY $y_pos -steps 50 -speed 5
    Start-Sleep -Milliseconds 1000
    [Mouse]::LeftClick()
    Start-Sleep -Seconds 4
    [System.Windows.Forms.SendKeys]::SendWait("^w")  # Ctrl+w to close tab
}


#get your screen size to know where the thumbnails are
$screenSize = [System.Windows.Forms.Screen]::PrimaryScreen.Bounds.Size

$width = $screenSize.Width
$height = $screenSize.Height


# Thumbnails navigation function
function Thumbnail-Task {
    Start-Process "https://rewards.microsoft.com/"
    Start-Sleep -Seconds 6
    Click-Thumbnail (45*$width/100) ($height)  # Left thumbnail
    Start-Sleep -Seconds 2
    Click-Thumbnail (75*$width/100) ($height)  # Middle thumbnail
    Start-Sleep -Seconds 2
    Click-Thumbnail (90*$width/100) ($height)  # Right thumbnail
    Start-Sleep -Seconds 2

    Stop-Process -Name "msedge" -Force
}

# Combine both tasks
function Run-All {
    Search-Bing
    Thumbnail-Task

}

























# Create a Window
$window = New-Object System.Windows.Window
$window.Title = "Microsoft Rewards Automation Bot"
$window.Width = 400  # Set a wider window width
$window.Height = 250  # Set an appropriate height
$window.WindowStartupLocation = "CenterScreen"
$window.Background = [System.Windows.Media.Brushes]::Black

# Create a StackPanel for vertical layout
$stackPanel = New-Object System.Windows.Controls.StackPanel
$stackPanel.HorizontalAlignment = "Center"  # Center the stack content horizontally
$window.Content = $stackPanel

# Create a function for Button 1
function FunctionOne {
    Search-Bing
}

# Create a function for Button 2
function FunctionTwo {
    Thumbnail-Task
}

# Create a function for Button 3
function FunctionThree {
    Run-All
}

# Create Button 1
$button1 = New-Object System.Windows.Controls.Button
$button1.Content = "Bing searches "
$button1.Width = 400  # Increase button width
$button1.Margin = "5,5,5,0"  # Reduce bottom margin
$button1.Background = [System.Windows.Media.Brushes]::Transparent
$button1.Foreground = [System.Windows.Media.Brushes]::Green
$button1.FontSize = 20
$button1.Add_Click({ FunctionOne })
$stackPanel.Children.Add($button1)

# Add Subtitle for Button 1
$subtitle1 = New-Object System.Windows.Controls.Label
$subtitle1.Content = "Execution time : 4 min"
$subtitle1.HorizontalAlignment = "Center"
$subtitle1.Margin = "5,0,5,10"  # Reduce top margin
$subtitle1.Foreground = [System.Windows.Media.Brushes]::Green
$stackPanel.Children.Add($subtitle1)

# Create Button 2
$button2 = New-Object System.Windows.Controls.Button
$button2.Content = "Main thumbnails only"
$button2.Width = 400  # Increase button width
$button2.Margin = "5,5,5,0"  # Reduce bottom margin
$button2.Background = [System.Windows.Media.Brushes]::Transparent
$button2.Foreground = [System.Windows.Media.Brushes]::Green
$button2.FontSize = 20
$button2.Add_Click({ FunctionTwo })
$stackPanel.Children.Add($button2)

# Add Subtitle for Button 2
$subtitle2 = New-Object System.Windows.Controls.Label
$subtitle2.Content = "Execution time : 1 min"
$subtitle2.HorizontalAlignment = "Center"
$subtitle2.Margin = "5,0,5,10"  # Reduce top margin
$subtitle2.Foreground = [System.Windows.Media.Brushes]::Green
$stackPanel.Children.Add($subtitle2)

# Create Button 3
$button3 = New-Object System.Windows.Controls.Button
$button3.Content = "Searches + thumbnails"
$button3.Width = 400  # Increase button width
$button3.Margin = "5,5,5,0"  # Reduce bottom margin
$button3.Background = [System.Windows.Media.Brushes]::Transparent
$button3.Foreground = [System.Windows.Media.Brushes]::Green
$button3.FontSize = 20
$button3.Add_Click({ FunctionThree })
$stackPanel.Children.Add($button3)

# Add Subtitle for Button 3
$subtitle3 = New-Object System.Windows.Controls.Label
$subtitle3.Content = "Execution time : 5 min"
$subtitle3.HorizontalAlignment = "Center"
$subtitle3.Margin = "5,0,5,10"  # Reduce top margin
$subtitle3.Foreground = [System.Windows.Media.Brushes]::Green
$stackPanel.Children.Add($subtitle3)

# Show the Window
$window.ShowDialog()
