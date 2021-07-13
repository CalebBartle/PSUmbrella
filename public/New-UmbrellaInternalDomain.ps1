function New-UmbrellaInternalDomain {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)][string]$domain,
        [Parameter(Mandatory = $false)][string]$description
    )
    
    begin {
        Get-UmbrellaKeys
        Write-Verbose -Message "Beginning to create Internal Domain: $domain"
        $headers = @{
            "Authorization" = "Basic $mgmtKey"
        }
        #Build Payload
        $body =@{
            "domain" = $domain
            "description" = $description
        }
    }
    
    process {
        $url = "https://management.api.umbrella.com/v1/organizations/$orgId/internaldomains"
        try{
            $res = Invoke-RestMethod -Uri $url -Headers $headers -Method POST -Body $body
        }catch{
            return $_
        }
    }
    
    end {
        return $res
    }
}