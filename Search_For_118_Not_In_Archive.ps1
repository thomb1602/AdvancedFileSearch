[int]$choice = Read-Host -Prompt '1. Search for files by document index (with op-level folder exclude)'

if ($choice -eq 1)
{
    [string]$searchPattern = Read-Host -Prompt 'Enter the index number of the document (the file name should begin with the index number)'
    [string]$exclude = Read-Host 'Enter a keyword by which to exclude a top-level folder from the search. (Default is "Archive")'

    #not using params yet..
    Get-FilesByDocumentIndex
}

function Get-FilesByDocumentIndex
{
    [CmdletBinding()]
    param(
        # String to filter file names by
        
        [Parameter(Position = 0, Mandatory = $true)]
        [ValidatePattern('\d{3}')]
        [vaid]
        [string]
        $Search,

        # String to exclude top level folder by name (Default = "Archive")
        [Parameter(
            Position = 1,
            Mandatory = $false
        )]
        [string]
        $exclude = 'Archive'
    )

    $topLevelExcluded = Get-ChildItem -Path "C:\Users\TomBates\EUROABS LIMITED\SRApp - Documents" -Exclude *$exclude* -Directory
    $filtered = $topLevelExcluded | Get-ChildItem -Filter $searchPattern* -File -Recurse 

    $sorted = $filtered | Select-Object Name, Directory, LastWriteTime | Sort-Object Directory

    $sorted 
}


