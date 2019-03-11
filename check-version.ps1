$releaseVersionRegExp = '^20[1,2][0,9].[0-9]{2}.[0-9]{2}$'

$versionsInSource = (nuget-tree --onlyTopLevel) | Out-String;

$listComponentsToUpdate = @()

ForEach ($eachLine in $versionsInSource.split('\n')) {
    $PackageName, $PackageVersion = $eachLine.split(' ');
	
	if ($PackageName.IndexOf('****') -ne -1 -or $PackageName.IndexOf('****') -ne -1) {
		if ($PackageVersion.IndexOf('-alpha-master') -ne -1 -or !($PackageVersion -match $releaseVersionRegExp)) {
			$listComponentsToUpdate.Add($PackageName + ' ' + $PackageVersion);
		}
	}
}

if($listComponentsToUpdate.length -ne 0) {
	echo 'Please, update API with master or release version for next component(s):'
	
	ForEach($eachComponent in $listComponentsToUpdate) {
		echo '\t - ' + $eachComponent;
	}
	
	exit 1;
}

echo 'All API versions are correct';
exit 0;