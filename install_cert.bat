@echo off

rem Vérifie s'il y a un argument pour le chemin du certificat
if "%~1"=="" (
    echo Erreur : Le chemin du certificat est manquant.
    exit /b 1
)

set CertFilePath=%~1

rem Installation du certificat dans le magasin de confiance Root
echo Installation du certificat dans le magasin de certificats de confiance...
certutil -addstore Root "%CertFilePath%"

rem Vérification du code de sortie de certutil
if %errorlevel% neq 0 (
    echo Erreur lors de l'installation du certificat.
    exit /b 1
) else (
    echo Certificat installé avec succès dans le magasin d'Autorités de certification racines.
    exit /b 0
)
