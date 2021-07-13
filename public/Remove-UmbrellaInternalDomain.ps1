function Remove-UmbrellaInternalDomain {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false)][string]$domain,
        [Parameter(Mandatory = $false)][string]$domainId
    )
    
    begin {
        Get-UmbrellaKeys
        Write-Verbose -Message "Beginning to remove Internal Domain: $domain"
        $headers = @{
            "Authorization" = "Basic $mgmtKey"
        }

        if('' -eq $domainId){
            $DomainId = (Get-UmbrellaInternalDomains -Domain $domain).id
        }
    }
    
    process {
        $url = "https://management.api.umbrella.com/v1/organizations/$orgId/internaldomains/$domainId"
        try{
            $res = Invoke-RestMethod -Uri $url -Headers $headers -Method DELETE
        }catch{
            return $_
        }
    }
    
    end {
        return $res
    }
}