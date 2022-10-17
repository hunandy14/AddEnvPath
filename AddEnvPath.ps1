# 新增環境變數
$__EnvPath_Default__ = $Env:Path
function Add-EnvPath {
    [CmdletBinding(DefaultParameterSetName = "A")]
    param(
        [Parameter(Position = 0, ParameterSetName = "A")]
        [string] $Path,
        [Parameter(Position = 0, ParameterSetName = "B")]
        [switch] $Reset
    )
    if ($Path) {
        if (($env:Path).IndexOf($Path) -eq -1) {
            if ($env:Path[-1] -ne ';') { $env:Path = $env:Path+';' }
            $env:Path = $env:Path + $Path
        }
    } elseif ($Reset) {
        $Env:Path = $__EnvPath_Default__
    } else {
        $p1=$__EnvPath_Default__.Split(';')
        $p2=$Env:Path.Split(';')
        $idx = 0
        $p1[0..$p1.Length]|ForEach-Object{
            $idx=$idx+1
            if ($idx -clt 10) {
                Write-Host "  [$idx]  $_"
            } else {
                Write-Host "  [$idx] $_"
            }
        }
        $p2[$p1.Length..$p2.Length]|ForEach-Object{
            $idx=$idx+1
            Write-Host "  [$idx] $_" -ForegroundColor:Yellow
        }
    }
} # Add-EnvPath "C:\Program Files\TeraCopy"