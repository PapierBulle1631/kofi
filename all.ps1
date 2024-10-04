# Required modules
Add-Type -AssemblyName System.Windows.Forms
Start-Sleep -Seconds 4

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
$screenSize = [System.Windows.Forms.Screen]::PrimaryScreen.Bounds.Size

$width = $screenSize.Width
$height = $screenSize.Height


# Thumbnails navigation function
function Thumbnail-Task {
    Start-Process "https://rewards.microsoft.com/"
    Start-Sleep -Seconds 6
    Click-Thumbnail (40*$width/100) ($height-100)  # Left thumbnail
    Start-Sleep -Seconds 2
    Click-Thumbnail (65*$width/100) ($height-100)  # Middle thumbnail
    Start-Sleep -Seconds 2
    Click-Thumbnail (85*$width/100) ($height-100)  # Right thumbnail
    Start-Sleep -Seconds 2

    Stop-Process -Name "msedge" -Force
}

# Combine both tasks
function Run-All {
    Search-Bing
    Thumbnail-Task

}

# Run the combined task
Run-All
