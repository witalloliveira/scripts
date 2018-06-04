#####################################################################################################
#                                                                                                   #
#                       Cloud2Go · Soluções em Nuvem | NGX · Next Generation IT                     #
#         Witallo da Silva Oliveira · Cloud Infrastructure Analyst · Criado em 28/05/2018           #
#  Script para alterar o UPN de usuários através de arquivo CSV · Última modificação em 28/05/2018  #
#                                                                                                   #
#####################################################################################################

Import-Module ActiveDirectory

$UserCount = 0
# APENAS VISUALIZA OS USUÁRIOS QUE SERÃO ALTERADOS DURANTE O SCRIPT
# IMPORTANTE: SEM O PARÂMETRO -delimiter “;” SIGNIFICA O DELIMITADOR PADRÃO (VIRGULA)
Import-Csv -Path C:\Temp\prefix-upn-teste.csv -delimiter “;” | ForEach-Object {
$UPN = $_.OldUPN
Write-Host “Working on user:” $UPN
}

$UserCount = 0
# ALTERA O UPN DE TODOS OS USUÁRIOS ATRAVÉS DO ARQUIVO CSV
# CSV COM APENAS DUAS COLUNAS: PRIMEIRA COLUNA: "OldUPN" E SEGUNDA COLUNA: "NewUPN"
Import-Csv -Path C:\Temp\prefix-upn-teste.csv -delimiter “;” | ForEach-Object {
$UPN = $_.OldUPN
Write-Host “Working on user:” $UPN
Get-ADUser -Filter {UserPrincipalName -Eq $UPN} | Set-AdUser -userprincipalname $_.NewUPN
$usercount = $usercount +1
}
Write-Host “Number of users on your CSV: $UserCount”
Write-Host “UPN’s Changed”