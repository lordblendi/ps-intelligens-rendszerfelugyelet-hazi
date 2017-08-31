<#
.SYNOPSIS
Creates a CSV based on the projects at the university. The output contains the project name,
the number of university members and company members.

.PARAMETER OutFile
Mandatory. Specifies the name of the CSV file's absolute or relative path for data.

.PARAMETER MinimalMembers
Optional. If it's given, 
then only projects with minimum MinimalMembers will appear in the CSV.

.NOTES
Author: Szepes Nora, 2014.03.29.
#>

#bejovo parameterek. Az OutFile kotelezo parameter, a MinimalMembers nem kotelezo parameter.
param(
 [Parameter(Mandatory=$true)]
 [string]$OutFile,

 [Parameter(Mandatory=$false)]
 [int]$MinimalMembers
)



import-module activedirectory;
#Fajl letezesenek a vizsgalata
if($(Test-Path($OutFile)) -eq $false) {
    New-Item -Path $OutFile -ItemType File | Out-Null;
}

Out-File -FilePath $OutFile -InputObject "Name,University members,Company members";

#projektek lekerese
$projectList = Get-ADGroup -Filter * -SearchBase "OU=Projects,DC=irfhf,DC=local" -Properties Members;
#Projektnev szerinti sorbarendezes
$projectList = $projectList | Sort-Object SamAccountName;


foreach($project in $projectList) {
    $university_worker = 0;
    $company_worker = 0;

    #egy projekt tagjainak lekerese
    $memberList = $project.Members;
    foreach($member in $memberList) {
    #egy tag adatainak lekeresel
        $stuffList = $member.Split(",");

        foreach($stuff in $stuffList){
            if($stuff -eq "OU=Faculties"){
                #ellenorizes, hogy egyetemi tag-e
                $university_worker = $university_worker +1;
            }
            if($stuff -eq "OU=Partners"){
                #ellenorizes, hogy partner-e
                $company_worker = $company_worker +1;
            }
        }
    }

        #megvizsgaljuk, hogy tobb-e a tagok szama a minimalMembers parameternel
        #ha nem adnak meg paramtetert, akkor a $MinimalMembers = 0
        if(($university_worker + $company_worker) -ge $MinimalMembers){
           Out-File -FilePath $OutFile -InputObject "$($project.SamAccountName),$($university_worker),$($company_worker)" -Append;
        }  
}
