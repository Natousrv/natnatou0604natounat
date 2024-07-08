param(
    [Parameter(Mandatory=$true)]
    [string]$CertFilePath
)

try {
    Import-Certificate -FilePath $CertFilePath -CertStoreLocation Cert:\CurrentUser\Root -Confirm:$false -ErrorAction Stop
    Write-Output "Certificat installé avec succès dans le magasin d'Autorités de certification racines de l'utilisateur actuel."
} catch {
    Write-Error "Erreur lors de l'installation du certificat : $_"
    exit 1
}
