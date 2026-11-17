Add-Type -AssemblyName System.Drawing

$width = 1200
$height = 630
$bmp = New-Object System.Drawing.Bitmap($width, $height)
$g = [System.Drawing.Graphics]::FromImage($bmp)
$g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::AntiAlias
$g.TextRenderingHint = [System.Drawing.Text.TextRenderingHint]::AntiAlias

# خلفية تدرج بنفسجي فاتح
$bgBrush = New-Object System.Drawing.Drawing2D.LinearGradientBrush(
    [System.Drawing.Point]::new(0,0),
    [System.Drawing.Point]::new($width,$height),
    [System.Drawing.Color]::FromArgb(255,228,218,248),
    [System.Drawing.Color]::FromArgb(255,245,240,252))
$g.FillRectangle($bgBrush, 0, 0, $width, $height)

# دوائر زخرفية في الزوايا
$circlePen = New-Object System.Drawing.Pen([System.Drawing.Color]::FromArgb(50,155,126,200), 1.5)
$g.DrawEllipse($circlePen, -180, -180, 420, 420)
$g.DrawEllipse($circlePen, -220, -220, 500, 500)
$g.DrawEllipse($circlePen, $width-240, $height-240, 420, 420)
$g.DrawEllipse($circlePen, $width-280, $height-280, 500, 500)

# البطاقة المركزية
$cardX = 180; $cardY = 35; $cardW = 840; $cardH = 560
$cardBrush = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(255,252,249,255))
$g.FillRectangle($cardBrush, $cardX, $cardY, $cardW, $cardH)
$cardPen = New-Object System.Drawing.Pen([System.Drawing.Color]::FromArgb(160,155,126,200), 1.5)
$g.DrawRectangle($cardPen, $cardX, $cardY, $cardW, $cardH)
$innerPen = New-Object System.Drawing.Pen([System.Drawing.Color]::FromArgb(140,184,151,42), 1)
$g.DrawRectangle($innerPen, $cardX+12, $cardY+12, $cardW-24, $cardH-24)

$sf = New-Object System.Drawing.StringFormat
$sf.Alignment = [System.Drawing.StringAlignment]::Center
$sf.LineAlignment = [System.Drawing.StringAlignment]::Center

# ── ROW 1: زخرفة ❦  (Y=53)
$goldBrush = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(255,184,151,42))
$ornFont = New-Object System.Drawing.Font("Segoe UI Symbol", 20)
$g.DrawString([char]0x2766, $ornFont, $goldBrush, [System.Drawing.RectangleF]::new($cardX, 53, $cardW, 34), $sf)

# ── ROW 2: دعوة عقد قران  (Y=92)
$subFont = New-Object System.Drawing.Font("Arial", 19)
$purpleBrush = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(255,90,62,138))
$subText = [System.String]::new([char[]]@(0x062F,0x0639,0x0648,0x0629,0x0020,0x0639,0x0642,0x062F,0x0020,0x0642,0x0631,0x0627,0x0646))
$g.DrawString($subText, $subFont, $purpleBrush, [System.Drawing.RectangleF]::new($cardX, 92, $cardW, 38), $sf)

# ── ROW 3: حسام & مروة  (Y=132)
$nameFont = New-Object System.Drawing.Font("Arial", 80, [System.Drawing.FontStyle]::Bold)
$darkPurple = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(255,45,31,94))
$nameText = [System.String]::new([char[]]@(0x062D,0x0633,0x0627,0x0645)) + "  &  " + [System.String]::new([char[]]@(0x0645,0x0631,0x0648,0x0629))
$g.DrawString($nameText, $nameFont, $darkPurple, [System.Drawing.RectangleF]::new($cardX, 132, $cardW, 118), $sf)

# ── ROW 4: خط فاصل  (Y=258)
$linePen = New-Object System.Drawing.Pen([System.Drawing.Color]::FromArgb(180,184,151,42), 1.5)
$g.DrawLine($linePen, $cardX+310, 262, $cardX+530, 262)

# ── ROW 5: فرحتنا تكمل بوجودكم  (Y=270)
$msgFont = New-Object System.Drawing.Font("Arial", 18)
$midPurple = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(255,107,79,160))
$msgText = [System.String]::new([char[]]@(0x2665,0x0020,0x0641,0x0631,0x062D,0x062A,0x0646,0x0627,0x0020,0x062A,0x0643,0x0645,0x0644,0x0020,0x0628,0x0648,0x062C,0x0648,0x062F,0x0643,0x0645,0x0020,0x2665))
$g.DrawString($msgText, $msgFont, $midPurple, [System.Drawing.RectangleF]::new($cardX, 270, $cardW, 38), $sf)

# ── ROW 6: الظرف  (Y=315)
$envX = 490; $envY = 315; $envW = 220; $envH = 140

# جسم الظرف
$envBodyBrush = New-Object System.Drawing.Drawing2D.LinearGradientBrush(
    [System.Drawing.Point]::new($envX, $envY),
    [System.Drawing.Point]::new($envX+$envW, $envY+$envH),
    [System.Drawing.Color]::FromArgb(255,210,195,240),
    [System.Drawing.Color]::FromArgb(255,165,140,210))
$g.FillRectangle($envBodyBrush, $envX, $envY, $envW, $envH)

# غطاء الظرف (مثلث علوي)
$flapBrush = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(255,188,168,228))
$flapPts = [System.Drawing.Point[]]@(
    [System.Drawing.Point]::new($envX,          $envY),
    [System.Drawing.Point]::new($envX+$envW,    $envY),
    [System.Drawing.Point]::new($envX+[int]($envW/2), $envY+[int]($envH*0.52))
)
$g.FillPolygon($flapBrush, $flapPts)

# مثلثان جانبيان سفليان
$sideBrush = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(255,178,155,218))
$leftPts = [System.Drawing.Point[]]@(
    [System.Drawing.Point]::new($envX,       $envY),
    [System.Drawing.Point]::new($envX,       $envY+$envH),
    [System.Drawing.Point]::new($envX+[int]($envW/2), $envY+[int]($envH*0.52))
)
$rightPts = [System.Drawing.Point[]]@(
    [System.Drawing.Point]::new($envX+$envW, $envY),
    [System.Drawing.Point]::new($envX+$envW, $envY+$envH),
    [System.Drawing.Point]::new($envX+[int]($envW/2), $envY+[int]($envH*0.52))
)
$g.FillPolygon($sideBrush, $leftPts)
$g.FillPolygon($sideBrush, $rightPts)

# حدود الظرف
$envPen = New-Object System.Drawing.Pen([System.Drawing.Color]::FromArgb(160,120,100,185), 1.5)
$g.DrawRectangle($envPen, $envX, $envY, $envW, $envH)
$g.DrawPolygon($envPen, $flapPts)
$midX = $envX+[int]($envW/2); $midY = $envY+[int]($envH*0.52)
$g.DrawLine($envPen, $envX,       $envY+$envH, $midX, $midY)
$g.DrawLine($envPen, $envX+$envW, $envY+$envH, $midX, $midY)

# ختم ذهبي
$sealCX = $envX+[int]($envW/2); $sealCY = $envY+[int]($envH*0.65); $sealR = 22
$sealBrush = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(255,184,151,42))
$g.FillEllipse($sealBrush, $sealCX-$sealR, $sealCY-$sealR, $sealR*2, $sealR*2)
$heartFont = New-Object System.Drawing.Font("Arial", 13)
$whiteBrush = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::White)
$g.DrawString([char]0x2665, $heartFont, $whiteBrush, [System.Drawing.RectangleF]::new($sealCX-10, $sealCY-10, 20, 20), $sf)

# ── ROW 7: زر "اضغط على الظرف لفتح الدعوة"  (Y=490)
$btnX = $cardX+170; $btnY = 490; $btnW = $cardW-340; $btnH = 50
$btnBrush = New-Object System.Drawing.Drawing2D.LinearGradientBrush(
    [System.Drawing.Point]::new($btnX, $btnY),
    [System.Drawing.Point]::new($btnX+$btnW, $btnY+$btnH),
    [System.Drawing.Color]::FromArgb(255,184,151,42),
    [System.Drawing.Color]::FromArgb(255,220,188,78))
$g.FillRectangle($btnBrush, $btnX, $btnY, $btnW, $btnH)
$btnFont = New-Object System.Drawing.Font("Arial", 17)
$btnTextBrush = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(255,45,31,94))
$btnText = [System.String]::new([char[]]@(0x0627,0x0636,0x063A,0x0637,0x0020,0x0639,0x0644,0x0649,0x0020,0x0627,0x0644,0x0638,0x0631,0x0641,0x0020,0x0644,0x0641,0x062A,0x062D,0x0020,0x0627,0x0644,0x062F,0x0639,0x0648,0x0629))
$g.DrawString($btnText, $btnFont, $btnTextBrush, [System.Drawing.RectangleF]::new($btnX, $btnY, $btnW, $btnH), $sf)

$g.Dispose()
$bmp.Save("d:\hamza\weeding\wedding-share-preview.png", [System.Drawing.Imaging.ImageFormat]::Png)
$bmp.Dispose()
Write-Host "Done"
