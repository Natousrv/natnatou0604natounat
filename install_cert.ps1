function Test-AdminRights {
    $currentUser = New-Object Security.Principal.WindowsPrincipal ([Security.Principal.WindowsIdentity]::GetCurrent())
    return $currentUser.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
}

# Vérifier si l'utilisateur a des droits administratifs
if (Test-AdminRights) {
    # Installer le certificat en tant qu'administrateur
    try {
        Import-Certificate -FilePath $CertFilePath -CertStoreLocation Cert:\LocalMachine\Root -Confirm:$false -ErrorAction Stop
        Write-Output "Certificat installé avec succès dans le magasin d'Autorités de certification racines."
    } catch {
        Write-Error "Erreur lors de l'installation du certificat : $_"
        exit 1
    }
} else {
    Write-Error "Vous n'avez pas les droits administratifs nécessaires pour installer ce certificat."
    exit 1
}
