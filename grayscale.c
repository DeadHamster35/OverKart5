#include "../Library/MainInclude.h"
#include "OKInclude.h"

void grayscale()
{
    uint *framebuffer = (uint*)(g_CfbPtrs[g_DispFrame]);
    ushort average, average2;
    for (int Pass = 0; Pass < 38400; Pass++)
    {
        uint pixel = (uint)(framebuffer[Pass]);
        ushort red = (pixel >> 11) & 0x1F;
        ushort green = (pixel >> 6) & 0x1F;
        ushort blue = (pixel >> 1) & 0x1F;
        average = (red + green + blue + 15) / 4;    
        red = (pixel >> 27) & 0x1F;
        green = (pixel >> 22) & 0x1F;
        blue = (pixel >> 17) & 0x1F;
        average2 = (red + green + blue + 15) / 4;        

        framebuffer[Pass] = (uint)(
            (average & 0x1F)<<27 | (average & 0x1F)<<22 | (average & 0x1F)<<17 |
            (average2 & 0x1F)<<11 | (average2 & 0x1F)<<6 | (average2 & 0x1F)<<1
        );
    }
}
