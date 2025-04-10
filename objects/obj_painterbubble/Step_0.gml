image_alpha = fade;
if global.PlayerPaletteIndex != savedPaletteIndex
{
    savedPaletteIndex = global.PlayerPaletteIndex;
    usePaletteThought = true;
    buffering = true;
    bufferCooldown = 0;
    typist.reset();
}

if (bufferCooldown > 0)
{
    bufferCooldown--;
    if (bufferCooldown <= 0)
    {
        buffering = false;
        if usePaletteThought
        {
            usePaletteThought = false;
            buffering = true;
            bufferCooldown = 180;
            typist.reset();
        }
    }
    if usePaletteThought
        typist.skip();
}
else if (buffering && typist.get_position() >= bufferLength)
{
    typist.skip();
    bufferCooldown = 180;
}
