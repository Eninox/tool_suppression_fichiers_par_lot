# Script de suppression de fichiers par itération (lot) et temps d'attente

# identification du dossier cible de la suppression
$dossierCible = "\\machine\c$\dossier\cible"

# selection des dossiers ou fichiers presents dans le dossier cible
$items = Get-ChildItem -path $dossierCible -Directory | Select-Object FullName

# definition du nombre de fichiers dans chaque lot
$nbItemsParLot = 10

# definition temps d'attente entre chaque iteration de Remove-Item (en secondes ici, modifiable dans le Start-Sleep)
$tempsAttenteEntreLots = 5

$i = 0

foreach ($item in $items) {

    Remove-Item -Path $item.FullName -Force -Recurse

    $i++
    
    if ($i -eq $nbItemsParLot) {

        $itemsRestants = Get-ChildItem -path $dossierCible -Directory
        Write-Host "Suppression de $i items, reste" $itemsRestants.count

        Write-Host "Attente de $tempsAttenteEntreLots secondes"
        Start-Sleep -Seconds $tempsAttenteEntreLots

        $i = 0
    }
}

Write-Host "Fin"