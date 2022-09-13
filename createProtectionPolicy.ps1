### usage:
# ./createProtectionPolicy.ps1 -vip mycluster -username admin -password password -policyName mypolicy -daysToKeep 30 -replicateTo myremotecluster -copyPolicy policyToReplicate 
# Options:  -vip - name or IP of Cohesity cluster
#           -username: name of user to connect to Cohesity
#           -password: pasword to authenticate Cohesity
#           -policyName: name of the protection policy
#           -daysToKeep: (optional) no of days to retain the backup (default 14)
#           -replicateTo: replicate the backup to a remote cluster
#           -copypolicy: (optional) to clone/copy an existing policy

### process commandline arguments
[CmdletBinding()]
param (
    [Parameter(Mandatory = $True)][string]$vip, #Cohesity cluster to connect to
    [Parameter(Mandatory = $True)][string]$username, #Cohesity username
    [Parameter()][string]$domain = 'local', #Cohesity user domain name
    [Parameter(Mandatory = $True)][string]$policyName, #Name of the policy to manage
    [Parameter()][int]$daysToKeep = 14,
    [Parameter(Mandatory = $True)][string]$replicateTo,
    [Parameter()][string]$copyPolicy,
    [Parameter()][string]$password
)

### source the cohesity-api helper code
. ./cohesity-api

### authenticate
apiauth -vip $vip -username $username -password $password

if ($copyPolicy){
    $copyPolicies = api get protectionPolicies | Where-Object name -eq $copyPolicy
    if(! $copyPolicies){
        write-warning "policy $copyPolicy does not exists"
        exit
    } 
    $daysToKeep = $copyPolicies | Select-Object -ExpandProperty daysToKeep
    $retryIntervalMins =  $copyPolicies | Select-Object -ExpandProperty retryIntervalMins
    $retries =  $copyPolicies | Select-Object -ExpandProperty retries
    
} else {
    ## Setting default values
    #$daysToKeep = 14;
    $retryIntervalMins = 30;
    $retries = 3;
}

### get existing policies
$policies = api get protectionPolicies | Where-Object name -eq $policyName

### get remote clusters
$remotes = api get remoteClusters

$remote = $remotes | Where-Object { $_.name -eq $replicateTo }
if(! $remote){
    Write-Warning "Can't find remote cluster $replicateTo"
    exit
}

if($policies){
    write-warning "policy $policyName already exists"
    exit
}else{
    $newPolicy = @{
        'name' = $policyName;
        'incrementalSchedulingPolicy' = @{
            'periodicity' = 'kDaily';
            'dailySchedule' = @{
                'days' = @()
            }
        };
        'daysToKeep' = $daysToKeep;
        'retries' = $retries;
        'retryIntervalMins' = $retryIntervalMins;
        'blackoutPeriods' = @();
        'snapshotReplicationCopyPolicies' = @(
            @{
                'copyPartial' = $true;
                'daysToKeep' = $daysToKeep;
                'multiplier' = 1;
                'periodicity' = 'kEvery';
                'target' = @{
                    'clusterId' = $remote.clusterId;
                    'clusterName' = $remote.name
                }
            }
        );
        'snapshotArchivalCopyPolicies' = @();
        'cloudDeployPolicies' = @()
    }
    "creating policy $policyName..."
    $null = api post protectionPolicies $newPolicy
}

