function Get-DefaultProxyCredentials(){
	$creds = $null
	# check if a proxy is required
	$explicitProxy = $env:chocolateyProxyLocation
	$explicitProxyUser = $env:chocolateyProxyUser
	$explicitProxyPassword = $env:chocolateyProxyPassword
	if ($explicitProxy -ne $null) {
		$passwd = ConvertTo-SecureString $explicitProxyPassword -AsPlainText -Force;
		$credentials = New-Object System.Management.Automation.PSCredential ($explicitProxyUser, $passwd);
		$creds1 = [Net.WebRequest]::DefaultWebProxy.Credentials
	}
	if ($creds -eq $null -and $creds1 -ne $null) {
		$creds = $creds1
	}
	$creds1 = [Net.WebRequest]::DefaultWebProxy.Credentials
	if ($creds -eq $null -and $creds1 -ne $null) {
		$creds = $creds1
	}
	$creds1 = [System.Net.WebRequest]::DefaultWebProxy.Credentials
	if ($creds -eq $null -and $creds1 -ne $null) {
		$creds = $creds1
	}
	$creds1 = [System.Net.CredentialCache]::DefaultCredentials
	if ($creds -eq $null -and $creds1 -ne $null) {
		$creds = $creds1
	}
	$creds1 = [net.CredentialCache]::DefaultCredentials
	if ($creds -eq $null -and $creds1 -ne $null) {
		$creds = $creds1
	}
	if ($creds -eq $null){
		Write-Debug "Default credentials were null. Attempting backup method"
		$creds1 = get-credential
		if ($creds -eq $null -and $creds1 -ne $null) {
			$creds = $creds1
		}
	}
	$creds
}
