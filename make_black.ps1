$file = 'bestblocktheme.com\mozini\index.html'
$content = Get-Content $file -Raw -Encoding UTF8

# Count occurrences before
$before0d0501 = ([regex]::Matches($content, '0d0501')).Count
$before130501 = ([regex]::Matches($content, '13, 5, 1')).Count
$before13501 = ([regex]::Matches($content, '13,5,1')).Count

Write-Output "Before: #0d0501 count = $before0d0501"
Write-Output "Before: rgba(13, 5, 1 count = $before130501"
Write-Output "Before: rgba(13,5,1 count = $before13501"

# Replace hex #0d0501 and 0d0501 (in CSS custom property values) → #000000 / 000000
$content = $content -replace '#0d0501', '#000000'
$content = $content -replace '#0D0501', '#000000'
$content = $content -replace '0d0501', '000000'

# Replace rgba(13, 5, 1, ...) → rgba(0, 0, 0, ...)
$content = $content -replace 'rgba\(13, 5, 1,', 'rgba(0, 0, 0,'
$content = $content -replace 'rgba\(13,5,1,', 'rgba(0, 0, 0,'

# Also replace rgb(13, 5, 1) → rgb(0, 0, 0)
$content = $content -replace 'rgb\(13, 5, 1\)', 'rgb(0, 0, 0)'

# Count occurrences after
$after0d0501 = ([regex]::Matches($content, '0d0501|0D0501')).Count
Write-Output "After: 0d0501 count = $after0d0501"

$content | Set-Content $file -Encoding UTF8 -NoNewline
Write-Output "Done. File saved."
