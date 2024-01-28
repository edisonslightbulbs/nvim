# Check if Chocolatey is installed
if (!(Test-Path "C:\ProgramData\chocolatey\bin\choco.exe")) {
    Write-Host "Chocolatey is not installed. Installing Chocolatey first."
    Set-ExecutionPolicy Bypass -Scope Process -Force;
    [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072;
    iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'));
}

# Install Node.js (includes npm)
choco install nodejs -y

# Install Yarn
choco install yarn -y

# Install pnpm
choco install pnpm -y

# Install Ruby
choco install ruby -y

# Install GraphicsMagick
choco install graphicsmagick -y

# Install Ripgrep (rg)
choco install ripgrep -y

# Install fd (fd-find)
choco install fd -y

# Install MinGW (includes GCC)
choco install mingw -y

choco install llvm
pip install cmake-format
choco install texlive
choco install stylua
choco install golang



Write-Host "All packages installed successfully."
