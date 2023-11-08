$profiles = netsh wlan show profiles | Select-String "Todos os Perfis de Usuários:"

foreach ($profile in $profiles) {
  $profileName = $profile -replace "Todos os Perfis de Usuários: ", ""
  $profileInfo = netsh wlan show profile name="$profileName" key=clear
  $matches = $profileInfo | Select-String -Pattern "Nome SSID\s+:\s+(.+)$|Conteúdo da Chave\s+:\s+(.+)$"
  if ($matches.Count -eq 2) {
    $nomeRede = $matches[0].Matches.Groups[1].Value
    $conteudoChave = $matches[1].Matches.Groups[2].Value
    Write-Host "Nome da Rede: $nomeRede"
    Write-Host "Senha: $conteudoChave"
  } else {
    Write-Host "Informações não encontradas para o perfil $profileName."
  }
}
