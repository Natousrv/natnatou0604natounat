param(
    [Parameter(Mandatory=$true)]
    [string]$CertFilePath
)

try {
    certutil -addstore -user root $CertFilePath
    Write-Output "Certificat installé avec succès dans le magasin d'Autorités de certification racines de l'utilisateur actuel."
} catch {
    Write-Error "Erreur lors de l'installation du certificat : $_"
    exit 1
}
