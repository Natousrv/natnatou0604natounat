param(
    [Parameter(Mandatory=$true)]
    [string]$CertFilePath
)

try {
    $cert = New-Object System.Security.Cryptography.X509Certificates.X509Certificate2
    $cert.Import($CertFilePath)
    $store = New-Object System.Security.Cryptography.X509Certificates.X509Store("Root", "CurrentUser")
    $store.Open("ReadWrite")
    $store.Add($cert)
    $store.Close()
    Write-Output "Certificat installé avec succès dans le magasin d'Autorités de certification racines de l'utilisateur actuel."
} catch {
    Write-Error "Erreur lors de l'installation du certificat : $_"
    exit 1
}
