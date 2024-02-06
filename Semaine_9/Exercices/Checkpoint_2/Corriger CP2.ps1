function Log
{
    param([string]$FilePath,[string]$Content)

    # Vérifie si le fichier existe, sinon le crée
    If (-not (Test-Path -Path $FilePath))
    {
        New-Item -ItemType File -Path $FilePath | Out-Null
    }

    # Construit la ligne de journal
    $Date = Get-Date -Format "dd/MM/yyyy-HH:mm:ss"
    $User = [System.Security.Principal.WindowsIdentity]::GetCurrent().Name
    $logLine = "$Date;$User;$Content"

    # Ajoute la ligne de journal au fichier
    Add-Content -Path $FilePath -Value $logLine
}
# Q.2.11 On modifie la valeur de la longueur du mot de passe à 10Function Random-Password ($length = 10){    $punc = 46..46
    $digits = 48..57
    $letters = 65..90 + 97..122
    $password = get-random -count $length -input ($punc + $digits + $letters) |`
        ForEach -begin { $aa = $null } -process {$aa += [char]$_} -end {$aa}
    Return $password.ToString()
}

Function ManageAccentsAndCapitalLetters{    param ([String]$String)    
    $StringWithoutAccent = $String -replace '[éèêë]', 'e' -replace '[àâä]', 'a' -replace '[îï]', 'i' -replace '[ôö]', 'o' -replace '[ùûü]', 'u'    $StringWithoutAccentAndCapitalLetters = $StringWithoutAccent.ToLower()    $StringWithoutAccentAndCapitalLetters
}

$Path = "C:\Scripts"$CsvFile = "$Path\Users.csv"$LogFile = "$Path\Log.log"
# Q.2.6 Utilisation de la fonction Log
Log -FilePath $LogFile -Content "---------------- Debut du script ----------------"

# Q.2.2 modification du "skip"
# Q.2.4 Suppression des champs non-utilisé à l'importation : "societe","service","mail","mobile","scriptpath","telephoneNumber"
#$Users = Import-Csv -Path $CsvFile -Delimiter ";" -Header "prenom","nom","societe","fonction","service","description","mail","mobile","scriptPath","telephoneNumber" -Encoding UTF8  | Select-Object -Skip 1$Users = Import-Csv -Path $CsvFile -Delimiter ";" -Header "prenom","nom","fonction","description" -Encoding UTF8  | Select-Object -Skip 1
foreach ($User in $Users)
{
    $Prenom = ManageAccentsAndCapitalLetters -String $User.prenom    $Nom = ManageAccentsAndCapitalLetters -String $User.Nom
    $Name = "$Prenom.$Nom"
    If (-not(Get-LocalUser -Name $Name -ErrorAction SilentlyContinue))    {        $Pass = Random-Password        $Password = (ConvertTo-secureString $Pass -AsPlainText -Force)
        $Description = "$($user.description) - $($User.fonction)"
        $Description
        $UserInfo = @{
            Name                 = $Name
            FullName             = $Name
            Password             = $Password
            # Q.2.3 Ajout du champs description pour la création
            Description          = $Description
            AccountNeverExpires  = $true
            # Q.2.10 Modification de la valeur de PasswordNeverExpires de $false à $true
            PasswordNeverExpires = $true
        }
        New-LocalUser @UserInfo
        # Q.2.6 Utilisation de la fonction Log
        Log -FilePath $LogFile -Content "$Name -> CREATION ok"
        # Q.2.8 Modification du nom de groupe "Utilisateur" en "Utilisateurs"
        Add-LocalGroupMember -Group "Utilisateurs" -Member $Name
        # Q.2.6 Utilisation de la fonction Log
        Log -FilePath $LogFile -Content "$Name -> AJOUT DANS le GROUPE local UTILISATEURS"
        # Q.2.5 ajout de l'affichage du mot de passe
        Write-Host "L'utilisateur $Name a été crée avec le mot de passe $Pass"
        # Q.2.6 Utilisation de la fonction Log
        Log -FilePath $LogFile -Content "$Name -> PASSWORD = $Pass"
    }
    # Q.2.7 On ajoute un "Else" pour faire un embranchement avec le "If"
    # On passe dans le "Else" si l'utilisateur $Name (ou "$Prenom.$Nom") existe déjà
    Else
    {
        Write-Host "L'utilisateur $Name existe déjà ==> Pas de création de compte"
        Log -FilePath $LogFile -Content "$Name -> ERROR - Utilisateur déjà existant"
    }
}
# Q.2.6 Utilisation de la fonction Log
Log -FilePath $LogFile -Content "------------------ Fin du script ----------------"