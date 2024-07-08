param (
    [Parameter(Mandatory=$true)]
    [string]$CertFilePath
)

# Fonction pour vérifier les droits administratifs
function Test-AdminRights {
    $currentUser = New-Object Security.Principal.WindowsPrincipal ([Security.Principal.WindowsIdentity]::GetCurrent())
    return $currentUser.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
}

# Fonction pour installer le certificat en utilisant certutil
function Install-Certificate {
    param ($CertFilePath)
    try {
        # Chemin temporaire pour copier le certificat
        $tempCertPath = Join-Path $env:TEMP "tempcert.cer"

        # Copier le certificat vers le chemin temporaire
        Copy-Item -Path $CertFilePath -Destination $tempCertPath -Force

        # Installer le certificat en utilisant certutil
        $certutilArgs = "/addstore ""Root"" ""$tempCertPath"""
        Start-Process -FilePath certutil.exe -ArgumentList $certutilArgs -NoNewWindow -Wait

        # Supprimer le certificat temporaire après l'installation
        Remove-Item -Path $tempCertPath -Force

        Write-Output "Certificat installé avec succès dans le magasin d'Autorités de certification racines."
    } catch {
        Write-Error "Erreur lors de l'installation du certificat : $_"
        exit 1
    }
}

# Vérifier si l'utilisateur a des droits administratifs
if (Test-AdminRights) {
    # Installer le certificat en tant qu'administrateur
    Install-Certificate -CertFilePath $CertFilePath
} else {
    Write-Error "Installation du certificat en cours sans privilèges administratifs..."

    # Si pas d'accès administratif, essayer d'installer le certificat en utilisant certutil
    Install-Certificate -CertFilePath $CertFilePath
}
