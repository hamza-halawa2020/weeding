Add-Type -AssemblyName System.Drawing
$canvas = [Drawing.Bitmap]::new(1200,630)
$graphics = [Drawing.Graphics]::FromImage($canvas)
$graphics.SmoothingMode = [Drawing.Drawing2D.SmoothingMode]::AntiAlias
$graphics.TextRenderingHint = [Drawing.Text.TextRenderingHint]::AntiAliasGridFit
$bounds = [Drawing.Rectangle]::new(0,0,1200,630)
$background = [Drawing.Drawing2D.LinearGradientBrush]::new($bounds,[Drawing.ColorTranslator]::FromHtml('#513240'),[Drawing.ColorTranslator]::FromHtml('#130e19'),90)
$graphics.FillRectangle($background,$bounds)
$gold = [Drawing.ColorTranslator]::FromHtml('#e8c995')
$goldPen = [Drawing.Pen]::new([Drawing.Color]::FromArgb(110,$gold),2)
$graphics.DrawEllipse($goldPen,-180,-220,460,460)
$graphics.DrawEllipse($goldPen,940,400,460,460)
$cardBrush = [Drawing.SolidBrush]::new([Drawing.ColorTranslator]::FromHtml('#392632'))
$graphics.FillRectangle($cardBrush,340,35,520,560)
$graphics.DrawRectangle($goldPen,340,35,520,560)
$graphics.DrawRectangle([Drawing.Pen]::new([Drawing.Color]::FromArgb(45,$gold)),350,45,500,540)
$format = [Drawing.StringFormat]::new()
$format.Alignment = [Drawing.StringAlignment]::Center
$format.LineAlignment = [Drawing.StringAlignment]::Center
$format.FormatFlags = [Drawing.StringFormatFlags]::DirectionRightToLeft
function Draw-CenteredText($label,$size,$y,$height,$color,$bold=$false) {
    $style = [Drawing.FontStyle]::Regular
    if ($bold) { $style = [Drawing.FontStyle]::Bold }
    $font = [Drawing.Font]::new('Arial',$size,$style,[Drawing.GraphicsUnit]::Pixel)
    $brush = [Drawing.SolidBrush]::new([Drawing.ColorTranslator]::FromHtml($color))
    $graphics.DrawString($label,$font,$brush,[Drawing.RectangleF]::new(350,$y,500,$height),$format)
    $brush.Dispose(); $font.Dispose()
}
Draw-CenteredText '❦' 35 52 46 '#e8c995'
Draw-CenteredText 'دعوة لحضور حفل زفافنا' 25 105 42 '#e4c6b9'
Draw-CenteredText 'يوسف وحفصة' 58 155 80 '#fff0df' $true
Draw-CenteredText 'فرحتنا تكمل بوجودكم ♥' 28 242 48 '#ddbca8'
$envelopeBounds = [Drawing.Rectangle]::new(445,320,310,170)
$envelopeBrush = [Drawing.Drawing2D.LinearGradientBrush]::new($envelopeBounds,[Drawing.ColorTranslator]::FromHtml('#edc2b4'),[Drawing.ColorTranslator]::FromHtml('#b87d8c'),45)
$graphics.FillRectangle($envelopeBrush,$envelopeBounds)
$flap = [Drawing.Point[]]@([Drawing.Point]::new(445,320),[Drawing.Point]::new(755,320),[Drawing.Point]::new(600,422))
$flapBrush = [Drawing.SolidBrush]::new([Drawing.ColorTranslator]::FromHtml('#f0d1be'))
$graphics.FillPolygon($flapBrush,$flap)
$graphics.DrawLine([Drawing.Pen]::new([Drawing.ColorTranslator]::FromHtml('#c39491')),445,490,548,402)
$graphics.DrawLine([Drawing.Pen]::new([Drawing.ColorTranslator]::FromHtml('#c39491')),755,490,652,402)
$sealBrush = [Drawing.SolidBrush]::new([Drawing.ColorTranslator]::FromHtml('#8f465a'))
$graphics.FillEllipse($sealBrush,570,390,60,60)
$graphics.DrawEllipse([Drawing.Pen]::new($gold,2),570,390,60,60)
Draw-CenteredText '♥' 28 390 60 '#f5d5a2'
$buttonBounds = [Drawing.Rectangle]::new(405,520,390,50)
$buttonBrush = [Drawing.Drawing2D.LinearGradientBrush]::new($buttonBounds,[Drawing.ColorTranslator]::FromHtml('#d6ad78'),[Drawing.ColorTranslator]::FromHtml('#f5dfb9'),0)
$graphics.FillRectangle($buttonBrush,$buttonBounds)
Draw-CenteredText 'اضغط على الظرف لفتح الدعوة' 24 520 50 '#492b37' $true
$canvas.Save((Join-Path $PSScriptRoot 'wedding-share-preview.png'),[Drawing.Imaging.ImageFormat]::Png)
$graphics.Dispose(); $canvas.Dispose(); $background.Dispose()
