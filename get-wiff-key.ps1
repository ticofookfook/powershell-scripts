$profiles = netsh wlan show profiles | ForEach-Object {
    $splitResult = $_ -split ":", 2
    if ($splitResult.Count -gt 1) {
        $splitResult[1].Trim()
    }
}

foreach ($profile in $profiles) {
    $profileInfo = netsh wlan show profile name="$profile" key=clear
    $matches = $profileInfo | Select-String -Pattern "Nome SSID\s+:\s+(.+)$|Conteúdo da Chave\s+:\s+(.+)$"
    if ($matches.Count -eq 2) {
        $nomeRede = $matches[0].Matches.Groups[1].Value
        $conteudoChave = $matches[1].Matches.Groups[2].Value
        Write-Host "Nome da Rede: $nomeRede"
        Write-Host "Senha: $conteudoChave"
    } else {
        Write-Host "Informações não encontradas para o perfil $profile."
    }
}




####codigo em 1 linha#######
netsh wlan show profiles | ForEach-Object { $splitResult = ($_ -split ":", 2); if ($splitResult.Count -gt 1) { $profile = $splitResult[1].Trim(); if ($profile) { $matches = (netsh wlan show profile name="$profile" key=clear) | Select-String -Pattern "Nome SSID\s+:\s+(.+)$|Conteúdo da Chave\s+:\s+(.+)$"; if ($matches.Count -eq 2) { $nomeRede, $conteudoChave = $matches[0].Matches.Groups[1].Value, $matches[1].Matches.Groups[2].Value; Write-Host "Nome da Rede: $nomeRede"; Write-Host "Senha: $conteudoChave"; } else { Write-Host "Informações não encontradas para o perfil $profile." } } } }
