function Get-UmbrellaInternalDomains {
    [CmdletBinding()]
    param (
        [string]$domain,
        [bool]$All = $true
    )
    
    begin {
        Get-UmbrellaKeys

        $headers = @{
            "Authorization" = "Basic $mgmtKey"
        }
    }
    
    process {
        if($All -ne $true){
            $url = "https://management.api.umbrella.com/v1/organizations/$orgId/internaldomains"
            $res = Invoke-RestMethod -Uri $url -Headers $headers
            if('' -ne $domain){
                $res = $res.Where({ $_.domain -eq $domain})
            }
        }
        if($All -eq $true){
            $url = "https://management.api.umbrella.com/v1/organizations/$orgId/internaldomains?limit=1000000"
            $res = Invoke-RestMethod -Method GET -Uri $url -Headers $headers
         }
    }
    
    end {
        return $res
    }
}