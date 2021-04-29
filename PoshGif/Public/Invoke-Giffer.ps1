function Invoke-Giffer{
	param($Path)
	Import-Module FC_Log

$frameDupCounter = 7
$frames = Get-ChildItem $Path | where {$_.Extension -eq '.jpg'}
$frameCount = $frames | Measure-Object | Select-Object -ExpandProperty  Count
if($frameCount -eq 0){
    Write-Log "I did not load any files!" Error -ErrorAction Stop
}
$filename = "$Path\alldone.gif"

Add-Type -AssemblyName PresentationCore
add-type -AssemblyName system.drawing

try{
    $gif = New-Object -TypeName System.Windows.Media.Imaging.GifBitmapEncoder

    $frameCounter = 0;
    foreach ($frame in ($frames | Sort-Object BaseName)) {
        $frameCounter++
        Write-Log "Adding frame $frameCounter from file $($frame.Name)"

        $bmp = [System.Drawing.Bitmap]::FromFile($frame.fullname)
        $hbmp = $bmp.GetHbitMap()
        $bmpsrc = [System.Windows.Interop.Imaging]::CreateBitmapSourceFromHBitmap($hbmp, [System.IntPtr]::Zero, 'Empty', [System.Windows.Media.Imaging.BitmapSizeOptions]::FromEmptyOptions())
        foreach($i in 1..$frameDupCounter){
            Write-Log "Adding fluff frames" -tabLevel 1 Verbose
            $gif.Frames.Add([System.Windows.Media.Imaging.BitmapFrame]::Create($bmpsrc))
        }
        $hbmp = $bmp = $null

    }
    Write-Log "Setting it up to loop"
    $MemoryStream = New-Object System.IO.MemoryStream
    $gif.save($MemoryStream)
    $Bytes = $MemoryStream.ToArray()
    $applicationExtension = [byte[]](33, 255, 11, 78, 69, 84, 83, 67, 65, 80, 69, 50, 46, 48, 3, 1, 0, 0, 0 )
    $newBytes = New-Object -TypeName 'System.Collections.Generic.List[byte]'
    $newBytes.AddRange([byte[]]$bytes[0..12]);
    $newBytes.AddRange($applicationExtension);
    $newBytes.AddRange([byte[]]$bytes[13..($bytes.count)])

    Write-Log "Saving gif"
    [System.IO.File]::WriteAllBytes($filename, $newBytes.ToArray());
}
catch{throw}
finally{
    $MemoryStream.Flush()
    $MemoryStream.Dispose()
}  
 Write-Log 'All done'
 
}Export-ModuleMember -Function Invoke-Giffer