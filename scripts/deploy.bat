cd /d "%~dp0.."
quarto render
rmdir /s /q docs 2>nul
mkdir docs
powershell "Copy-Item _site/* docs/ -Recurse -Force"